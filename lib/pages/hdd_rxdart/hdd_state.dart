import 'dart:convert';
import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';

import 'package:pc_build/models/hdd.dart';
import 'package:pc_build/models/part.dart';

class HddState {
  var _all = List<Hdd>();
  var _sort = PartSort.latest;
  String _searchString = '';
  bool _searchEnabled = false;
  HddFilter _filter = HddFilter();
  var _list = BehaviorSubject<List<Hdd>>();

  Observable<List<Part>> get list => _list.stream
      .map((e) => _filter.filters(e))
      .map((e) => _searchEnabled ? partSearchMap(e, _searchString) : e)
      .map((e) => partSortMap(e, _sort));

  get searchEnable => _searchEnabled;
  get searchString => _searchString;
  //tempory geter for filter page will delete when refactory filter page to rxdart
  get all => _all;
  get filter => _filter;

  _update() => _list.add(_all);

  Future<void> loadData() async {
    final store = await CacheStore.getInstance();
    File file = await store.getFile('https://www.advice.co.th/pc/get_comp/hdd');
    final jsonString = json.decode(file.readAsStringSync());
    _all.clear();
    jsonString.forEach((v) {
      final hdd = Hdd.fromJson(v);
      _all.add(hdd);
    });
    _update();
  }

  setFilter(HddFilter f) {
    _filter = f;
    _update();
  }

  search(String txt, bool enable) {
    _searchString = txt;
    _searchEnabled = enable;
    _update();
    print('set $_searchEnabled $_searchString');
  }

  sort(PartSort s) {
    _sort = s;
    _update();
  }
}

var hddState = HddState();
