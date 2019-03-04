import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pc_build/models/cpu.dart';
import 'cpu_filter.dart';
import 'package:pc_build/widgets/widgets.dart';

enum Sort {
  latest,
  lowPrice,
  highPrice,
}

class CpuPage extends StatefulWidget {
  @override
  _CpuPageState createState() => _CpuPageState();
}

class _CpuPageState extends State<CpuPage> {
  List<Cpu> all = [];
  List<Cpu> filtered = [];
  Sort sort = Sort.latest;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  CpuFilter filter = CpuFilter();

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
    prefs.setInt('cpuFilter.maxPrice', filter.maxPrice);
    prefs.setInt('cpuFilter.minprice', filter.minPrice);
    prefs.setStringList('cpuFilter.cpuBrand', filter.brand.toList());
    prefs.setStringList('cpuFilter.cpuSocket', filter.socket.toList());
    prefs.setStringList('cpuFilter.cpuSeries', filter.series.toList());
  }

  Future<void> loadFilter() async {
    prefs = await SharedPreferences.getInstance();
    var maxPrice = prefs.getInt('cpuFilter.maxPrice');
    var minPrice = prefs.getInt('cpuFilter.minprice');
    if (maxPrice != null) filter.maxPrice = maxPrice;
    if (minPrice != null) filter.minPrice = minPrice;

    var cpuBrand = prefs.getStringList('cpuFilter.cpuBrand');
    var cpuSocket = prefs.getStringList('cpuFilter.cpuSocket');
    var cpuSeries = prefs.getStringList('cpuFilter.cpuSeries');
    if (cpuBrand != null) filter.brand = cpuBrand.toSet();
    if (cpuSocket != null) filter.socket = cpuSocket.toSet();
    if (cpuSeries != null) filter.series = cpuSeries.toSet();
  }

  Future<void> loadData() async {
    final store = await CacheStore.getInstance();
    File file = await store.getFile('https://www.advice.co.th/pc/get_comp/cpu');
    final jsonString = json.decode(file.readAsStringSync());
    setState(() {
      all.clear();
      jsonString.forEach((v) {
        final cpu = Cpu.fromJson(v);
        if (cpu.price != null) all.add(cpu);
      });
    });
    doFilter();
  }

  doFilter() {
    setState(() {
      filtered = filter.filters(all);
      if (searchString != '')
        filtered = filtered.where((v) {
          if (v.brand.toLowerCase().contains(searchString.toLowerCase()))
            return true;
          if (v.model.toLowerCase().contains(searchString.toLowerCase()))
            return true;
          return false;
        }).toList();
    });
    doSort(sort);
  }

  doSort(Sort s) {
    setState(() {
      sort = s;
      switch (sort) {
        case Sort.lowPrice:
          filtered.sort((a, b) {
            return a.price - b.price;
          });
          break;
        case Sort.highPrice:
          filtered.sort((a, b) {
            return b.price - a.price;
          });
          break;
        case Sort.latest:
          filtered.sort((a, b) {
            return b.id - a.id;
          });
          break;
        default:
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
      title: Text('CPU'),
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
          icon: Icon(Icons.sort),
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
    CpuFilter result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CpuFilterPage(
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
            image: v.picture,
            url: v.path,
            title: v.brand,
            subTitle: v.model,
            price: v.price,
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
