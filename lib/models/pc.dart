export 'cpu.dart';
export 'mb.dart';
export 'vga.dart';

class Pc {
  PcPart cpu, mb, vga, ram, hd, ssd, ps, pcCase, cpuCooler, monitor;
  Pc() {
    cpu = PcPart();
    mb = PcPart();
    vga = PcPart();
    ram = PcPart();
    hd = PcPart();
    ssd = PcPart();
    ps = PcPart();
    pcCase = PcPart();
    cpuCooler = PcPart();
    monitor = PcPart();
    initTitle();
  }

  initTitle() {
    cpu.title = 'CPU';
    mb.title = 'Main Board';
    vga.title = 'VGA';
    ram.title = 'Memory';
    hd.title = 'Harddisk';
    ssd.title = 'Solid State Drive';
    ps.title = 'Power Supply';
    pcCase.title = 'Case';
    cpuCooler.title = 'CPU Cooler';
    monitor.title = 'Monitor';
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
