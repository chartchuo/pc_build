import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 66.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: new Center(
        child: new Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 36.0)),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [const Color(0xFF3366FF), const Color(0xFF00CCFF)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 0.5],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
