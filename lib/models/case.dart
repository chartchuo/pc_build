import 'part.dart';

class Case extends Part {
  String type;
  List<String> mbSize;

  Case.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['case_brand'];
    model = json['case_model'].toString();

    var tmp = json['case_picture'];
    if (tmp != null) picture = 'https://www.advice.co.th/pic-pc/case/$tmp';
    path = json['adv_path'];
    if (tmp != null) path = 'https://www.advice.co.th/$tmp';
    price = json['price_adv'] ?? json['lowest_price'] ?? 0;

    type = json['case_type']?.toString() ?? '-';
    if (type == '') type = '-';
    tmp = json['case_mb_size'] ?? '-';
    mbSize = tmp.split(',');
    mbSize = mbSize.map((v) => v.trim()).toList();
    mbSize.removeWhere((v) => v.trim() == '');
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['case_brand'] = this.brand;
    data['case_model'] = this.model;
    data['case_picture'] = this.picture;
    data['adv_path'] = this.path;
    data['price_adv'] = this.price;

    data['case_type'] = this.type;
    data['case_mb_size'] = this.mbSize;
    return data;
  }
}

class CaseFilter {
  Set<String> brand;
  Set<String> type;
  Set<String> mbSize;
  int minPrice;
  int maxPrice;

  CaseFilter() {
    brand = Set<String>();
    type = Set<String>();
    mbSize = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  CaseFilter.fromList(List<Case> list) {
    brand = list.map((v) => v.brand).toSet();
    type = list.map((v) => v.type).toSet();
    // mbSize = list.map((v) => v.mbSize).toSet();
    mbSize = Set<String>();
    list.forEach((v) {
      mbSize = mbSize.union(v.mbSize.toSet());
    });
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
  CaseFilter.clone(CaseFilter filter) {
    brand = filter.brand.toSet();
    type = filter.type.toSet();
    mbSize = filter.mbSize.toSet();
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Case device) {
    if (device.price < minPrice) return false;
    if (device.price > maxPrice) return false;
    if (brand.length != 0 && !brand.contains(device.brand)) return false;
    if (type.length != 0 && !type.contains(device.type)) return false;
    // if (mbSize.length != 0 && !mbSize.contains(device.mbSize)) return false;
    if (mbSize.length != 0 &&
        mbSize.intersection(device.mbSize.toSet()).length == 0) return false;
    return true;
  }

  List<Case> filters(List<Case> list) {
    List<Case> result = [];
    list.forEach((v) {
      if (filter(v)) result.add(v);
    });

    return result;
  }
}
