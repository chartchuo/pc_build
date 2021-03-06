import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'package:pc_build/models/mb.dart';
import 'package:pc_build/models/part.dart';

class MbState {
  var _all = List<Mb>();
  var _sort = PartSort.latest;
  String _searchString = '';
  bool _searchEnabled = false;
  MbFilter _filter = MbFilter();
  var _list = BehaviorSubject<List<Mb>>();

  Stream<List<Part>> get list => _list.stream
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
    var data = await http.get('https://www.advice.co.th/pc/get_comp/mb');
    final jsonString = json.decode(data.body);
    _all.clear();
    jsonString.forEach((v) {
      final mb = Mb.fromJson(v);
      _all.add(mb);
    });
    _update();
  }

  setFilter(MbFilter f) {
    _filter = f;
    _update();
  }

  search(String txt, bool enable) {
    _searchString = txt;
    _searchEnabled = enable;
    _update();
  }

  sort(PartSort s) {
    _sort = s;
    _update();
  }
}

var mbState = MbState();
