import 'part.dart';

class Mb extends Part {
  String factor;
  String chipset;
  String socket;

  Mb.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['mb_brand'];
    model = json['mb_model'];

    var tmp = json['mb_picture'];
    if (tmp != null) picture = 'https://www.advice.co.th/pic-pc/mb/$tmp';
    tmp = json['adv_path'];
    if (tmp != null) path = 'https://www.advice.co.th/$tmp';
    price = json['price_adv'] ?? json['lowest_price'] ?? 0;
    factor = json['mb_factor'] ?? '-';
    if (factor == '') factor = '-';
    if (factor == 'uATX') factor = 'Micro-ATX';
    chipset = json['mb_chipset'] ?? '-';
    if (chipset == '') chipset = '-';
    socket = json['mb_socket'] ?? '-';
    if (socket == '') socket = '-';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mb_brand'] = this.brand;
    data['mb_model'] = this.model;
    data['mb_picture'] = this.picture;
    data['adv_path'] = this.path;
    data['price_adv'] = this.price;
    data['mb_factor'] = this.factor;
    data['mb_chipset'] = this.chipset;
    data['mb_socket'] = this.socket;
    return data;
  }
}

class MbFilter {
  Set<String> brand;
  Set<String> factor;
  Set<String> chipset;
  Set<String> socket;
  int minPrice;
  int maxPrice;

  MbFilter() {
    brand = Set<String>();
    factor = Set<String>();
    chipset = Set<String>();
    socket = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  MbFilter.fromList(List<Mb> list) {
    brand = list.map((v) => v.brand).toSet();
    factor = list.map((v) => v.factor).toSet();
    chipset = list.map((v) => v.chipset).toSet();
    socket = list.map((v) => v.socket).toSet();
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
  MbFilter.clone(MbFilter filter) {
    brand = Set<String>()..addAll(filter.brand);
    factor = Set<String>()..addAll(filter.factor);
    chipset = Set<String>()..addAll(filter.chipset);
    socket = Set<String>()..addAll(filter.socket);
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Mb device) {
    if (device.price < minPrice) return false;
    if (device.price > maxPrice) return false;
    if (brand.length != 0 && !brand.contains(device.brand)) return false;
    if (factor.length != 0 && !factor.contains(device.factor)) return false;
    if (socket.length != 0 && !socket.contains(device.socket)) return false;
    if (chipset.length != 0 && !chipset.contains(device.chipset)) return false;
    return true;
  }

  List<Mb> filters(List<Mb> list) {
    List<Mb> result = [];
    list.forEach((v) {
      if (filter(v)) result.add(v);
    });

    return result;
  }
}
