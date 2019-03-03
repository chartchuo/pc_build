class SsdFilter {
  Set<String> ssdBrand;
  Set<String> ssdInterface;
  Set<String> ssdCapacity;
  int minPrice;
  int maxPrice;

  SsdFilter() {
    ssdBrand = Set<String>();
    ssdInterface = Set<String>();
    ssdCapacity = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  SsdFilter.fromList(List<Ssd> list) {
    ssdBrand = list.map((v) => v.ssdBrand).toSet();
    ssdCapacity = list.map((v) => v.ssdCapacity).toSet();
    ssdInterface = list.map((v) => v.ssdInterface).toSet();
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
  SsdFilter.clone(SsdFilter filter) {
    ssdBrand = Set<String>()..addAll(filter.ssdBrand);
    ssdInterface = Set<String>()..addAll(filter.ssdInterface);
    ssdCapacity = Set<String>()..addAll(filter.ssdCapacity);
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Ssd device) {
    if (device.lowestPrice < minPrice) return false;
    if (device.lowestPrice > maxPrice) return false;
    if (ssdBrand.length != 0 && !ssdBrand.contains(device.ssdBrand))
      return false;
    if (ssdInterface.length != 0 && !ssdInterface.contains(device.ssdInterface))
      return false;
    if (ssdCapacity.length != 0 && !ssdCapacity.contains(device.ssdCapacity))
      return false;
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

class Ssd {
  String cat;
  int id;
  int view;
  int currentweek;
  int lastweek;
  int last2week;
  int lastupdate;
  int ssdId;
  String ssdBrand;
  String ssdModel;
  String ssdCapacity;
  dynamic ssdSize;
  String ssdThin;
  int ssdRead;
  int ssdWrite;
  String ssdMaxRanW4k;
  String ssdTechnology;
  String ssdInterface;
  int ssdScore;
  int scoreBench;
  int ssdWarranty;
  int ssdPriceAdv;
  int soldout;
  String ssdPicture;
  dynamic advId;
  dynamic tkId;
  String jediId;
  String when;
  int tmpClose;
  String timestampTmpClose;
  dynamic commoreId;
  dynamic jibId;
  int ssdPriceCommore;
  int ssdPriceJib;
  int ssdPriceTk;
  int bananaId;
  int ssdPriceBan;
  int ssdPriceEtc;
  int isHighlight;
  dynamic ssdPriceTopvalue;
  dynamic topvalueId;
  dynamic lazadaId;
  dynamic ssdPriceLazada;
  int advSoldout;
  String advPath;
  int priceAdv;
  int lowestPrice;

  Ssd(
      {this.cat,
      this.id,
      this.view,
      this.currentweek,
      this.lastweek,
      this.last2week,
      this.lastupdate,
      this.ssdId,
      this.ssdBrand,
      this.ssdModel,
      this.ssdCapacity,
      this.ssdSize,
      this.ssdThin,
      this.ssdRead,
      this.ssdWrite,
      this.ssdMaxRanW4k,
      this.ssdTechnology,
      this.ssdInterface,
      this.ssdScore,
      this.scoreBench,
      this.ssdWarranty,
      this.ssdPriceAdv,
      this.soldout,
      this.ssdPicture,
      this.advId,
      this.tkId,
      this.jediId,
      this.when,
      this.tmpClose,
      this.timestampTmpClose,
      this.commoreId,
      this.jibId,
      this.ssdPriceCommore,
      this.ssdPriceJib,
      this.ssdPriceTk,
      this.bananaId,
      this.ssdPriceBan,
      this.ssdPriceEtc,
      this.isHighlight,
      this.ssdPriceTopvalue,
      this.topvalueId,
      this.lazadaId,
      this.ssdPriceLazada,
      this.advSoldout,
      this.advPath,
      this.priceAdv,
      this.lowestPrice});

  Ssd.fromJson(Map<String, dynamic> json) {
    cat = json['cat'];
    id = json['id'];
    view = json['view'];
    currentweek = json['currentweek'];
    lastweek = json['lastweek'];
    last2week = json['last2week'];
    lastupdate = json['lastupdate'];
    ssdId = json['ssd_id'];
    ssdBrand = json['ssd_brand'];
    ssdModel = json['ssd_model'];
    ssdCapacity = json['ssd_capacity'];
    ssdSize = json['ssd_size'];
    ssdThin = json['ssd_thin'];
    ssdRead = json['ssd_read'];
    ssdWrite = json['ssd_write'];
    ssdMaxRanW4k = json['ssd_MaxRanW4k'];
    ssdTechnology = json['ssd_technology'];
    ssdInterface = json['ssd_interface'];
    ssdScore = json['ssd_score'];
    scoreBench = json['scoreBench'];
    ssdWarranty = json['ssd_warranty'];
    ssdPriceAdv = json['ssd_price_adv'];
    soldout = json['soldout'];
    ssdPicture = json['ssd_picture'];
    advId = json['adv_id'];
    tkId = json['tk_id'];
    jediId = json['jedi_id'];
    when = json['when'];
    tmpClose = json['tmp_close'];
    timestampTmpClose = json['timestamp_tmp_close'];
    commoreId = json['commore_id'];
    jibId = json['jib_id'];
    ssdPriceCommore = json['ssd_price_commore'];
    ssdPriceJib = json['ssd_price_jib'];
    ssdPriceTk = json['ssd_price_tk'];
    bananaId = json['banana_id'];
    ssdPriceBan = json['ssd_price_ban'];
    ssdPriceEtc = json['ssd_price_etc'];
    isHighlight = json['is_highlight'];
    ssdPriceTopvalue = json['ssd_price_topvalue'];
    topvalueId = json['topvalue_id'];
    lazadaId = json['lazada_id'];
    ssdPriceLazada = json['ssd_price_lazada'];
    advSoldout = json['adv_soldout'];
    advPath = json['adv_path'];
    priceAdv = json['price_adv'];
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
    data['ssd_id'] = this.ssdId;
    data['ssd_brand'] = this.ssdBrand;
    data['ssd_model'] = this.ssdModel;
    data['ssd_capacity'] = this.ssdCapacity;
    data['ssd_size'] = this.ssdSize;
    data['ssd_thin'] = this.ssdThin;
    data['ssd_read'] = this.ssdRead;
    data['ssd_write'] = this.ssdWrite;
    data['ssd_MaxRanW4k'] = this.ssdMaxRanW4k;
    data['ssd_technology'] = this.ssdTechnology;
    data['ssd_interface'] = this.ssdInterface;
    data['ssd_score'] = this.ssdScore;
    data['scoreBench'] = this.scoreBench;
    data['ssd_warranty'] = this.ssdWarranty;
    data['ssd_price_adv'] = this.ssdPriceAdv;
    data['soldout'] = this.soldout;
    data['ssd_picture'] = this.ssdPicture;
    data['adv_id'] = this.advId;
    data['tk_id'] = this.tkId;
    data['jedi_id'] = this.jediId;
    data['when'] = this.when;
    data['tmp_close'] = this.tmpClose;
    data['timestamp_tmp_close'] = this.timestampTmpClose;
    data['commore_id'] = this.commoreId;
    data['jib_id'] = this.jibId;
    data['ssd_price_commore'] = this.ssdPriceCommore;
    data['ssd_price_jib'] = this.ssdPriceJib;
    data['ssd_price_tk'] = this.ssdPriceTk;
    data['banana_id'] = this.bananaId;
    data['ssd_price_ban'] = this.ssdPriceBan;
    data['ssd_price_etc'] = this.ssdPriceEtc;
    data['is_highlight'] = this.isHighlight;
    data['ssd_price_topvalue'] = this.ssdPriceTopvalue;
    data['topvalue_id'] = this.topvalueId;
    data['lazada_id'] = this.lazadaId;
    data['ssd_price_lazada'] = this.ssdPriceLazada;
    data['adv_soldout'] = this.advSoldout;
    data['adv_path'] = this.advPath;
    data['price_adv'] = this.priceAdv;
    data['lowest_price'] = this.lowestPrice;
    return data;
  }
}
