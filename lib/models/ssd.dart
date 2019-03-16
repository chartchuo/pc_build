import 'part.dart';

class Ssd extends Part {
  String interface;
  String capa;

  Ssd.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['ssd_brand'];
    model = json['ssd_model'];

    var tmp = json['ssd_picture'];
    if (tmp != null) picture = 'https://www.advice.co.th/pic-pc/ssd/$tmp';
    tmp = json['adv_path'];
    if (tmp != null) path = 'https://www.advice.co.th/$tmp';
    price = json['price_adv'] ?? json['lowest_price'] ?? 0;
    interface = json['ssd_interface'] ?? '-';
    if (interface == '') interface = '-';
    capa = json['ssd_capacity'] ?? '-';
    if (capa == '') capa = '-';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ssd_brand'] = this.brand;
    data['ssd_model'] = this.model;
    data['ssd_picture'] = this.picture;
    data['adv_path'] = this.path;
    data['price_adv'] = this.price;
    data['ssd_interface'] = this.interface;
    data['ssd_capacity'] = this.capa;
    return data;
  }
}

class SsdFilter {
  Set<String> brand;
  Set<String> interface;
  Set<String> capa;
  int minPrice;
  int maxPrice;

  SsdFilter() {
    brand = Set<String>();
    interface = Set<String>();
    capa = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  SsdFilter.fromList(List<Ssd> list) {
    brand = list.map((v) => v.brand).toSet();
    capa = list.map((v) => v.capa).toSet();
    interface = list.map((v) => v.interface).toSet();
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
  SsdFilter.clone(SsdFilter filter) {
    brand = Set<String>()..addAll(filter.brand);
    interface = Set<String>()..addAll(filter.interface);
    capa = Set<String>()..addAll(filter.capa);
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Ssd device) {
    if (device.price < minPrice) return false;
    if (device.price > maxPrice) return false;
    if (brand.length != 0 && !brand.contains(device.brand)) return false;
    if (interface.length != 0 && !interface.contains(device.interface))
      return false;
    if (capa.length != 0 && !capa.contains(device.capa)) return false;
    return true;
  }

  List<Ssd> filters(List<Ssd> list) {
    List<Ssd> result = [];
    list.forEach((v) {
      if (filter(v)) result.add(v);
    });

    return result;
  }
}
