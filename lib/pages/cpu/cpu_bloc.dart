import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pc_build/models/cpu.dart';
import 'package:pc_build/models/part.dart';

abstract class CpuEvent extends Equatable {}

class LoadDataCpuEvent extends CpuEvent {
  @override
  List<Object> get props => const [];
}

class SearchCpuEvent extends CpuEvent {
  final String text;
  final bool enable;
  SearchCpuEvent({@required this.text, @required this.enable})
      : assert(text != null);
  @override
  List<Object> get props => [text];
}

class SortCpuEvent extends CpuEvent {
  final PartSort sortBy;
  SortCpuEvent({@required this.sortBy});

  @override
  List<Object> get props => [sortBy];
}

class SetFilterCpuEvent extends CpuEvent {
  final CpuFilter filter;
  SetFilterCpuEvent({@required this.filter});

  @override
  List<Object> get props => [filter];
}

abstract class CpuState extends Equatable {}

class LoadingCpuState extends CpuState {
  @override
  List<Object> get props => [];
}

class UpdatedCpuState extends CpuState {
  final List<Cpu> list;
  UpdatedCpuState({@required this.list}) : assert(list != null);

  @override
  List<Object> get props => [list.length, ...list.map((i) => i.id)];
}

class CpuBloc extends Bloc<CpuEvent, CpuState> {
  var _all = List<Cpu>();
  var _sort = PartSort.latest;
  String _searchString = '';
  bool _searchEnabled = false;
  CpuFilter _filter = CpuFilter();

  CpuBloc(CpuState initialState) : super(initialState);

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

var cpuBloc = CpuBloc(LoadingCpuState());
