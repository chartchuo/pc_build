import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pc_build/models/mb.dart';
import 'mb_filter.dart';
import 'package:pc_build/widgets/widgets.dart';

enum Sort {
  latest,
  lowPrice,
  highPrice,
}

class MbPage extends StatefulWidget {
  @override
  _MbPageState createState() => _MbPageState();
}

class _MbPageState extends State<MbPage> {
  List<Mb> allMbs = [];
  List<Mb> filteredMbs = [];
  Sort sort = Sort.latest;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  MbFilter filter = MbFilter();

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
    prefs.setInt('mbFilter.maxPrice', filter.maxPrice);
    prefs.setInt('mbFilter.minprice', filter.minPrice);
    prefs.setStringList('mbFilter.mbBrand', filter.mbBrand.toList());
    prefs.setStringList('mbFilter.mbFactor', filter.mbFactor.toList());
    prefs.setStringList('mbFilter.mbSocket', filter.mbSocket.toList());
    prefs.setStringList('mbFilter.mbChipset', filter.mbChipset.toList());
  }

  Future<void> loadData() async {
    prefs = await SharedPreferences.getInstance();
    var maxPrice = prefs.getInt('mbFilter.maxPrice');
    var minPrice = prefs.getInt('mbFilter.minprice');
    if (maxPrice != null) filter.maxPrice = maxPrice;
    if (minPrice != null) filter.minPrice = minPrice;

    var mbBrand = prefs.getStringList('mbFilter.mbBrand');
    var mbFactor = prefs.getStringList('mbFilter.mbFactor');
    var mbSocket = prefs.getStringList('mbFilter.mbSocket');
    var mbChipset = prefs.getStringList('mbFilter.mbChipset');
    if (mbBrand != null) filter.mbBrand = mbBrand.toSet();
    if (mbFactor != null) filter.mbFactor = mbFactor.toSet();
    if (mbSocket != null) filter.mbSocket = mbSocket.toSet();
    if (mbChipset != null) filter.mbChipset = mbChipset.toSet();

    final store = await CacheStore.getInstance();
    File file = await store.getFile('https://www.advice.co.th/pc/get_comp/mb');
    final jsonString = json.decode(file.readAsStringSync());
    setState(() {
      allMbs.clear();
      jsonString.forEach((v) {
        final mb = Mb.fromJson(v);
        allMbs.add(mb);
      });
    });
    doFilter();
  }

  doFilter() {
    setState(() {
      filteredMbs = filter.filters(allMbs);
      if (searchString != '')
        filteredMbs = filteredMbs.where((v) {
          if (v.mbBrand.toLowerCase().contains(searchString.toLowerCase()))
            return true;
          if (v.mbModel.toLowerCase().contains(searchString.toLowerCase()))
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
        filteredMbs.sort((a, b) {
          return a.lowestPrice - b.lowestPrice;
        });
      } else if (sort == Sort.highPrice) {
        filteredMbs.sort((a, b) {
          return b.lowestPrice - a.lowestPrice;
        });
      } else {
        filteredMbs.sort((a, b) {
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
      title: Text('Main Board'),
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
          icon: Icon(Icons.tune),
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
    MbFilter result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MbFilterPage(
                  selectedFilter: filter,
                  allMbs: allMbs,
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
            ? TextField(
                decoration: InputDecoration(labelText: 'Search'),
                controller: searchController,
              )
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
        itemCount: filteredMbs.length,
        itemBuilder: (context, i) {
          var v = filteredMbs[i];
          return PartTile(
            image: 'https://www.advice.co.th/pic-pc/mb/${v.mbPicture}',
            title: v.mbBrand,
            subTitle: v.mbModel,
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
