import 'package:flutter/material.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';

import 'package:pc_build/pages/vga.dart';

void main(List<String> args) {
  CacheStore.setPolicy(CacheControlPolicy(
    maxCount: 999,
    minAge: Duration(minutes: 30),
    maxAge: Duration(days: 1),
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VgaPage(),
    );
  }
}
