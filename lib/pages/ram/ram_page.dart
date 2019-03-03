import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pc_build/models/ram.dart';
import 'ram_filter.dart';
import 'package:pc_build/widgets/widgets.dart';

enum Sort {
  latest,
  lowPrice,
  highPrice,
}

class RamPage extends StatefulWidget {
  @override
  _RamPageState createState() => _RamPageState();
}

class _RamPageState extends State<RamPage> {
  List<Ram> all = [];
  List<Ram> filtered = [];
  Sort sort = Sort.latest;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  RamFilter filter = RamFilter();

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
    loadFilter();
  }

  @override
  void dispose() {
    saveFilter();
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

  saveFilter() {
    prefs.setInt('ramFilter.maxPrice', filter.maxPrice);
    prefs.setInt('ramFilter.minprice', filter.minPrice);
    prefs.setStringList('ramFilter.ramBrand', filter.ramBrand.toList());
    prefs.setStringList('ramFilter.ramType', filter.ramType.toList());
    prefs.setStringList('ramFilter.ramCapa', filter.ramCapa.toList());
    prefs.setStringList('ramFilter.ramBus', filter.ramBus.toList());
  }

  Future<void> loadFilter() async {
    prefs = await SharedPreferences.getInstance();
    var maxPrice = prefs.getInt('ramFilter.maxPrice');
    var minPrice = prefs.getInt('ramFilter.minprice');
    if (maxPrice != null) filter.maxPrice = maxPrice;
    if (minPrice != null) filter.minPrice = minPrice;

    var ramBrand = prefs.getStringList('ramFilter.ramBrand');
    var ramType = prefs.getStringList('ramFilter.ramType');
    var ramCapa = prefs.getStringList('ramFilter.ramCapa');
    var ramBus = prefs.getStringList('ramFilter.ramBus');
    if (ramBrand != null) filter.ramBrand = ramBrand.toSet();
    if (ramType != null) filter.ramType = ramType.toSet();
    if (ramCapa != null) filter.ramCapa = ramCapa.toSet();
    if (ramBus != null) filter.ramBus = ramBus.toSet();
  }

  Future<void> loadData() async {
    final store = await CacheStore.getInstance();
    File file = await store.getFile('https://www.advice.co.th/pc/get_comp/ram');
    final jsonString = json.decode(file.readAsStringSync());
    setState(() {
      all.clear();
      jsonString.forEach((v) {
        final ram = Ram.fromJson(v);
        all.add(ram);
      });
    });
    doFilter();
  }

  doFilter() {
    setState(() {
      filtered = filter.filters(all);
      if (searchString != '')
        filtered = filtered.where((v) {
          if (v.ramBrand.toLowerCase().contains(searchString.toLowerCase()))
            return true;
          if (v.ramModel.toLowerCase().contains(searchString.toLowerCase()))
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
      title: Text('Memory'),
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
    RamFilter result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RamFilterPage(
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
            image: 'https://www.advice.co.th/pic-pc/ram/${v.ramPicture}',
            url: v.advPath == null
                ? ''
                : 'https://www.advice.co.th/${v.advPath}',
            title: v.ramBrand,
            subTitle: v.ramModel,
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
