class HddFilter {
  Set<String> hddBrand;
  Set<String> hddCapa;
  Set<String> hddRpm;
  int minPrice;
  int maxPrice;

  HddFilter() {
    hddBrand = Set<String>();
    hddCapa = Set<String>();
    hddRpm = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  HddFilter.fromList(List<Hdd> list) {
    hddBrand = list.map((v) => v.hddBrand).toSet();
    hddCapa = list.map((v) => v.hddCapa).toSet();
    hddRpm = list.map((v) => v.hddRpm.toString()).toSet();
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
  HddFilter.clone(HddFilter filter) {
    hddBrand = Set<String>()..addAll(filter.hddBrand);
    hddCapa = Set<String>()..addAll(filter.hddCapa);
    hddRpm = Set<String>()..addAll(filter.hddRpm);
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Hdd device) {
    if (device.lowestPrice < minPrice) return false;
    if (device.lowestPrice > maxPrice) return false;
    if (hddBrand.length != 0 && !hddBrand.contains(device.hddBrand))
      return false;
    if (hddCapa.length != 0 && !hddCapa.contains(device.hddCapa)) return false;
    if (hddRpm.length != 0 && !hddRpm.contains(device.hddRpm.toString()))
      return false;
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

class Hdd {
  String cat;
  int id;
  int view;
  int currentweek;
  int lastweek;
  int last2week;
  int lastupdate;
  int hddId;
  String hddBrand;
  String hddModel;
  String hddCapa;
  double hddSize;
  String hddRw;
  int hddRpm;
  String hddBuffer;
  String hddInterface;
  int hddScore;
  int scoreBench;
  int hddWaranty;
  int hddPriceAdv;
  int hddPriceBan;
  int hddPriceJib;
  int hddPriceTk;
  int hddPriceJedi;
  int hddPriceCommore;
  int hddPriceHwh;
  int hddPriceBusitek;
  int hddPriceEtc;
  dynamic priceMark;
  String hddPicture;
  dynamic advId;
  int soldout;
  String tkId;
  String jediId;
  String description;
  String when;
  int tmpClose;
  String timestampTmpClose;
  dynamic commoreId;
  dynamic jibId;
  int bananaId;
  int isHighlight;
  int hddPriceTopvalue;
  int topvalueId;
  int lowestPrice;

  Hdd(
      {this.cat,
      this.id,
      this.view,
      this.currentweek,
      this.lastweek,
      this.last2week,
      this.lastupdate,
      this.hddId,
      this.hddBrand,
      this.hddModel,
      this.hddCapa,
      this.hddSize,
      this.hddRw,
      this.hddRpm,
      this.hddBuffer,
      this.hddInterface,
      this.hddScore,
      this.scoreBench,
      this.hddWaranty,
      this.hddPriceAdv,
      this.hddPriceBan,
      this.hddPriceJib,
      this.hddPriceTk,
      this.hddPriceJedi,
      this.hddPriceCommore,
      this.hddPriceHwh,
      this.hddPriceBusitek,
      this.hddPriceEtc,
      this.priceMark,
      this.hddPicture,
      this.advId,
      this.soldout,
      this.tkId,
      this.jediId,
      this.description,
      this.when,
      this.tmpClose,
      this.timestampTmpClose,
      this.commoreId,
      this.jibId,
      this.bananaId,
      this.isHighlight,
      this.hddPriceTopvalue,
      this.topvalueId,
      this.lowestPrice});

  Hdd.fromJson(Map<String, dynamic> json) {
    cat = json['cat'];
    id = json['id'];
    view = json['view'];
    currentweek = json['currentweek'];
    lastweek = json['lastweek'];
    last2week = json['last2week'];
    lastupdate = json['lastupdate'];
    hddId = json['hdd_id'];
    hddBrand = json['hdd_brand'];
    hddModel = json['hdd_model'];
    hddCapa = json['hdd_capa'];
    hddSize = json['hdd_size'];
    hddRw = json['hdd_rw'];
    hddRpm = json['hdd_rpm'];
    hddBuffer = json['hdd_buffer'];
    hddInterface = json['hdd_interface'];
    hddScore = json['hdd_score'];
    scoreBench = json['scoreBench'];
    hddWaranty = json['hdd_waranty'];
    hddPriceAdv = json['hdd_price_adv'];
    hddPriceBan = json['hdd_price_ban'];
    hddPriceJib = json['hdd_price_jib'];
    hddPriceTk = json['hdd_price_tk'];
    hddPriceJedi = json['hdd_price_jedi'];
    hddPriceCommore = json['hdd_price_commore'];
    hddPriceHwh = json['hdd_price_hwh'];
    hddPriceBusitek = json['hdd_price_busitek'];
    hddPriceEtc = json['hdd_price_etc'];
    priceMark = json['price_mark'];
    hddPicture = json['hdd_picture'];
    advId = json['adv_id'];
    soldout = json['soldout'];
    tkId = json['tk_id'];
    jediId = json['jedi_id'];
    description = json['description'];
    when = json['when'];
    tmpClose = json['tmp_close'];
    timestampTmpClose = json['timestamp_tmp_close'];
    commoreId = json['commore_id'];
    jibId = json['jib_id'];
    bananaId = json['banana_id'];
    isHighlight = json['is_highlight'];
    hddPriceTopvalue = json['hdd_price_topvalue'];
    topvalueId = json['topvalue_id'];
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
    data['hdd_id'] = this.hddId;
    data['hdd_brand'] = this.hddBrand;
    data['hdd_model'] = this.hddModel;
    data['hdd_capa'] = this.hddCapa;
    data['hdd_size'] = this.hddSize;
    data['hdd_rw'] = this.hddRw;
    data['hdd_rpm'] = this.hddRpm;
    data['hdd_buffer'] = this.hddBuffer;
    data['hdd_interface'] = this.hddInterface;
    data['hdd_score'] = this.hddScore;
    data['scoreBench'] = this.scoreBench;
    data['hdd_waranty'] = this.hddWaranty;
    data['hdd_price_adv'] = this.hddPriceAdv;
    data['hdd_price_ban'] = this.hddPriceBan;
    data['hdd_price_jib'] = this.hddPriceJib;
    data['hdd_price_tk'] = this.hddPriceTk;
    data['hdd_price_jedi'] = this.hddPriceJedi;
    data['hdd_price_commore'] = this.hddPriceCommore;
    data['hdd_price_hwh'] = this.hddPriceHwh;
    data['hdd_price_busitek'] = this.hddPriceBusitek;
    data['hdd_price_etc'] = this.hddPriceEtc;
    data['price_mark'] = this.priceMark;
    data['hdd_picture'] = this.hddPicture;
    data['adv_id'] = this.advId;
    data['soldout'] = this.soldout;
    data['tk_id'] = this.tkId;
    data['jedi_id'] = this.jediId;
    data['description'] = this.description;
    data['when'] = this.when;
    data['tmp_close'] = this.tmpClose;
    data['timestamp_tmp_close'] = this.timestampTmpClose;
    data['commore_id'] = this.commoreId;
    data['jib_id'] = this.jibId;
    data['banana_id'] = this.bananaId;
    data['is_highlight'] = this.isHighlight;
    data['hdd_price_topvalue'] = this.hddPriceTopvalue;
    data['topvalue_id'] = this.topvalueId;
    data['lowest_price'] = this.lowestPrice;
    return data;
  }
}
