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
      minPrice = list.map((v) => v.lowestPrice).reduce((a, b) => a < b ? a : b);
      maxPrice = list.map((v) => v.lowestPrice).reduce((a, b) => a > b ? a : b);
      minPrice = minPrice ~/ 1000 * 1000;
      maxPrice = maxPrice ~/ 1000 * 1000 + 1000;
    } else {
      minPrice = 0;
      maxPrice = 1000000;
    }
  }
  CoolingFilter.clone(CoolingFilter filter) {
    brand = Set<String>()..addAll(filter.brand);
    type = Set<String>()..addAll(filter.type);
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Cooling device) {
    if (device.lowestPrice < minPrice) return false;
    if (device.lowestPrice > maxPrice) return false;
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

class Cooling {
  String cat;
  int id;
  int view;
  int currentweek;
  int lastweek;
  int last2week;
  int lastupdate;
  String brand;
  String model;
  String series;
  String type;
  String cpuSupportIntel;
  String cpuSupportAmd;
  dynamic motorVoltage;
  dynamic motorConnector;
  String dimension;
  String material;
  dynamic weight;
  dynamic fanIncluded;
  int fanConnector;
  dynamic warranty;
  String picture;
  int soldout;
  dynamic jibId;
  int priceJib;
  String advId;
  int priceAdv;
  String timeUpdate;
  int priceCommore;
  dynamic commoreId;
  int bananaId;
  dynamic tkId;
  int priceTk;
  int priceEtc;
  int isHighlight;
  int advSoldout;
  String advPath;
  int lowestPrice;

  Cooling(
      {this.cat,
      this.id,
      this.view,
      this.currentweek,
      this.lastweek,
      this.last2week,
      this.lastupdate,
      this.brand,
      this.model,
      this.series,
      this.type,
      this.cpuSupportIntel,
      this.cpuSupportAmd,
      this.motorVoltage,
      this.motorConnector,
      this.dimension,
      this.material,
      this.weight,
      this.fanIncluded,
      this.fanConnector,
      this.warranty,
      this.picture,
      this.soldout,
      this.jibId,
      this.priceJib,
      this.advId,
      this.priceAdv,
      this.timeUpdate,
      this.priceCommore,
      this.commoreId,
      this.bananaId,
      this.tkId,
      this.priceTk,
      this.priceEtc,
      this.isHighlight,
      this.advSoldout,
      this.advPath,
      this.lowestPrice});

  Cooling.fromJson(Map<String, dynamic> json) {
    cat = json['cat'];
    id = json['id'];
    view = json['view'];
    currentweek = json['currentweek'];
    lastweek = json['lastweek'];
    last2week = json['last2week'];
    lastupdate = json['lastupdate'];
    brand = json['brand'];
    model = json['model'];
    series = json['series'];
    type = json['type'];
    cpuSupportIntel = json['cpu_support_intel'];
    cpuSupportAmd = json['cpu_support_amd'];
    motorVoltage = json['motor_voltage'];
    motorConnector = json['motor_connector'];
    dimension = json['dimension'];
    material = json['material'];
    weight = json['weight'];
    fanIncluded = json['fan_included'];
    fanConnector = json['fan_connector'];
    warranty = json['warranty'];
    picture = json['picture'];
    soldout = json['soldout'];
    jibId = json['jib_id'];
    priceJib = json['price_jib'];
    advId = json['adv_id'];
    priceAdv = json['price_adv'];
    timeUpdate = json['time_update'];
    priceCommore = json['price_commore'];
    commoreId = json['commore_id'];
    bananaId = json['banana_id'];
    tkId = json['tk_id'];
    priceTk = json['price_tk'];
    priceEtc = json['price_etc'];
    isHighlight = json['is_highlight'];
    advSoldout = json['adv_soldout'];
    advPath = json['adv_path'];
    lowestPrice = json['lowest_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat'] = this.cat;
    data['id'] = this.id;
    data['view'] = this.view;
    data['currentweek'] = this.currentweek;
    data['lastweek'] = this.lastweek;
    data['last2week'] = this.last2week;
    data['lastupdate'] = this.lastupdate;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['series'] = this.series;
    data['type'] = this.type;
    data['cpu_support_intel'] = this.cpuSupportIntel;
    data['cpu_support_amd'] = this.cpuSupportAmd;
    data['motor_voltage'] = this.motorVoltage;
    data['motor_connector'] = this.motorConnector;
    data['dimension'] = this.dimension;
    data['material'] = this.material;
    data['weight'] = this.weight;
    data['fan_included'] = this.fanIncluded;
    data['fan_connector'] = this.fanConnector;
    data['warranty'] = this.warranty;
    data['picture'] = this.picture;
    data['soldout'] = this.soldout;
    data['jib_id'] = this.jibId;
    data['price_jib'] = this.priceJib;
    data['adv_id'] = this.advId;
    data['price_adv'] = this.priceAdv;
    data['time_update'] = this.timeUpdate;
    data['price_commore'] = this.priceCommore;
    data['commore_id'] = this.commoreId;
    data['banana_id'] = this.bananaId;
    data['tk_id'] = this.tkId;
    data['price_tk'] = this.priceTk;
    data['price_etc'] = this.priceEtc;
    data['is_highlight'] = this.isHighlight;
    data['adv_soldout'] = this.advSoldout;
    data['adv_path'] = this.advPath;
    data['lowest_price'] = this.lowestPrice;
    return data;
  }
}
