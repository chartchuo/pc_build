import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pc_build/models/vga.dart';
import 'package:pc_build/pages/vga_deail.dart';
import 'package:pc_build/pages/vga_filter.dart';

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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  VgaFilter filter = VgaFilter();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final store = await CacheStore.getInstance();
    File file = await store.getFile('https://www.advice.co.th/pc/get_comp/vga');
    final jsonString = json.decode(file.readAsStringSync());
    setState(() {
      jsonString.forEach((v) {
        final vga = Vga.fromJson(v);
        if (vga.advId != '' && vga.vgaPriceAdv != 0) {
          allVgas.add(vga);
        }
      });
    });
    filterAction();
  }

  filterAction() {
    setState(() {
      filteredVgas = filter.filters(allVgas);
    });
  }

  sort(Sort sort) {
    setState(() {
      if (sort == Sort.lowPrice) {
        filteredVgas.sort((a, b) {
          return a.vgaPriceAdv - b.vgaPriceAdv;
        });
      } else if (sort == Sort.highPrice) {
        filteredVgas.sort((a, b) {
          return b.vgaPriceAdv - a.vgaPriceAdv;
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
      appBar: AppBar(
        title: Text('PC Build'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.tune),
            tooltip: 'Filter',
            onPressed: () {
              navigate2filterPage(context);
            },
          ),
          PopupMenuButton(
            onSelected: (v) => sort(v),
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
      ),
      body: bodyBuilder(),
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
      filterAction();
    }
  }

  Widget bodyBuilder() {
    return ListView.builder(
      itemCount: filteredVgas.length,
      itemBuilder: (context, i) {
        var v = filteredVgas[i];
        return Card(
          elevation: 0,
          child: Container(
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VgaDetailPage(vga: v),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://www.advice.co.th/pic-pc/vga/${v.vgaPicture}',
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${v.vgaBrand}'),
                          Text('${v.vgaModel}'),
                          Text('${v.vgaPriceAdv} บาท'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
