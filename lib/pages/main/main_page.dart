import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pc_build/models/pc.dart';

import 'package:pc_build/widgets/widgets.dart';
import 'package:pc_build/pages/cpu/cpu_page.dart';
import 'package:pc_build/pages/mb/mb_page.dart';
import 'package:pc_build/pages/vga/vga_page.dart';

import 'pc_part.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Pc pc = Pc();
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    saveData();
    super.dispose();
  }

  saveData() {
    print('save');
    print(jsonEncode(pc.cpu));
    prefs.setString('pc.cpu', jsonEncode(pc.cpu));
    prefs.setString('pc.mb', jsonEncode(pc.mb));
    prefs.setString('pc.vga', jsonEncode(pc.vga));
    prefs.setString('pc.ram', jsonEncode(pc.ram));
    prefs.setString('pc.hd', jsonEncode(pc.hd));
    prefs.setString('pc.ssd', jsonEncode(pc.ssd));
    prefs.setString('pc.ps', jsonEncode(pc.ps));
    prefs.setString('pc.pc_case', jsonEncode(pc.pcCase));
    prefs.setString('pc.cpu_cooler', jsonEncode(pc.cpuCooler));
    prefs.setString('pc.monitor', jsonEncode(pc.monitor));
  }

  PcPart loadPart(SharedPreferences prefs, String key) {
    String str;
    str = prefs.getString(key);
    if (str == null) {
      return PcPart();
    } else {
      return PcPart.fromJson(jsonDecode(str));
    }
  }

  loadData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      pc.cpu = loadPart(prefs, 'pc.cpu');
      pc.mb = loadPart(prefs, 'pc.mb');
      pc.vga = loadPart(prefs, 'pc.vga');
      pc.ram = loadPart(prefs, 'pc.ram');
      pc.hd = loadPart(prefs, 'pc.hd');
      pc.ssd = loadPart(prefs, 'pc.ssd');
      pc.ps = loadPart(prefs, 'pc.ps');
      pc.pcCase = loadPart(prefs, 'pc.pc_case');
      pc.cpuCooler = loadPart(prefs, 'pc.cpu_cooler');
      pc.monitor = loadPart(prefs, 'pc.monitor');

      pc.initTitle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PC Builder'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: MyBackgroundDecoration(),
        padding: EdgeInsets.all(4),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: <Widget>[
            InkWell(
              child: PcPartCard(part: pc.cpu),
              onTap: () => navigate2CpuPage(context),
            ),
            InkWell(
              child: PcPartCard(part: pc.mb),
              onTap: () => navigate2MbPage(context),
            ),
            InkWell(
              child: PcPartCard(part: pc.vga),
              onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPartCard(part: pc.ram),
              // onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPartCard(part: pc.hd),
              // onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPartCard(part: pc.ssd),
              // onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPartCard(part: pc.ps),
              // onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPartCard(part: pc.pcCase),
              // onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPartCard(part: pc.cpuCooler),
              // onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPartCard(part: pc.monitor),
              // onTap: () => navigate2VgaPage(context),
            ),
          ],
        ),
      ),
    );
  }

  navigate2CpuPage(BuildContext context) async {
    Cpu result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CpuPage()));
    if (result != null) {
      setState(() {
        pc.cpu.id = result.id;
        pc.cpu.brandModel = result.cpuBrand + ' ' + result.cpuModel;
        pc.cpu.picture =
            'https://www.advice.co.th/pic-pc/cpu/${result.cpuPicture}';
        pc.cpu.price = result.lowestPrice;
        saveData();
      });
    }
  }

  navigate2MbPage(BuildContext context) async {
    Mb result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MbPage()));
    if (result != null) {
      setState(() {
        pc.mb.id = result.id;
        pc.mb.brandModel = result.mbBrand + ' ' + result.mbModel;
        pc.mb.picture =
            'https://www.advice.co.th/pic-pc/mb/${result.mbPicture}';
        pc.mb.price = result.lowestPrice;
        saveData();
      });
    }
  }

  navigate2VgaPage(BuildContext context) async {
    Vga result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => VgaPage()));
    if (result != null) {
      setState(() {
        pc.vga.id = result.id;
        pc.vga.brandModel = result.vgaBrand + ' ' + result.vgaModel;
        pc.vga.picture =
            'https://www.advice.co.th/pic-pc/vga/${result.vgaPicture}';
        pc.vga.price = result.lowestPrice;
        saveData();
      });
    }
  }
}
