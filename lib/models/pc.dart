export 'cpu.dart';
export 'mb.dart';
export 'vga.dart';
export 'ram.dart';
export 'hdd.dart';
export 'ssd.dart';
export 'psu.dart';
export 'case.dart';
export 'cooling.dart';
export 'mon.dart';

class Pc {
  PcPart cpu, mb, vga, ram, hdd, ssd, psu, cas, cooling, mon;
  Pc() {
    cpu = PcPart();
    mb = PcPart();
    vga = PcPart();
    ram = PcPart();
    hdd = PcPart();
    ssd = PcPart();
    psu = PcPart();
    cas = PcPart();
    cooling = PcPart();
    mon = PcPart();
    initTitle();
  }

  initTitle() {
    cpu.title = 'CPU';
    mb.title = 'Mainboard';
    vga.title = 'VGA';
    ram.title = 'Memory';
    hdd.title = 'Harddisk';
    ssd.title = 'Solid State Drive';
    psu.title = 'Power Supply';
    cas.title = 'Case';
    cooling.title = 'CPU Cooler';
    mon.title = 'Monitor';
  }
}

class PcPart {
  int id;
  String title;
  String brandModel;
  String picture;
  int price;
  PcPart({this.title});
  PcPart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        brandModel = json['brand_model'],
        picture = json['picture'],
        price = json['price'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'brand_model': brandModel,
        'picture': picture,
        'price': price,
      };
}
