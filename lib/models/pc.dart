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

import 'package:flutter_money_formatter/flutter_money_formatter.dart';

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
    init();
  }

  int totalPrice() {
    int t = 0;
    t += cpu.price ?? 0;
    t += mb.price ?? 0;
    t += vga.price ?? 0;
    t += (ram.price ?? 0) * (ram.qty ?? 1);
    t += (hdd.price ?? 0) * (hdd.qty ?? 1);
    t += (ssd.price ?? 0) * (ssd.qty ?? 1);
    t += psu.price ?? 0;
    t += cas.price ?? 0;
    t += cooling.price ?? 0;
    t += mon.price ?? 0;

    return t;
  }

  String totalPriceStr() {
    var total = totalPrice();
    return FlutterMoneyFormatter(amount: total.toDouble())
            .output
            .withoutFractionDigits +
        ' บาท';
  }

  init() {
    cpu.title = 'CPU';
    mb.title = 'Mainboard';
    vga.title = 'VGA';
    ram.title = 'Memory';
    hdd.title = 'Harddisk';
    ssd.title = 'Solid State';
    psu.title = 'Power Supply';
    cas.title = 'Case';
    cooling.title = 'CPU Cooler';
    mon.title = 'Monitor';

    ram.multiple = true;
    hdd.multiple = true;
    ssd.multiple = true;
  }
}

class PcPart {
  int id;
  int qty;
  bool multiple;
  String title;
  String brandModel;
  String picture;
  String url;
  int price;

  PcPart({this.title = '', this.multiple = false, this.url = '', this.qty = 1});

  PcPart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        qty = json['qty'],
        brandModel = json['brand_model'],
        picture = json['picture'],
        url = json['url'],
        price = json['price'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'qty': qty,
        'brand_model': brandModel,
        'picture': picture,
        'url': url,
        'price': price,
      };
}
