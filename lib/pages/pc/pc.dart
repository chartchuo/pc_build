import 'package:flutter/material.dart';

import 'package:pc_build/models/pc.dart';

import 'package:pc_build/widgets/widgets.dart';
import 'package:pc_build/pages/cpu/cpu.dart';
import 'package:pc_build/pages/mb/mb.dart';
import 'package:pc_build/pages/vga/vga.dart';

import './pc_part.dart';

class PcPage extends StatefulWidget {
  @override
  _PcPageState createState() => _PcPageState();
}

class _PcPageState extends State<PcPage> {
  Pc pc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('PC Builder'),
      // ),
      body: Container(
        decoration: MyBackgroundDecoration(),
        child: ListView(
          children: <Widget>[
            GradientAppBar('PC Build'),
            InkWell(
              child: PcPart(
                title: 'CPU',
                subTitle: 'subtitle',
                price: '10,000 บาท',
              ),
              onTap: () => navigate2CpuPage(context),
            ),
            InkWell(
              child: PcPart(
                title: 'Mainboard',
                subTitle: 'subtitle',
                price: '10,000 บาท',
              ),
              onTap: () => navigate2MbPage(context),
            ),
            InkWell(
              child: PcPart(
                title: 'VGA',
                subTitle: 'subtitle',
                price: '10,000 บาท',
              ),
              onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPart(
                title: 'Memory',
                subTitle: 'subtitle',
                price: '10,000 บาท',
              ),
              // onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPart(
                title: 'Harddisk',
                subTitle: 'subtitle',
                price: '10,000 บาท',
              ),
              // onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPart(
                title: 'Solid state Drive',
                subTitle: 'subtitle',
                price: '10,000 บาท',
              ),
              // onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPart(
                title: 'Power Supply',
                subTitle: 'subtitle',
                price: '10,000 บาท',
              ),
              // onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPart(
                title: 'Case',
                subTitle: 'subtitle',
                price: '10,000 บาท',
              ),
              // onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPart(
                title: 'CPU Cooler',
                subTitle: 'subtitle',
                price: '10,000 บาท',
              ),
              // onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPart(
                title: 'Monitor',
                subTitle: 'subtitle',
                price: '10,000 บาท',
              ),
              // onTap: () => navigate2VgaPage(context),
            ),
          ],
        ),
      ),
    );
  }

  navigate2CpuPage(BuildContext context) async {
    CpuFilter result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CpuPage()));
    if (result != null) {}
  }

  navigate2MbPage(BuildContext context) async {
    CpuFilter result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MbPage()));
    if (result != null) {}
  }

  navigate2VgaPage(BuildContext context) async {
    CpuFilter result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => VgaPage()));
    if (result != null) {}
  }
}
