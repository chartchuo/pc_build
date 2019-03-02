import 'package:flutter/material.dart';
import 'package:pc_build/widgets/widgets.dart';

class PcPart extends StatelessWidget {
  final String image, title, subTitle, price;

  PcPart({Key key, this.image, this.title, this.subTitle, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            pcCard(),
            pcThumbnail(),
          ],
        ));
  }

  Widget pcCard() {
    return Container(
      // constraints: new BoxConstraints.expand(),
      height: 124.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
      child: pcCardContent(),
    );
  }

  Widget pcThumbnail() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: CircleAvatar(
        backgroundImage: image == null ? null : NetworkImage(image),
        maxRadius: 46,
        minRadius: 46,
      ),
    );
  }

  Widget pcCardContent() {
    return Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(
            title == null ? '' : title,
            style: headerTextStyle,
          ),
          new Container(height: 10.0),
          new Text(subTitle == null ? '' : subTitle, style: subHeaderTextStyle),
        ],
      ),
    );
  }
}
