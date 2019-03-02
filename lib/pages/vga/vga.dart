import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pc_build/models/vga.dart';
import 'vga_filter.dart';
import 'package:pc_build/widgets/widgets.dart';

enum Sort {
  latest,
  lowPrice,
  highPrice,
}

class VgaPage extends StatefulWidget {
  @override
  _VgaPageState createState() => _VgaPageState();
}

class _VgaPageState extends State<VgaPage> {
  List<Vga> allVgas = [];
  List<Vga> filteredVgas = [];
  Sort sort = Sort.latest;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  VgaFilter filter = VgaFilter();

  TextEditingController searchController = new TextEditingController();
  String searchString = '';
  String lastSearchString = '';
  bool showSearch = false;

  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    searchController.addListener(searchListener);
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
        if (searchController.text.length > 2) {
          searchString = searchController.text;
        } else {
          searchString = '';
        }
        doFilter();
      }
    });
  }

  saveData() {
    prefs.setInt('vgaFilter.maxPrice', filter.maxPrice);
    prefs.setInt('vgaFilter.minprice', filter.minPrice);
    prefs.setStringList('vgaFilter.vgaBrand', filter.vgaBrand.toList());
    prefs.setStringList('vgaFilter.vgaChipset', filter.vgaChipset.toList());
    prefs.setStringList('vgaFilter.vgaSeries', filter.vgaSeries.toList());
  }

  loadData() async {
    prefs = await SharedPreferences.getInstance();
    var maxPrice = prefs.getInt('vgaFilter.maxPrice');
    var minPrice = prefs.getInt('vgaFilter.minprice');
    if (maxPrice != null) filter.maxPrice = maxPrice;
    if (minPrice != null) filter.minPrice = minPrice;

    var vgaBrand = prefs.getStringList('vgaFilter.vgaBrand');
    var vgaChipset = prefs.getStringList('vgaFilter.vgaChipset');
    var vgaSeries = prefs.getStringList('vgaFilter.vgaSeries');
    if (vgaBrand != null) filter.vgaBrand = vgaBrand.toSet();
    if (vgaChipset != null) filter.vgaChipset = vgaChipset.toSet();
    if (vgaSeries != null) filter.vgaSeries = vgaSeries.toSet();

    final store = await CacheStore.getInstance();
    File file = await store.getFile('https://www.advice.co.th/pc/get_comp/vga');
    final jsonString = json.decode(file.readAsStringSync());
    setState(() {
      jsonString.forEach((v) {
        final vga = Vga.fromJson(v);
        // if (vga.advId != '' && vga.vgaPriceAdv != 0) {
        allVgas.add(vga);
        // }
      });
    });
    doFilter();
  }

  doFilter() {
    setState(() {
      filteredVgas = filter.filters(allVgas);
      if (searchString != '')
        filteredVgas = filteredVgas.where((v) {
          if (v.vgaBrand.toLowerCase().contains(searchString.toLowerCase()))
            return true;
          if (v.vgaModel.toLowerCase().contains(searchString.toLowerCase()))
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
        filteredVgas.sort((a, b) {
          return a.lowestPrice - b.lowestPrice;
        });
      } else if (sort == Sort.highPrice) {
        filteredVgas.sort((a, b) {
          return b.lowestPrice - a.lowestPrice;
        });
      } else {
        filteredVgas.sort((a, b) {
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarBuilder(context),
      body: bodyBuilder(),
    );
  }

  AppBar appBarBuilder(BuildContext context) {
    return AppBar(
      title: Text('VGA'),
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
    VgaFilter result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VgaFilterPage(
                  selectedFilter: filter,
                  allVgas: allVgas,
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
    return ListView.builder(
      itemCount: filteredVgas.length,
      itemBuilder: (context, i) {
        var v = filteredVgas[i];
        return DeviceTile(
          image: 'https://www.advice.co.th/pic-pc/vga/${v.vgaPicture}',
          title: v.vgaBrand,
          subTitle: v.vgaModel,
          price: v.lowestPrice,
        );
      },
    );
  }
}
