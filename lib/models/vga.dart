import 'part.dart';

class Vga extends Part {
  String chipset;
  String series;

  Vga.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['vga_brand'];
    model = json['vga_model'];

    var tmp = json['vga_picture'];
    if (tmp != null) picture = 'https://www.advice.co.th/pic-pc/vga/$tmp';
    tmp = json['adv_path'];
    if (tmp != null) path = 'https://www.advice.co.th/$tmp';
    price = json['price_adv'] ?? json['lowest_price'] ?? 0;
    chipset = json['vga_chipset'] ?? '-';
    if (chipset == '') chipset = '-';
    series = json['vga_series'] ?? '-';
    if (series == '') series = '-';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vga_brand'] = this.brand;
    data['vga_model'] = this.model;
    data['vga_picture'] = this.picture;
    data['adv_path'] = this.path;
    data['price_adv'] = this.price;
    data['vga_chipset'] = this.chipset;
    data['vga_series'] = this.series;
    return data;
  }
}

class VgaFilter {
  Set<String> brand;
  Set<String> chipset;
  Set<String> series;
  int minPrice;
  int maxPrice;

  VgaFilter() {
    brand = Set<String>();
    chipset = Set<String>();
    series = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  VgaFilter.fromList(List<Vga> list) {
    brand = list.map((v) => v.brand).toSet();
    chipset = list.map((v) => v.chipset).toSet();
    series = list.map((v) => v.series).toSet();
    if (list.length > 0) {
      minPrice = list.map((v) => v.price).reduce((a, b) => a < b ? a : b);
      maxPrice = list.map((v) => v.price).reduce((a, b) => a > b ? a : b);
      minPrice = minPrice ~/ 1000 * 1000;
      maxPrice = maxPrice ~/ 1000 * 1000 + 1000;
    } else {
      minPrice = 0;
      maxPrice = 1000000;
    }
  }
  VgaFilter.clone(VgaFilter vgaFilter) {
    brand = vgaFilter.brand.toSet();
    chipset = vgaFilter.chipset.toSet();
    series = vgaFilter.series.toSet();
    minPrice = vgaFilter.minPrice;
    maxPrice = vgaFilter.maxPrice;
  }
  bool filter(Vga device) {
    if (device.price < minPrice) return false;
    if (device.price > maxPrice) return false;
    if (brand.length != 0 && !brand.contains(device.brand)) return false;
    if (chipset.length != 0 && !chipset.contains(device.chipset)) return false;
    if (series.length != 0 && !series.contains(device.series)) return false;
    return true;
  }

  List<Vga> filters(List<Vga> list) {
    List<Vga> result = [];
    list.forEach((v) {
      if (filter(v)) result.add(v);
    });

    return result;
  }
}
