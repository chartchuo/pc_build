import 'package:flutter/material.dart';
import 'package:pc_build/widgets/widgets.dart';

class PcPart extends StatelessWidget {
  final String image, title, subTitle, price;

  PcPart({Key key, this.image, this.title, this.subTitle, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: <Widget>[
        pcThumbnail(),
        pcCard(),
      ],
    ));
  }

  Widget pcCard() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color(0xbb333366),
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
      child: pcCardContent(),
    );
  }

  Widget pcThumbnail() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      alignment: FractionalOffset.centerLeft,
    );
  }

  Widget pcCardContent() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
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
        ],
      ),
    );
  }
}
