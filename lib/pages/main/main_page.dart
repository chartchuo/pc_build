import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pc_build/models/pc.dart';

import 'package:pc_build/widgets/widgets.dart';
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
    prefs.setString('pc.hdd', jsonEncode(pc.hdd));
    prefs.setString('pc.ssd', jsonEncode(pc.ssd));
    prefs.setString('pc.psu', jsonEncode(pc.psu));
    prefs.setString('pc.cas', jsonEncode(pc.cas));
    prefs.setString('pc.cooling', jsonEncode(pc.cooling));
    prefs.setString('pc.mon', jsonEncode(pc.mon));
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
      pc.hdd = loadPart(prefs, 'pc.hdd');
      pc.ssd = loadPart(prefs, 'pc.ssd');
      pc.psu = loadPart(prefs, 'pc.psu');
      pc.cas = loadPart(prefs, 'pc.cas');
      pc.cooling = loadPart(prefs, 'pc.cooling');
      pc.mon = loadPart(prefs, 'pc.mon');

      pc.initTitle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PC Builder (total ${pc.totalPriceStr()})'),
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
              child: PcPartCard(
                part: pc.cpu,
                onDelete: () {
                  setState(() {
                    pc.cpu = PcPart();
                    pc.initTitle();
                  });
                },
              ),
              onTap: () => navigate2CpuPage(context),
            ),
            InkWell(
              child: PcPartCard(
                part: pc.mb,
                onDelete: () {
                  setState(() {
                    pc.mb = PcPart();
                    pc.initTitle();
                  });
                },
              ),
              onTap: () => navigate2MbPage(context),
            ),
            InkWell(
              child: PcPartCard(
                part: pc.vga,
                onDelete: () {
                  setState(() {
                    pc.vga = PcPart();
                    pc.initTitle();
                  });
                },
              ),
              onTap: () => navigate2VgaPage(context),
            ),
            InkWell(
              child: PcPartCard(
                part: pc.ram,
                onDelete: () {
                  setState(() {
                    pc.ram = PcPart();
                    pc.initTitle();
                  });
                },
              ),
              onTap: () => navigate2RamPage(context),
            ),
            InkWell(
              child: PcPartCard(
                part: pc.hdd,
                onDelete: () {
                  setState(() {
                    pc.hdd = PcPart();
                    pc.initTitle();
                  });
                },
              ),
              onTap: () => navigate2HddPage(context),
            ),
            InkWell(
              child: PcPartCard(
                part: pc.ssd,
                onDelete: () {
                  setState(() {
                    pc.ssd = PcPart();
                    pc.initTitle();
                  });
                },
              ),
              onTap: () => navigate2SsdPage(context),
            ),
            InkWell(
              child: PcPartCard(
                part: pc.psu,
                onDelete: () {
                  setState(() {
                    pc.psu = PcPart();
                    pc.initTitle();
                  });
                },
              ),
              onTap: () => navigate2PsuPage(context),
            ),
            InkWell(
              child: PcPartCard(
                part: pc.cas,
                onDelete: () {
                  setState(() {
                    pc.cas = PcPart();
                    pc.initTitle();
                  });
                },
              ),
              onTap: () => navigate2CasePage(context),
            ),
            InkWell(
              child: PcPartCard(
                part: pc.cooling,
                onDelete: () {
                  setState(() {
                    pc.cooling = PcPart();
                    pc.initTitle();
                  });
                },
              ),
              onTap: () => navigate2CoolingPage(context),
            ),
            InkWell(
              child: PcPartCard(
                part: pc.mon,
                onDelete: () {
                  setState(() {
                    pc.mon = PcPart();
                    pc.initTitle();
                  });
                },
              ),
              onTap: () => navigate2MonPage(context),
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

  navigate2RamPage(BuildContext context) async {
    Ram result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => RamPage()));
    if (result != null) {
      setState(() {
        pc.ram.id = result.id;
        pc.ram.brandModel = result.ramBrand + ' ' + result.ramModel;
        pc.ram.picture =
            'https://www.advice.co.th/pic-pc/ram/${result.ramPicture}';
        pc.ram.price = result.lowestPrice;
        saveData();
      });
    }
  }

  navigate2HddPage(BuildContext context) async {
    Hdd result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => HddPage()));
    if (result != null) {
      setState(() {
        pc.hdd.id = result.id;
        pc.hdd.brandModel = result.hddBrand + ' ' + result.hddModel;
        pc.hdd.picture =
            'https://www.advice.co.th/pic-pc/hdd/${result.hddPicture}';
        pc.hdd.price = result.lowestPrice;
        saveData();
      });
    }
  }

  navigate2SsdPage(BuildContext context) async {
    Ssd result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SsdPage()));
    if (result != null) {
      setState(() {
        pc.ssd.id = result.id;
        pc.ssd.brandModel = result.ssdBrand + ' ' + result.ssdModel;
        pc.ssd.picture =
            'https://www.advice.co.th/pic-pc/ssd/${result.ssdPicture}';
        pc.ssd.price = result.lowestPrice;
        saveData();
      });
    }
  }

  navigate2PsuPage(BuildContext context) async {
    Psu result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => PsuPage()));
    if (result != null) {
      setState(() {
        pc.psu.id = result.id;
        pc.psu.brandModel = result.psuBrand + ' ' + result.psuModel;
        pc.psu.picture =
            'https://www.advice.co.th/pic-pc/psu/${result.psuPicture}';
        pc.psu.price = result.lowestPrice;
        saveData();
      });
    }
  }

  navigate2CasePage(BuildContext context) async {
    Case result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CasePage()));
    if (result != null) {
      setState(() {
        pc.cas.id = result.id;
        pc.cas.brandModel = result.caseBrand + ' ' + result.caseModel;
        pc.cas.picture =
            'https://www.advice.co.th/pic-pc/case/${result.casePicture}';
        pc.cas.price = result.lowestPrice;
        saveData();
      });
    }
  }

  navigate2CoolingPage(BuildContext context) async {
    Cooling result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CoolingPage()));
    if (result != null) {
      setState(() {
        pc.cooling.id = result.id;
        pc.cooling.brandModel = result.brand + ' ' + result.model;
        pc.cooling.picture =
            'https://www.advice.co.th/pic-pc/cooling/${result.picture}';
        pc.cooling.price = result.lowestPrice;
        saveData();
      });
    }
  }

  navigate2MonPage(BuildContext context) async {
    Mon result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MonPage()));
    if (result != null) {
      setState(() {
        pc.mon.id = result.id;
        pc.mon.brandModel = result.monBrand + ' ' + result.monModel;
        pc.mon.picture =
            'https://www.advice.co.th/pic-pc/mon/${result.monPicture}';
        pc.mon.price = result.lowestPrice;
        saveData();
      });
    }
  }
}
