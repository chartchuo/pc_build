import 'part.dart';

class Cpu extends Part {
  String series;
  String socket;

  Cpu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['cpu_brand'];
    model = json['cpu_model'];

    var tmp = json['cpu_picture'];
    if (tmp != null) picture = 'https://www.advice.co.th/pic-pc/cpu/$tmp';
    tmp = json['adv_path'];
    if (tmp != null) path = 'https://www.advice.co.th/$tmp';
    price = json['price_adv'] ?? json['lowest_price'] ?? 0;
    series = json['cpu_series'] ?? '-';
    if (series == '') series = '-';
    socket = json['cpu_socket'] ?? '-';
    if (socket == '') socket = '-';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cpu_brand'] = this.brand;
    data['cpu_model'] = this.model;
    data['cpu_picture'] = this.picture;
    data['adv_path'] = this.path;
    data['price_adv'] = this.price;
    data['cpu_series'] = this.series;
    data['cpu_socket'] = this.socket;
    return data;
  }
}

class CpuFilter {
  Set<String> brand;
  Set<String> series;
  Set<String> socket;
  int minPrice;
  int maxPrice;

  CpuFilter() {
    brand = Set<String>();
    series = Set<String>();
    socket = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  CpuFilter.fromList(List<Cpu> list) {
    brand = list.map((v) => v.brand).toSet();
    series = list.map((v) => v.series).toSet();
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
  CpuFilter.clone(CpuFilter filter) {
    brand = filter.brand.toSet();
    series = filter.series.toSet();
    socket = filter.socket.toSet();
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Cpu device) {
    if (device.price < minPrice) return false;
    if (device.price > maxPrice) return false;
    if (brand.length != 0 && !brand.contains(device.brand)) return false;
    if (series.length != 0 && !series.contains(device.series)) return false;
    if (socket.length != 0 && !socket.contains(device.socket)) return false;
    return true;
  }

  List<Cpu> filters(List<Cpu> list) {
    List<Cpu> result = [];
    list.forEach((v) {
      if (filter(v)) result.add(v);
    });

    return result;
  }
}
