import 'package:flutter/material.dart';

import 'package:pc_build/models/pc.dart';

import 'package:pc_build/pages/cpu/cpu.dart';
import 'package:pc_build/pages/vga/vga.dart';

class PcPage extends StatefulWidget {
  @override
  _PcPageState createState() => _PcPageState();
}

class _PcPageState extends State<PcPage> {
  Pc pc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PC Builder'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Container(
              height: 100,
              child: InkWell(
                child: Text('CPU'),
                onTap: () => navigate2CpuPage(context),
              ),
            ),
          ),
          Card(
            child: Container(
              height: 100,
              child: InkWell(
                child: Text('VGA'),
                onTap: () => navigate2VgaPage(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  navigate2CpuPage(BuildContext context) async {
    CpuFilter result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CpuPage()));
    if (result != null) {}
  }

  navigate2VgaPage(BuildContext context) async {
    CpuFilter result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => VgaPage()));
    if (result != null) {}
  }
}
