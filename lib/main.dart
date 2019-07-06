import 'package:flutter/material.dart';
import 'package:pc_build/pages/main/main_page.dart';

import 'package:pc_build/pages/cpu/cpu_page.dart';
import 'package:pc_build/pages/mb/mb_page.dart';
import 'package:pc_build/pages/vga/vga_page.dart';
import 'package:pc_build/pages/ram/ram_page.dart';
import 'package:pc_build/pages/hdd/hdd_page.dart';
import 'package:pc_build/pages/ssd/ssd_page.dart';
import 'package:pc_build/pages/psu/psu_page.dart';
import 'package:pc_build/pages/case/case_page.dart';
import 'package:pc_build/pages/cooling/cooling_page.dart';
import 'package:pc_build/pages/mon/mon_page.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return SlideRightRoute(widget: MainPage());
            break;
          case '/cpu':
            return SlideRightRoute(widget: CpuPage());
            break;
          case '/mb':
            return SlideRightRoute(widget: MbPage());
            break;
          case '/vga':
            return SlideRightRoute(widget: VgaPage());
            break;
          case '/ram':
            return SlideRightRoute(widget: RamPage());
            break;
          case '/hdd':
            return SlideRightRoute(widget: HddPage());
            break;
          case '/ssd':
            return SlideRightRoute(widget: SsdPage());
            break;
          case '/psu':
            return SlideRightRoute(widget: PsuPage());
            break;
          case '/case':
            return SlideRightRoute(widget: CasePage());
            break;
          case '/cooling':
            return SlideRightRoute(widget: CoolingPage());
            break;
          case '/mon':
            return SlideRightRoute(widget: MonPage());
            break;
          default:
            return SlideRightRoute(widget: MainPage());
        }
      },
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
