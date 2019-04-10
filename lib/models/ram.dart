import 'part.dart';

class Ram extends Part {
  String type;
  String capa;
  String bus;

  Ram.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['ram_brand'];
    model = json['ram_model'];

    var tmp = json['ram_picture'];
    if (tmp != null) picture = 'https://www.advice.co.th/pic-pc/ram/$tmp';
    tmp = json['adv_path'];
    if (tmp != null) path = 'https://www.advice.co.th/$tmp';
    price = json['price_adv'] ?? json['lowest_price'] ?? 0;
    type = json['ram_type'] ?? '-';
    if (type == '') type = '-';
    capa = json['ram_capa'] ?? '-';
    if (capa == '') capa = '-';
    bus = json['ram_bus']?.toString() ?? '-';
    if (bus == '') bus = '-';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ram_brand'] = this.brand;
    data['ram_model'] = this.model;
    data['ram_picture'] = this.picture;
    data['adv_path'] = this.path;
    data['price_adv'] = this.price;
    data['ram_type'] = this.type;
    data['ram_capa'] = this.capa;
    data['ram_bus'] = this.bus;
    return data;
  }
}

class RamFilter {
  Set<String> brand;
  Set<String> type;
  Set<String> capa;
  Set<String> bus;
  int minPrice;
  int maxPrice;

  RamFilter() {
    brand = Set<String>();
    type = Set<String>();
    capa = Set<String>();
    bus = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  RamFilter.fromList(List<Ram> list) {
    brand = list.map((v) => v.brand).toSet();
    type = list.map((v) => v.type).toSet();
    capa = list.map((v) => v.capa).toSet();
    bus = list.map((v) => v.bus.toString()).toSet();
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
  RamFilter.clone(RamFilter filter) {
    brand = filter.brand.toSet();
    type = filter.type.toSet();
    capa = filter.capa.toSet();
    bus = filter.bus.toSet();
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Ram device) {
    if (device.price < minPrice) return false;
    if (device.price > maxPrice) return false;
    if (brand.length != 0 && !brand.contains(device.brand)) return false;
    if (type.length != 0 && !type.contains(device.type)) return false;
    if (capa.length != 0 && !capa.contains(device.capa)) return false;
    if (bus.length != 0 && !bus.contains(device.bus.toString())) return false;
    return true;
  }

  List<Ram> filters(List<Ram> list) {
    List<Ram> result = [];
    list.forEach((v) {
      if (filter(v)) result.add(v);
    });

    return result;
  }
}
