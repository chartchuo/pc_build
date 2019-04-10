import 'part.dart';

class Cooling extends Part {
  String type;

  Cooling.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    model = json['model'].toString();

    var tmp = json['picture'];
    if (tmp != null) picture = 'https://www.advice.co.th/pic-pc/cooling/$tmp';
    path = json['adv_path'];
    if (tmp != null) path = 'https://www.advice.co.th/$tmp';
    price = json['price_adv'] ?? json['lowest_price'] ?? 0;

    type = json['type'] ?? '-';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['picture'] = this.picture;
    data['adv_path'] = this.path;
    data['price_adv'] = this.price;

    data['type'] = this.type;
    return data;
  }
}

class CoolingFilter {
  Set<String> brand;
  Set<String> type;
  int minPrice;
  int maxPrice;

  CoolingFilter() {
    brand = Set<String>();
    type = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  CoolingFilter.fromList(List<Cooling> list) {
    brand = list.map((v) => v.brand).toSet();
    type = list.map((v) => v.type).toSet();
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
  CoolingFilter.clone(CoolingFilter filter) {
    brand = filter.brand.toSet();
    type = filter.type.toSet();
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Cooling device) {
    if (device.price < minPrice) return false;
    if (device.price > maxPrice) return false;
    if (brand.length != 0 && !brand.contains(device.brand)) return false;
    if (type.length != 0 && !type.contains(device.type)) return false;
    return true;
  }

  List<Cooling> filters(List<Cooling> list) {
    List<Cooling> result = [];
    list.forEach((v) {
      if (filter(v)) result.add(v);
    });

    return result;
  }
}
