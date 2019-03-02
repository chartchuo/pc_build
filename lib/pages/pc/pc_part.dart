import 'package:flutter/material.dart';
import 'package:pc_build/widgets/widgets.dart';

class PcPart extends StatelessWidget {
  final String image, title, subTitle, price;

  PcPart({Key key, this.image, this.title, this.subTitle, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: <Widget>[
            pcCard(),
            pcThumbnail(),
          ],
        ));
  }

  Widget pcCard() {
    return Container(
      // constraints: BoxConstraints.expand(),
      height: 124.0,
      margin: EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
        color: Color(0xFF333366),
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
      margin: EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      // child: CircleAvatar(
      //   backgroundImage: image == null ? null : NetworkImage(image),
      //   maxRadius: 46,
      //   minRadius: 46,
      // ),
    );
  }

  Widget pcCardContent() {
    return Container(
      margin: EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: 4.0),
          Text(
            title == null ? '' : title,
            style: headerTextStyle,
          ),
          Container(height: 10.0),
          Text(subTitle == null ? '' : subTitle, style: subHeaderTextStyle),
        ],
      ),
    );
  }
}
