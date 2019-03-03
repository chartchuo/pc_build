import 'package:flutter/material.dart';

MyTextStyle myTextStyle = MyTextStyle();

class MyTextStyle {
  TextStyle base;
  TextStyle header;
  TextStyle regular;
  TextStyle subHeader;
  TextStyle price;

  init() {
    base = TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 14);
    regular = base.copyWith();

    header = base.copyWith(fontSize: 18.0, fontWeight: FontWeight.w600);
    subHeader = base.copyWith(fontWeight: FontWeight.w400);

    price =
        base.copyWith(color: Color(0xffffff00), fontWeight: FontWeight.w600);
  }

  MyTextStyle() {
    init();
  }
}

class MyBackgroundDecoration extends BoxDecoration {
  MyBackgroundDecoration()
      : super(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.pink.shade700,
              Colors.purple.shade700,
            ]));
}

class MyBackgroundDecoration2 extends BoxDecoration {
  MyBackgroundDecoration2()
      : super(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.green.shade700,
              Colors.blue.shade700,
            ]));
}

class MyBackgroundDecoration3 extends BoxDecoration {
  MyBackgroundDecoration3()
      : super(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.red.shade700,
              Colors.yellow.shade700,
            ]));
}
