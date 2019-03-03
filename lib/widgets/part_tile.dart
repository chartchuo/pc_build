import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:pc_build/widgets/widgets.dart';

class PartTile extends StatelessWidget {
  final String image, title, subTitle;
  final int price;

  PartTile({Key key, this.image, this.title, this.subTitle, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Stack(
          children: <Widget>[
            deviceCard(),
            deviceThumbnail(),
          ],
        ));
  }

  Widget deviceCard() {
    return Container(
      height: 124.0,
      margin: EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
        color: Colors.white30,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: deviceCardContent(),
    );
  }

  Widget deviceThumbnail() {
    return Container(
      alignment: FractionalOffset.centerLeft,
      child: CachedNetworkImage(
        imageUrl: image,
        height: 120,
        width: 120,
      ),
    );
  }

  Widget deviceCardContent() {
    return Container(
      margin: EdgeInsets.fromLTRB(90.0, 16.0, 16.0, 16.0),
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: 4.0),
          Text(
            title == null ? '' : title,
            style: myTextStyle.header,
          ),
          Container(height: 10.0),
          Text(subTitle == null ? '' : subTitle, style: myTextStyle.subHeader),
          Container(height: 10.0),
          Text(
            price == null ? '' : '$price บาท',
            style: myTextStyle.price,
          )
        ],
      ),
    );
  }
}
