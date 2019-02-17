import 'package:flutter/material.dart';

import 'package:pc_build/pages/vga.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VgaPage(),
    );
  }
}
