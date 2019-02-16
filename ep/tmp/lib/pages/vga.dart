import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pc_build/models/vga.dart';

class VgaPage extends StatefulWidget {
  @override
  _VgaPageState createState() => _VgaPageState();
}

class _VgaPageState extends State<VgaPage> {
  List<Vga> vgas = [];

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
        if (vga.advId != '') {
          vgas.add(vga);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PC Build'),
      ),
      body: ListView.builder(
        itemCount: vgas.length,
        itemBuilder: (context, i) {
          var v = vgas[vgas.length - i - 1];
          return Card(
            elevation: 0,
            child: Container(
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(v),
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
                            Text('${v.vgaBrand} ${v.vgaModel}'),
                            Text('${v.vgaPriceAdv}'),
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
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Vga vga;
  DetailPage(this.vga);

  @override
  Widget build(BuildContext context) {
    var v = vga;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                height: 300,
                width: 300,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://www.advice.co.th/pic-pc/vga/${v.vgaPicture}',
                ),
              ),
            ),
            RaisedButton(
              child: Text('Back'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
