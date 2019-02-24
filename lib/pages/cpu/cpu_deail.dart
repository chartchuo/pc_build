import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pc_build/models/cpu.dart';

class CpuDetailPage extends StatelessWidget {
  final Cpu cpu;
  CpuDetailPage({Key key, this.cpu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var v = cpu;
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
                      'https://www.advice.co.th/pic-pc/cpu/${v.cpuPicture}',
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
