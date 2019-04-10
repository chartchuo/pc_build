import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';
import 'package:meta/meta.dart';

import 'package:pc_build/models/cpu.dart';
import 'package:pc_build/models/part.dart';


abstract class CpuEvent extends Equatable {
  CpuEvent([List props = const []]) : super(props);
}

class LoadDataCpuEvent extends CpuEvent {}

class SearchCpuEvent extends CpuEvent {
  final String text;
  final bool enable;
  SearchCpuEvent({@required this.text, @required this.enable})
      : assert(text != null),
        super([text, enable]);
}

class SortCpuEvent extends CpuEvent {
  final PartSort sort;
  SortCpuEvent({@required this.sort}) : super([sort]);
}

class SetFilterCpuEvent extends CpuEvent {
  final CpuFilter filter;
  SetFilterCpuEvent({@required this.filter}) : super([filter]);
}

abstract class CpuState extends Equatable {
  CpuState([List props = const []]) : super(props);
}

class CpuLoadingState extends CpuState {}

class CpuUpdatedState extends CpuState {
  final List<Cpu> list;
  CpuUpdatedState({@required this.list})
      : assert(list != null),
        super([list]);
}

class CpuBloc extends Bloc<CpuEvent, CpuState> {
  var _all = List<Cpu>();
  var _list = List<Cpu>();
  var _sort = PartSort.latest;
  String _searchString = '';
  bool _searchEnabled = false;
  CpuFilter _filter = CpuFilter();

  @override
  CpuState get initialState => CpuLoadingState();

  List<Cpu> get all => _all.toList();
  CpuFilter get filter => CpuFilter.clone(_filter);

  @override
  Stream<CpuState> mapEventToState(CpuEvent event) async* {
    if (event is LoadDataCpuEvent) {
      if (currentState is CpuLoadingState) yield CpuLoadingState();
      final store = await CacheStore.getInstance();
      File file =
          await store.getFile('https://www.advice.co.th/pc/get_comp/cpu');
      final jsonString = json.decode(file.readAsStringSync());
      _all.clear();
      jsonString.forEach((v) {
        final cpu = Cpu.fromJson(v);
        _all.add(cpu);
      });

      yield CpuUpdatedState(list: _updatedList());
    }

    if (event is SearchCpuEvent) {
      _searchString = event.text;
      _searchEnabled = event.enable;
      yield CpuUpdatedState(list: _updatedList());
    }

    if (event is SortCpuEvent) {
      _sort = event.sort;
      yield CpuUpdatedState(list: _updatedList());
    }

    if (event is SetFilterCpuEvent) {
      _filter = event.filter;
      yield CpuUpdatedState(list: _updatedList());
    }
  }

  List<Cpu> _updatedList() {
    _list = _filter.filters(_all);
    if (_searchEnabled) _list = partSearchMap(_list, _searchString);
    _list = partSortMap(_list, _sort);
    return _list;
  }
}

var cpuBloc = CpuBloc();
