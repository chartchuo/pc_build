import 'dart:convert';
import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';

import 'package:pc_build/models/cpu.dart';
import 'package:pc_build/models/part.dart';

class CpuState {
  var _all = List<Cpu>();
  var _sort = PartSort.latest;
  String _searchString = '';
  CpuFilter _filter = CpuFilter();
  var _list = BehaviorSubject<List<Cpu>>();

  Observable<List<Part>> get list => _list.stream
      .map((e) => _filter.filters(e))
      .map((e) => partSearchMap(e, _searchString))
      .map((e) => partSortMap(e, _sort));

  //tempory geter for filter page will delete when refactory filter page to rxdart
  get all => _all;
  get filter => _filter;

  _update() => _list.add(_all);

  Future<void> loadData() async {
    final store = await CacheStore.getInstance();
    File file = await store.getFile('https://www.advice.co.th/pc/get_comp/cpu');
    final jsonString = json.decode(file.readAsStringSync());
    _all.clear();
    jsonString.forEach((v) {
      final cpu = Cpu.fromJson(v);
      _all.add(cpu);
    });
    _update();
  }

  setFilter(CpuFilter f) {
    _filter = f;
    _update();
  }

  search(String txt) {
    _searchString = txt;
    _update();
  }

  sort(PartSort s) {
    _sort = s;
    _update();
  }
}

var cpuState = CpuState();
