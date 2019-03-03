import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pc_build/models/mon.dart';
import 'mon_filter.dart';
import 'package:pc_build/widgets/widgets.dart';

enum Sort {
  latest,
  lowPrice,
  highPrice,
}

class MonPage extends StatefulWidget {
  @override
  _MonPageState createState() => _MonPageState();
}

class _MonPageState extends State<MonPage> {
  List<Mon> all = [];
  List<Mon> filtered = [];
  Sort sort = Sort.latest;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  MonFilter filter = MonFilter();

  TextEditingController searchController = new TextEditingController();
  String searchString = '';
  String lastSearchString = '';
  bool showSearch = false;

  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    searchController.addListener(searchListener);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    loadData();
  }

  @override
  void dispose() {
    saveData();
    super.dispose();
  }

  searchListener() {
    setState(() {
      if (searchController.text != null) {
        if (searchController.text.length > 1) {
          searchString = searchController.text;
        } else {
          searchString = '';
        }
        doFilter();
      }
    });
  }

  saveData() {
    prefs.setInt('monFilter.maxPrice', filter.maxPrice);
    prefs.setInt('monFilter.minprice', filter.minPrice);
    prefs.setStringList('monFilter.monBrand', filter.monBrand.toList());
    prefs.setStringList('monFilter.monPanel2', filter.monPanel2.toList());
    prefs.setStringList('monFilter.monSize', filter.monSize.toList());
  }

  Future<void> loadData() async {
    prefs = await SharedPreferences.getInstance();
    var maxPrice = prefs.getInt('monFilter.maxPrice');
    var minPrice = prefs.getInt('monFilter.minprice');
    if (maxPrice != null) filter.maxPrice = maxPrice;
    if (minPrice != null) filter.minPrice = minPrice;

    var monBrand = prefs.getStringList('monFilter.monBrand');
    var monPanel2 = prefs.getStringList('monFilter.monPanel2');
    var monSize = prefs.getStringList('monFilter.monSize');
    if (monBrand != null) filter.monBrand = monBrand.toSet();
    if (monPanel2 != null) filter.monPanel2 = monPanel2.toSet();
    if (monSize != null) filter.monSize = monSize.toSet();

    final store = await CacheStore.getInstance();
    File file = await store.getFile('https://www.advice.co.th/pc/get_comp/mon');
    final jsonString = json.decode(file.readAsStringSync());
    setState(() {
      all.clear();
      jsonString.forEach((v) {
        final mon = Mon.fromJson(v);
        all.add(mon);
      });
    });
    doFilter();
  }

  doFilter() {
    setState(() {
      filtered = filter.filters(all);
      if (searchString != '')
        filtered = filtered.where((v) {
          if (v.monBrand.toLowerCase().contains(searchString.toLowerCase()))
            return true;
          if (v.monModel.toLowerCase().contains(searchString.toLowerCase()))
            return true;
          return false;
        }).toList();
    });
    doSort(sort);
  }

  doSort(Sort s) {
    setState(() {
      sort = s;
      if (sort == Sort.lowPrice) {
        filtered.sort((a, b) {
          return a.lowestPrice - b.lowestPrice;
        });
      } else if (sort == Sort.highPrice) {
        filtered.sort((a, b) {
          return b.lowestPrice - a.lowestPrice;
        });
      } else {
        filtered.sort((a, b) {
          return b.id - a.id;
        });
      }
    });
  }

  showMessage(String txt) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(txt),
      duration: Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    myTextStyle.init(); // call reinit text style to work with hot reload

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarBuilder(context),
      body: Container(
        decoration: MyBackgroundDecoration2(),
        child: bodyBuilder(),
      ),
    );
  }

  AppBar appBarBuilder(BuildContext context) {
    return AppBar(
      title: Text('Monitor'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () {
            setState(() {
              showSearch = !showSearch;
              if (!showSearch) {
                lastSearchString = searchString;
                searchController.clear();
              } else {
                searchController.text = lastSearchString;
              }
            });
          },
        ),
        IconButton(
          icon: Icon(
            Icons.tune,
            color: filtered.length == all.length ? Colors.white : Colors.pink,
          ),
          tooltip: 'Filter',
          onPressed: () {
            navigate2filterPage(context);
          },
        ),
        PopupMenuButton(
          onSelected: (v) => doSort(v),
          // icon: Icon(Icons.sort),
          icon: sort == Sort.highPrice
              ? Icon(Icons.arrow_upward)
              : sort == Sort.lowPrice
                  ? Icon(Icons.arrow_downward)
                  : Icon(Icons.sort),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text('Latest'),
                value: Sort.latest,
              ),
              PopupMenuItem(
                child: Text('Low price'),
                value: Sort.lowPrice,
              ),
              PopupMenuItem(
                child: Text('High price'),
                value: Sort.highPrice,
              ),
            ];
          },
        ),
      ],
    );
  }

  navigate2filterPage(BuildContext context) async {
    MonFilter result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MonFilterPage(
                  selectedFilter: filter,
                  all: all,
                )));
    if (result != null) {
      setState(() {
        filter = result;
      });
      doFilter();
    }
  }

  Widget bodyBuilder() {
    return Column(
      children: <Widget>[
        showSearch
            ? SearchField(searchController: searchController)
            : SizedBox(),
        Expanded(
          child: listBuilder(),
        ),
      ],
    );
  }

  Widget listBuilder() {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: loadData,
      child: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, i) {
          var v = filtered[i];
          return PartTile(
            image: 'https://www.advice.co.th/pic-pc/mon/${v.monPicture}',
            title: v.monBrand,
            subTitle: v.monModel,
            price: v.lowestPrice,
            index: i,
            onAdd: (i) {
              Navigator.pop(context, v);
            },
          );
        },
      ),
    );
  }
}
