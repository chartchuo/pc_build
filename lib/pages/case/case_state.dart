import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'package:pc_build/models/case.dart';
import 'package:pc_build/models/part.dart';

class CaseState {
  var _all = List<Case>();
  var _sort = PartSort.latest;
  String _searchString = '';
  bool _searchEnabled = false;
  CaseFilter _filter = CaseFilter();
  var _list = BehaviorSubject<List<Case>>();

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
    var data = await http.get('https://www.advice.co.th/pc/get_comp/case');
    final jsonString = json.decode(data.body);
    _all.clear();
    jsonString.forEach((v) {
      final cas = Case.fromJson(v);
      _all.add(cas);
    });
    _update();
  }

  setFilter(CaseFilter f) {
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

var caseState = CaseState();
