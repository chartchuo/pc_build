import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pc_build/models/vga.dart';
import 'package:pc_build/pages/vga_deail.dart';
import 'package:pc_build/pages/vga_filter.dart';

class VgaPage extends StatefulWidget {
  @override
  _VgaPageState createState() => _VgaPageState();
}

class _VgaPageState extends State<VgaPage> {
  List<Vga> allVgas = [];
  List<Vga> filteredVgas = [];

  String sortBy = 'เรียงลำดับล่าสุด'; //latest low2high high2low

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  VgaFilter vgaFilter = VgaFilter();

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
      vgaFilter.allBrands = allVgas.map((v) => v.vgaBrand).toSet();
      vgaFilter.selectedBrands = allVgas.map((v) => v.vgaBrand).toSet();
    });
    filterAction();
  }

  filterAction() {
    setState(() {
      filteredVgas.clear();
      // vgaFilter.selectedBrands.remove('GIGABYTE');
      allVgas.forEach((v) {
        if (vgaFilter.selectedBrands.contains(v.vgaBrand)) filteredVgas.add(v);
      });
    });
  }

  sortAction() {
    setState(() {
      if (sortBy == 'เรียงลำดับล่าสุด') {
        sortBy = 'เรียงลำดับถูกไปแพง';
        filteredVgas.sort((a, b) {
          return a.vgaPriceAdv - b.vgaPriceAdv;
        });
      } else if (sortBy == 'เรียงลำดับถูกไปแพง') {
        sortBy = 'เรียงลำดับแพงไปถูก';
        filteredVgas.sort((a, b) {
          return b.vgaPriceAdv - a.vgaPriceAdv;
        });
      } else {
        sortBy = 'เรียงลำดับล่าสุด';
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
            icon: Icon(Icons.refresh),
            tooltip: 'tempory call filter action',
            onPressed: () {
              filterAction();
            },
          ),
          IconButton(
            icon: Icon(Icons.tune),
            tooltip: 'Filter',
            onPressed: () {
              navigate2filterPage(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            tooltip: 'Sort',
            onPressed: () {
              sortAction();
              showMessage(sortBy);
            },
          ),
        ],
      ),
      body: bodyBuilder(),
    );
  }

  navigate2filterPage(BuildContext context) async {
    // vgaFilter.vgaBrands = ['ASUS'];
    VgaFilter result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VgaFilterPage(
                  vgaFilter: vgaFilter,
                )));
    // print('out');
    // print(result.selectedBrands);
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
