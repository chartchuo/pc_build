import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:pc_build/pages/main/main_page.dart';

import 'package:pc_build/pages/cpu_bloc/cpu_page.dart';
import 'package:pc_build/pages/mb_rxdart/mb_page.dart';
import 'package:pc_build/pages/vga_rxdart/vga_page.dart';
import 'package:pc_build/pages/ram_rxdart/ram_page.dart';
import 'package:pc_build/pages/hdd_rxdart/hdd_page.dart';
import 'package:pc_build/pages/ssd_rxdart/ssd_page.dart';
import 'package:pc_build/pages/psu_rxdart/psu_page.dart';
import 'package:pc_build/pages/case_rxdart/case_page.dart';
import 'package:pc_build/pages/cooling_rxdart/cooling_page.dart';
import 'package:pc_build/pages/mon_rxdart/mon_page.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (_) => MainPage(),
        '/cpu': (_) => CpuPage(),
        '/mb': (_) => MbPage(),
        '/vga': (_) => VgaPage(),
        '/ram': (_) => RamPage(),
        '/hdd': (_) => HddPage(),
        '/ssd': (_) => SsdPage(),
        '/psu': (_) => PsuPage(),
        '/case': (_) => CasePage(),
        '/cooling': (_) => CoolingPage(),
        '/mon': (_) => MonPage(),
      },
    );
  }
}
