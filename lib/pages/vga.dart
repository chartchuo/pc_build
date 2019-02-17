import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pc_build/pages/vga_deail.dart';

class VgaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PC Build'),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VgaDetailPage(),
                )),
            child: Row(
              children: <Widget>[
                Container(
                  height: 150,
                  width: 150,
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://www.advice.co.th/pic-pc/vga/20160722-152517_1060asus.jpg",
                    placeholder: CircularProgressIndicator(),
                    errorWidget: Icon(Icons.error),
                  ),
                ),
                Text('$i'),
              ],
            ),
          );
        },
      ),
    );
  }
}
