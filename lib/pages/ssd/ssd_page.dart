import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pc_build/models/ssd.dart';
import 'ssd_filter.dart';
import 'package:pc_build/widgets/widgets.dart';

enum Sort {
  latest,
  lowPrice,
  highPrice,
}

class SsdPage extends StatefulWidget {
  @override
  _SsdPageState createState() => _SsdPageState();
}

class _SsdPageState extends State<SsdPage> {
  List<Ssd> all = [];
  List<Ssd> filtered = [];
  Sort sort = Sort.latest;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  SsdFilter filter = SsdFilter();

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
    prefs.setInt('ssdFilter.maxPrice', filter.maxPrice);
    prefs.setInt('ssdFilter.minprice', filter.minPrice);
    prefs.setStringList('ssdFilter.ssdBrand', filter.ssdBrand.toList());
    prefs.setStringList('ssdFilter.ssdCapacity', filter.ssdCapacity.toList());
    prefs.setStringList('ssdFilter.ssdInterface', filter.ssdInterface.toList());
  }

  Future<void> loadData() async {
    prefs = await SharedPreferences.getInstance();
    var maxPrice = prefs.getInt('ssdFilter.maxPrice');
    var minPrice = prefs.getInt('ssdFilter.minprice');
    if (maxPrice != null) filter.maxPrice = maxPrice;
    if (minPrice != null) filter.minPrice = minPrice;

    var ssdBrand = prefs.getStringList('ssdFilter.ssdBrand');
    var ssdCapacity = prefs.getStringList('ssdFilter.ssdCapacity');
    var ssdInterface = prefs.getStringList('ssdFilter.ssdInterface');
    if (ssdBrand != null) filter.ssdBrand = ssdBrand.toSet();
    if (ssdCapacity != null) filter.ssdCapacity = ssdCapacity.toSet();
    if (ssdInterface != null) filter.ssdInterface = ssdInterface.toSet();

    final store = await CacheStore.getInstance();
    File file = await store.getFile('https://www.advice.co.th/pc/get_comp/ssd');
    final jsonString = json.decode(file.readAsStringSync());
    setState(() {
      all.clear();
      jsonString.forEach((v) {
        final hdd = Ssd.fromJson(v);
        all.add(hdd);
      });
    });
    doFilter();
  }

  doFilter() {
    setState(() {
      filtered = filter.filters(all);
      if (searchString != '')
        filtered = filtered.where((v) {
          if (v.ssdBrand.toLowerCase().contains(searchString.toLowerCase()))
            return true;
          if (v.ssdModel.toLowerCase().contains(searchString.toLowerCase()))
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
      title: Text('SSD'),
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
    SsdFilter result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SsdFilterPage(
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
            image: 'https://www.advice.co.th/pic-pc/ssd/${v.ssdPicture}',
            title: v.ssdBrand,
            subTitle: v.ssdModel,
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
