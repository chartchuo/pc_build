export 'cpu.dart';
export 'mb.dart';
export 'vga.dart';

class Pc {
  PcPart cpu, mb, vga, ram, hd, ssd, ps, pcCase, cpuCooler, monitor;
  Pc() {
    cpu = PcPart(title: 'CPU');
    mb = PcPart(title: 'Main Board');
    vga = PcPart(title: 'VGA');
    ram = PcPart(title: 'Memory');
    hd = PcPart(title: 'Harddisk');
    ssd = PcPart(title: 'Solid State Drive');
    ps = PcPart(title: 'Power Supply');
    pcCase = PcPart(title: 'Case');
    cpuCooler = PcPart(title: 'CPU Cooler');
    monitor = PcPart(title: 'Monitor');
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
        // title = json['title'],
        brandModel = json['brand_model'],
        picture = json['picture'],
        price = json['price'];

  Map<String, dynamic> toJson() => {
        'id': id,
        // 'title': title,
        'brand_model': brandModel,
        'picture': picture,
        'price': price,
      };
}
