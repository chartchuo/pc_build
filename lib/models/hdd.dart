import 'part.dart';

class Hdd extends Part {
  String capa;
  String rpm;

  Hdd.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['hdd_brand'];
    model = json['hdd_model'];

    var tmp = json['hdd_picture'];
    if (tmp != null) picture = 'https://www.advice.co.th/pic-pc/hdd/$tmp';
    tmp = json['adv_path'];
    if (tmp != null) path = 'https://www.advice.co.th/$tmp';
    price = json['price_adv'] ?? json['lowest_price'] ?? 0;
    capa = json['hdd_capa'] ?? '-';
    rpm = json['hdd_rpm']?.toString() ?? '-';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hdd_brand'] = this.brand;
    data['hdd_model'] = this.model;
    data['hdd_picture'] = this.picture;
    data['adv_path'] = this.path;
    data['price_adv'] = this.price;
    data['hdd_capa'] = this.capa;
    data['hdd_rpm'] = this.rpm;
    return data;
  }
}

class HddFilter {
  Set<String> brand;
  Set<String> capa;
  Set<String> rpm;
  int minPrice;
  int maxPrice;

  HddFilter() {
    brand = Set<String>();
    capa = Set<String>();
    rpm = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  HddFilter.fromList(List<Hdd> list) {
    brand = list.map((v) => v.brand).toSet();
    capa = list.map((v) => v.capa).toSet();
    rpm = list.map((v) => v.rpm.toString()).toSet();
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
  HddFilter.clone(HddFilter filter) {
    brand = filter.brand.toSet();
    capa = filter.capa.toSet();
    rpm = filter.rpm.toSet();
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Hdd device) {
    if (device.price < minPrice) return false;
    if (device.price > maxPrice) return false;
    if (brand.length != 0 && !brand.contains(device.brand)) return false;
    if (capa.length != 0 && !capa.contains(device.capa)) return false;
    if (rpm.length != 0 && !rpm.contains(device.rpm.toString())) return false;
    return true;
  }

  List<Hdd> filters(List<Hdd> list) {
    List<Hdd> result = [];
    list.forEach((v) {
      if (filter(v)) result.add(v);
    });

    return result;
  }
}
