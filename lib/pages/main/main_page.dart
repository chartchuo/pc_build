import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:pc_build/models/pc.dart';

import 'package:pc_build/widgets/widgets.dart';

import 'pc_part.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Pc pc = Pc();
  // SharedPreferences prefs;

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
    pc.init();
    // prefs.setString('pc.cpu', jsonEncode(pc.cpu));
    // prefs.setString('pc.mb', jsonEncode(pc.mb));
    // prefs.setString('pc.vga', jsonEncode(pc.vga));
    // prefs.setString('pc.ram', jsonEncode(pc.ram));
    // prefs.setString('pc.hdd', jsonEncode(pc.hdd));
    // prefs.setString('pc.ssd', jsonEncode(pc.ssd));
    // prefs.setString('pc.psu', jsonEncode(pc.psu));
    // prefs.setString('pc.cas', jsonEncode(pc.cas));
    // prefs.setString('pc.cooling', jsonEncode(pc.cooling));
    // prefs.setString('pc.mon', jsonEncode(pc.mon));
  }

  // PcPart loadPart(SharedPreferences prefs, String key) {
  //   String str;
  //   str = prefs.getString(key);
  //   if (str == null) {
  //     return PcPart();
  //   } else {
  //     return PcPart.fromJson(jsonDecode(str));
  //   }
  // }

  loadData() async {
    // prefs = await SharedPreferences.getInstance();
    setState(() {
      // pc.cpu = loadPart(prefs, 'pc.cpu');
      // pc.mb = loadPart(prefs, 'pc.mb');
      // pc.vga = loadPart(prefs, 'pc.vga');
      // pc.ram = loadPart(prefs, 'pc.ram');
      // pc.hdd = loadPart(prefs, 'pc.hdd');
      // pc.ssd = loadPart(prefs, 'pc.ssd');
      // pc.psu = loadPart(prefs, 'pc.psu');
      // pc.cas = loadPart(prefs, 'pc.cas');
      // pc.cooling = loadPart(prefs, 'pc.cooling');
      // pc.mon = loadPart(prefs, 'pc.mon');

      pc.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyBuilder(context),
    );
  }

  Widget bodyBuilder(BuildContext context) {
    return Container(
      decoration: MyBackgroundDecoration(),
      padding: EdgeInsets.all(4),
      child: Column(
        children: <Widget>[
          Expanded(
            child: GridView(
              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: 2,
              //   childAspectRatio: 0.7,
              // ),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 0.7,
              ),
              children: <Widget>[
                InkWell(
                  child: PcPartCard(
                    part: pc.cpu,
                    onDelete: () {
                      setState(() {
                        pc.cpu = PcPart();
                        pc.init();
                        saveData();
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
                        pc.init();
                        saveData();
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
                        pc.init();
                        saveData();
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
                        pc.init();
                        saveData();
                      });
                    },
                    onAdd: () {
                      setState(() {
                        pc.ram.qty++;
                        saveData();
                      });
                      saveData();
                    },
                    onSub: () {
                      setState(() {
                        pc.ram.qty--;
                        saveData();
                      });
                      saveData();
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
                        pc.init();
                        saveData();
                      });
                    },
                    onAdd: () {
                      setState(() {
                        pc.hdd.qty++;
                        saveData();
                      });
                    },
                    onSub: () {
                      setState(() {
                        pc.hdd.qty--;
                        saveData();
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
                        pc.init();
                        saveData();
                      });
                    },
                    onAdd: () {
                      setState(() {
                        pc.ssd.qty++;
                        saveData();
                      });
                    },
                    onSub: () {
                      setState(() {
                        pc.ssd.qty--;
                        saveData();
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
                        pc.init();
                        saveData();
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
                          pc.init();
                          saveData();
                        });
                      }),
                  onTap: () => navigate2CasePage(context),
                ),
                InkWell(
                  child: PcPartCard(
                    part: pc.cooling,
                    onDelete: () {
                      setState(() {
                        pc.cooling = PcPart();
                        pc.init();
                        saveData();
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
                        pc.init();
                        saveData();
                      });
                    },
                  ),
                  onTap: () => navigate2MonPage(context),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: Text(
              'รวม ${pc.totalPriceStr()}',
              style: myTextStyle.header,
            ),
          ),
        ],
      ),
    );
  }

  navigate2CpuPage(BuildContext context) async {
    Cpu result = await Navigator.of(context)
        .pushNamed<dynamic>('/cpu'); //workaround by insert dynamic type
    if (result != null) {
      setState(() {
        var part = PcPart();
        part.id = result.id;
        part.brandModel = result.brand + ' ' + result.model;
        part.picture = result.picture;
        part.url = result.path ?? '';
        part.price = result.price;
        pc.cpu = part;
        saveData();
      });
    }
  }

  navigate2MbPage(BuildContext context) async {
    Mb result = await Navigator.of(context).pushNamed<dynamic>('/mb');
    if (result != null) {
      setState(() {
        var part = PcPart();
        part.id = result.id;
        part.brandModel = result.brand + ' ' + result.model;
        part.picture = result.picture;
        part.url = result.path ?? '';
        part.price = result.price;
        pc.mb = part;
        saveData();
      });
    }
  }

  navigate2VgaPage(BuildContext context) async {
    Vga result = await Navigator.of(context).pushNamed<dynamic>('/vga');
    if (result != null) {
      setState(() {
        var part = PcPart();
        part.id = result.id;
        part.brandModel = result.brand + ' ' + result.model;
        part.picture = result.picture;
        part.url = result.path ?? '';
        part.price = result.price;
        pc.vga = part;
        saveData();
      });
    }
  }

  navigate2RamPage(BuildContext context) async {
    Ram result = await Navigator.of(context).pushNamed<dynamic>('/ram');
    if (result != null) {
      setState(() {
        var part = PcPart();
        part.id = result.id;
        part.brandModel = result.brand + ' ' + result.model;
        part.picture = result.picture;
        part.url = result.path ?? '';
        part.price = result.price;
        pc.ram = part;
        saveData();
      });
    }
  }

  navigate2HddPage(BuildContext context) async {
    Hdd result = await Navigator.of(context).pushNamed<dynamic>('/hdd');
    if (result != null) {
      setState(() {
        var part = PcPart();
        part.id = result.id;
        part.brandModel = result.brand + ' ' + result.model;
        part.picture = result.picture;
        part.url = result.path ?? '';
        part.price = result.price;
        pc.hdd = part;
        saveData();
      });
    }
  }

  navigate2SsdPage(BuildContext context) async {
    Ssd result = await Navigator.of(context).pushNamed<dynamic>('/ssd');
    if (result != null) {
      setState(() {
        var part = PcPart();
        part.id = result.id;
        part.brandModel = result.brand + ' ' + result.model;
        part.picture = result.picture;
        part.url = result.path ?? '';
        part.price = result.price;
        pc.ssd = part;
        saveData();
      });
    }
  }

  navigate2PsuPage(BuildContext context) async {
    Psu result = await Navigator.of(context).pushNamed<dynamic>('/psu');
    if (result != null) {
      setState(() {
        var part = PcPart();
        part.id = result.id;
        part.brandModel = result.brand + ' ' + result.model;
        part.picture = result.picture;
        part.url = result.path ?? '';
        part.price = result.price;
        pc.psu = part;
        saveData();
      });
    }
  }

  navigate2CasePage(BuildContext context) async {
    Case result = await Navigator.of(context).pushNamed<dynamic>('/case');
    if (result != null) {
      setState(() {
        var part = PcPart();
        part.id = result.id;
        part.brandModel = result.brand + ' ' + result.model;
        part.picture = result.picture;
        part.url = result.path ?? '';
        part.price = result.price;
        pc.cas = part;
        saveData();
      });
    }
  }

  navigate2CoolingPage(BuildContext context) async {
    Cooling result = await Navigator.of(context).pushNamed<dynamic>('/cooling');
    if (result != null) {
      setState(() {
        var part = PcPart();
        part.id = result.id;
        part.brandModel = result.brand + ' ' + result.model;
        part.picture = result.picture;
        part.url = result.path ?? '';
        part.price = result.price;
        pc.cooling = part;
        saveData();
      });
    }
  }

  navigate2MonPage(BuildContext context) async {
    Mon result = await Navigator.of(context).pushNamed<dynamic>('/mon');
    if (result != null) {
      setState(() {
        var part = PcPart();
        part.id = result.id;
        part.brandModel = result.brand + ' ' + result.model;
        part.picture = result.picture;
        part.url = result.path ?? '';
        part.price = result.price;
        pc.mon = part;
        saveData();
      });
    }
  }
}
