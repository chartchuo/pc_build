import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pc_build/models/vga.dart';

class VgaDetailPage extends StatelessWidget {
  final Vga vga;
  VgaDetailPage(this.vga);

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
