import 'part.dart';

class Mon extends Part {
  String panel;
  String size;

  Mon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['mon_brand'];
    model = json['mon_model'];

    var tmp = json['mon_picture'];
    if (tmp != null) picture = 'https://www.advice.co.th/pic-pc/mon/$tmp';
    tmp = json['adv_path'];
    if (tmp != null) path = 'https://www.advice.co.th/$tmp';
    price = json['price_adv'] ?? json['lowest_price'] ?? 0;
    panel = json['mon_panel2']?.toString()?.trim() ?? '-';
    if (panel == '') panel = '-';
    size = json['mon_size']?.toString() ?? '-';
    if (size == '') size = '-';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mon_brand'] = this.brand;
    data['mon_model'] = this.model;
    data['mon_picture'] = this.picture;
    data['adv_path'] = this.path;
    data['price_adv'] = this.price;
    data['mon_panel2'] = this.panel;
    data['mon_size'] = this.size;
    return data;
  }
}

class MonFilter {
  Set<String> brand;
  Set<String> panel;
  Set<String> size;
  int minPrice;
  int maxPrice;

  MonFilter() {
    brand = Set<String>();
    panel = Set<String>();
    size = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  MonFilter.fromList(List<Mon> list) {
    brand = list.map((v) => v.brand).toSet();
    panel = list.map((v) => v.panel).toSet();
    size = list.map((v) => v.size.toString()).toSet();
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
  MonFilter.clone(MonFilter filter) {
    brand = Set<String>()..addAll(filter.brand);
    panel = Set<String>()..addAll(filter.panel);
    size = Set<String>()..addAll(filter.size);
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Mon device) {
    if (device.price < minPrice) return false;
    if (device.price > maxPrice) return false;
    if (brand.length != 0 && !brand.contains(device.brand)) return false;
    if (panel.length != 0 && !panel.contains(device.panel)) return false;
    if (size.length != 0 && !size.contains(device.size.toString()))
      return false;
    return true;
  }

  List<Mon> filters(List<Mon> list) {
    List<Mon> result = [];
    list.forEach((v) {
      if (filter(v)) result.add(v);
    });

    return result;
  }
}
