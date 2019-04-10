import 'part.dart';

class Psu extends Part {
  String modular;
  String energyEff;
  String maxPw;

  Psu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['psu_brand'];
    model = json['psu_model'];

    var tmp = json['psu_picture'];
    if (tmp != null) picture = 'https://www.advice.co.th/pic-pc/psu/$tmp';
    tmp = json['adv_path'];
    if (tmp != null) path = 'https://www.advice.co.th/$tmp';
    price = json['price_adv'] ?? json['lowest_price'] ?? 0;
    modular = json['psu_modular']?.toString() ?? '-';
    if (modular == '') modular = '-';
    energyEff = json['psu_energy_eff']?.toString() ?? '-';
    if (energyEff == '') energyEff = '-';
    maxPw = json['psu_max_pw'] ?? '-';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['psu_brand'] = this.brand;
    data['psu_model'] = this.model;
    data['psu_picture'] = this.picture;
    data['adv_path'] = this.path;
    data['price_adv'] = this.price;
    data['psu_modular'] = this.modular;
    data['psu_energy_eff'] = this.energyEff;
    data['psu_max_pw'] = this.maxPw;
    return data;
  }
}

class PsuFilter {
  Set<String> brand;
  Set<String> modular;
  Set<String> energyEff;
  Set<String> maxPw;
  int minPrice;
  int maxPrice;

  PsuFilter() {
    brand = Set<String>();
    modular = Set<String>();
    energyEff = Set<String>();
    maxPw = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  PsuFilter.fromList(List<Psu> list) {
    brand = list.map((v) => v.brand).toSet();
    modular = list.map((v) => v.modular).toSet();
    energyEff = list.map((v) => v.energyEff).toSet();
    maxPw = list.map((v) => v.maxPw).toSet();
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
  PsuFilter.clone(PsuFilter filter) {
    brand = filter.brand.toSet();
    modular = filter.modular.toSet();
    energyEff = filter.energyEff.toSet();
    maxPw = filter.maxPw.toSet();
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Psu device) {
    if (device.price < minPrice) return false;
    if (device.price > maxPrice) return false;
    if (brand.length != 0 && !brand.contains(device.brand)) return false;
    if (modular.length != 0 && !modular.contains(device.modular)) return false;
    if (energyEff.length != 0 && !energyEff.contains(device.energyEff))
      return false;
    if (maxPw.length != 0 && !maxPw.contains(device.maxPw)) return false;
    return true;
  }

  List<Psu> filters(List<Psu> list) {
    List<Psu> result = [];
    list.forEach((v) {
      if (filter(v)) result.add(v);
    });

    return result;
  }
}
