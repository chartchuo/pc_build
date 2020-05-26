import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
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
  final PartSort sortBy;
  SortCpuEvent({@required this.sortBy}) : super([sortBy]);
}

class SetFilterCpuEvent extends CpuEvent {
  final CpuFilter filter;
  SetFilterCpuEvent({@required this.filter}) : super([filter]);
}

abstract class CpuState extends Equatable {
  CpuState([List props = const []]) : super(props);
}

class LoadingCpuState extends CpuState {}

class UpdatedCpuState extends CpuState {
  final List<Cpu> list;
  UpdatedCpuState({@required this.list})
      : assert(list != null),
        super([list.length, ...list.map((i) => i.id)]);
}

class CpuBloc extends Bloc<CpuEvent, CpuState> {
  var _all = List<Cpu>();
  var _sort = PartSort.latest;
  String _searchString = '';
  bool _searchEnabled = false;
  CpuFilter _filter = CpuFilter();

  @override
  CpuState get initialState => LoadingCpuState();

  bool get searchEnable => _searchEnabled;
  String get searchString => _searchString;

  CpuFilter get filter => CpuFilter.clone(_filter);
  List<Cpu> get all => _all.toList();

  @override
  Stream<CpuState> mapEventToState(CpuEvent event) async* {
    if (event is LoadDataCpuEvent) {
      yield LoadingCpuState();

      var data = await http.get('https://www.advice.co.th/pc/get_comp/cpu');
      final jsonString = json.decode(data.body);
      _all.clear();
      jsonString.forEach((v) {
        final cpu = Cpu.fromJson(v);
        _all.add(cpu);
      });

      yield UpdatedCpuState(list: _updatedList());
    }

    if (event is SearchCpuEvent) {
      _searchString = event.text;
      _searchEnabled = event.enable;
      yield UpdatedCpuState(list: _updatedList());
    }
    if (event is SortCpuEvent) {
      _sort = event.sortBy;
      yield UpdatedCpuState(list: _updatedList());
    }
    if (event is SetFilterCpuEvent) {
      _filter = event.filter;
      yield UpdatedCpuState(list: _updatedList());
    }
  }

  List<Cpu> _updatedList() {
    var _list = _filter.filters(_all);
    if (_searchEnabled) _list = partSearchMap(_list, _searchString);
    _list = partSortMap(_list, _sort);
    return _list;
  }
}

var cpuBloc = CpuBloc();
