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
    prefs.setInt('cpuFilter.maxPrice', filter.maxPrice);
    prefs.setInt('cpuFilter.minprice', filter.minPrice);
    prefs.setStringList('cpuFilter.cpuBrand', filter.cpuBrand.toList());
    prefs.setStringList('cpuFilter.cpuSocket', filter.cpuSocket.toList());
    prefs.setStringList('cpuFilter.cpuSeries', filter.cpuSeries.toList());
  }

  Future<void> loadData() async {
    prefs = await SharedPreferences.getInstance();
    var maxPrice = prefs.getInt('cpuFilter.maxPrice');
    var minPrice = prefs.getInt('cpuFilter.minprice');
    if (maxPrice != null) filter.maxPrice = maxPrice;
    if (minPrice != null) filter.minPrice = minPrice;

    var cpuBrand = prefs.getStringList('cpuFilter.cpuBrand');
    var cpuSocket = prefs.getStringList('cpuFilter.cpuSocket');
    var cpuSeries = prefs.getStringList('cpuFilter.cpuSeries');
    if (cpuBrand != null) filter.cpuBrand = cpuBrand.toSet();
    if (cpuSocket != null) filter.cpuSocket = cpuSocket.toSet();
    if (cpuSeries != null) filter.cpuSeries = cpuSeries.toSet();

    final store = await CacheStore.getInstance();
    File file = await store.getFile('https://www.advice.co.th/pc/get_comp/cpu');
    final jsonString = json.decode(file.readAsStringSync());
    setState(() {
      all.clear();
      jsonString.forEach((v) {
        final cpu = Cpu.fromJson(v);
        all.add(cpu);
      });
    });
    doFilter();
  }

  doFilter() {
    setState(() {
      filtered = filter.filters(all);
      if (searchString != '')
        filtered = filtered.where((v) {
          if (v.cpuBrand.toLowerCase().contains(searchString.toLowerCase()))
            return true;
          if (v.cpuModel.toLowerCase().contains(searchString.toLowerCase()))
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
            image: 'https://www.advice.co.th/pic-pc/cpu/${v.cpuPicture}',
            title: v.cpuBrand,
            subTitle: v.cpuModel,
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
