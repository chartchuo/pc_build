import 'dart:convert';
import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';

import 'package:pc_build/models/cpu.dart';
import 'package:pc_build/models/part.dart';

enum Sort {
  latest,
  lowPrice,
  highPrice,
}

class CpuState {
  var _all = List<Cpu>();
  var _filtered = List<Cpu>();
  var _sort = Sort.latest;
  String _searchString = '';
  CpuFilter _filter = CpuFilter();
  var _list = BehaviorSubject<List<Cpu>>();

  Observable<List<Part>> get list => _list.stream;

  //tempory geter for filter page will delete in future factory
  set setFilter(CpuFilter f) => _filter = f;
  get all => _all;
  get filter => _filter;

  Future<void> loadData() async {
    final store = await CacheStore.getInstance();
    File file = await store.getFile('https://www.advice.co.th/pc/get_comp/cpu');
    final jsonString = json.decode(file.readAsStringSync());
    _all.clear();
    jsonString.forEach((v) {
      final cpu = Cpu.fromJson(v);
      _all.add(cpu);
    });
    doFilter();
    _list.add(_filtered);
  }

  doFilter() {
    _doFilter();
    _doSort(_sort);
    _list.add(_filtered);
  }

  _doFilter() {
    _filtered = _filter.filters(_all);
    if (_searchString != '')
      _filtered = _filtered.where((v) {
        if (v.brand.toLowerCase().contains(_searchString.toLowerCase()))
          return true;
        if (v.model.toLowerCase().contains(_searchString.toLowerCase()))
          return true;
        return false;
      }).toList();
  }

  doSearch(String txt) {
    _searchString = txt;
    _doFilter();
    _doSort(_sort);
    _list.add(_filtered);
  }

  doSort(Sort s) {
    _doSort(s);
    _list.add(_filtered);
  }

  _doSort(Sort s) {
    _sort = s;
    switch (_sort) {
      case Sort.lowPrice:
        _filtered.sort((a, b) {
          return a.price - b.price;
        });
        break;
      case Sort.highPrice:
        _filtered.sort((a, b) {
          return b.price - a.price;
        });
        break;
      case Sort.latest:
        _filtered.sort((a, b) {
          return b.id - a.id;
        });
        break;
      default:
    }
  }
}

var cpuState = CpuState();
