import 'package:flutter/material.dart';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'package:pc_build/widgets/widgets.dart';
import 'webview.dart';

class PartTile extends StatelessWidget {
  final String image, title, subTitle, url;
  final int price;
  final int index;
  final ValueChanged<int> onAdd;

  PartTile(
      {Key key,
      this.image,
      this.title,
      this.subTitle,
      this.url,
      this.price,
      this.index,
      this.onAdd})
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
            deviceThumbnail(context),
            addIcon(),
            urlIcon(context),
          ],
        ));
  }

  Widget deviceCard() {
    return Container(
      height: 140.0,
      margin: EdgeInsets.only(left: 50.0),
      padding: EdgeInsets.only(right: 32.0),
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

  Widget urlIcon(BuildContext context) {
    if (url == null || url == '') return SizedBox();
    return Container(
      height: 140,
      alignment: FractionalOffset.bottomLeft,
      child: IconButton(
        // iconSize: 32,
        tooltip: 'Web',
        icon: Icon(
          Icons.public,
          color: Colors.white54,
        ),
        onPressed: () {
          navigate2Webview(context);
        },
      ),
    );
  }

  Widget addIcon() {
    return Container(
      height: 140,
      alignment: FractionalOffset.centerRight,
      child: IconButton(
        iconSize: 32,
        tooltip: 'Add',
        icon: Icon(
          Icons.add_box,
          color: Colors.white54,
        ),
        onPressed: () {
          if (onAdd != null) onAdd(index);
        },
      ),
    );
  }

  Widget deviceThumbnail(BuildContext context) {
    return InkWell(
      child: Container(
        height: 140,
        alignment: FractionalOffset.centerLeft,
        // child: CachedNetworkImage(
        //   imageUrl: image,
        //   height: 120,
        //   width: 120,
        // ),
        child:
            Image.network(image, fit: BoxFit.contain, height: 120, width: 120),
      ),
      onTap: () {
        // navigate2Webview(context);
      },
    );
  }

  Widget deviceCardContent() {
    return Container(
      margin: EdgeInsets.fromLTRB(90.0, 16.0, 16.0, 16.0),
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 4.0),
          Text(
            title == null ? '' : title,
            style: myTextStyle.header,
            overflow: TextOverflow.fade,
            maxLines: 1,
          ),
          SizedBox(height: 10.0),
          Text(
            subTitle == null ? '' : subTitle,
            style: myTextStyle.subHeader,
            overflow: TextOverflow.fade,
            maxLines: 2,
          ),
          SizedBox(height: 10.0),
          Text(
            price == null
                ? ''
                : FlutterMoneyFormatter(amount: price.toDouble())
                        .output
                        .withoutFractionDigits +
                    ' \u{0e3f}',
            style: myTextStyle.price,
          ),
        ],
      ),
    );
  }

  navigate2Webview(BuildContext context) async {
    if (url == null || url == '') return;
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebviewPage(
                  title: subTitle,
                  url: url,
                )));
  }
}
