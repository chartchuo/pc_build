import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'package:pc_build/widgets/widgets.dart';
import 'package:pc_build/widgets/webview.dart';
import 'package:pc_build/models/pc.dart';

typedef Callback = void Function();

class PcPartCard extends StatelessWidget {
  final PcPart part;
  final Callback onDelete;
  final Callback onAdd;
  final Callback onSub;

  PcPartCard({Key key, this.part, this.onDelete, this.onAdd, this.onSub})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (part.id == null) {
      return Container(
          child: Stack(
        children: <Widget>[
          pcCard(),
          addIcon(),
          pcCardTitle(),
        ],
      ));
    }
    return Container(
        child: Stack(
      children: <Widget>[
        pcCard(),
        pcThumbnail(),
        pcCardTitle(),
        pcCardContent(),
        deleteIcon(),
        // qty(),
        add(),
        sub(),
        // urlIcon(context),
      ],
    ));
  }

  Widget urlIcon(BuildContext context) {
    if (part.url == null || part.url == '') return SizedBox();
    return Container(
      alignment: FractionalOffset.centerRight,
      child: IconButton(
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

  Widget deleteIcon() {
    return Container(
      alignment: FractionalOffset.topRight,
      constraints: BoxConstraints.expand(),
      child: IconButton(
        icon: Icon(Icons.delete_outline),
        color: Colors.white70,
        onPressed: () {
          onDelete();
        },
      ),
    );
  }

  Widget add() {
    if (part == null || part.multiple == null || !part.multiple) {
      return SizedBox();
    }
    return Container(
        alignment: FractionalOffset.bottomRight,
        constraints: BoxConstraints.expand(),
        child: IconButton(
          icon: Icon(Icons.add_circle_outline),
          color: Colors.white70,
          onPressed: () {
            onAdd();
          },
        ));
  }

  Widget sub() {
    if (part == null || part.multiple == null || !part.multiple) {
      return SizedBox();
    }
    return Container(
      alignment: FractionalOffset.bottomLeft,
      constraints: BoxConstraints.expand(),
      child: IconButton(
        icon: Icon(Icons.remove_circle_outline),
        color: Colors.white70,
        onPressed: part.qty == 1
            ? null
            : () {
                onSub();
              },
      ),
    );
  }

  Widget addIcon() {
    return Container(
      alignment: FractionalOffset.center,
      constraints: BoxConstraints.expand(),
      child: Center(
        child: Icon(
          Icons.add_box,
          color: Colors.white12,
          size: 64,
        ),
      ),
    );
  }

  Widget pcCard() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color(0xaa333366),
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
    );
  }

  Widget pcThumbnail() {
    return Container(
      alignment: FractionalOffset.center,
      margin: EdgeInsets.fromLTRB(16, 20, 16, 48),
      child: part.picture == null
          ? null
          : CachedNetworkImage(imageUrl: part.picture),
    );
  }

  Widget pcCardContent() {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            part.brandModel == null ? '' : part.brandModel,
            style: myTextStyle.subHeader.copyWith(color: Colors.white),
            textAlign: TextAlign.right,
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.fade,
          ),
          SizedBox(height: 4),
          Text(
            part.price == null
                ? ''
                : FlutterMoneyFormatter(amount: part.price.toDouble())
                        .output
                        .withoutFractionDigits +
                    ' \u{0e3f}' +
                    (part.qty > 1 ? ' x${part.qty}' : ''),
            style: myTextStyle.price,
          ),
        ],
      ),
    );
  }

  Widget pcCardTitle() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
      constraints: BoxConstraints.expand(),
      child: Text(
        part.title == null ? '' : part.title,
        style: myTextStyle.header,
      ),
    );
  }

  navigate2Webview(BuildContext context) async {
    if (part.url == null || part.url == '') return;
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Webview(
                  title: part.brandModel,
                  url: part.url,
                )));
  }
}
