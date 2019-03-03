class RamFilter {
  Set<String> ramBrand;
  Set<String> ramType;
  Set<String> ramCapa;
  Set<String> ramBus;
  int minPrice;
  int maxPrice;

  RamFilter() {
    ramBrand = Set<String>();
    ramType = Set<String>();
    ramCapa = Set<String>();
    ramBus = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  RamFilter.fromList(List<Ram> list) {
    ramBrand = list.map((v) => v.ramBrand).toSet();
    ramType = list.map((v) => v.ramType).toSet();
    ramCapa = list.map((v) => v.ramCapa).toSet();
    ramBus = list.map((v) => v.ramBus.toString()).toSet();
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
  RamFilter.clone(RamFilter filter) {
    ramBrand = Set<String>()..addAll(filter.ramBrand);
    ramType = Set<String>()..addAll(filter.ramType);
    ramCapa = Set<String>()..addAll(filter.ramCapa);
    ramBus = Set<String>()..addAll(filter.ramBus);
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Ram device) {
    if (device.lowestPrice < minPrice) return false;
    if (device.lowestPrice > maxPrice) return false;
    if (ramBrand.length != 0 && !ramBrand.contains(device.ramBrand))
      return false;
    if (ramType.length != 0 && !ramType.contains(device.ramType)) return false;
    if (ramCapa.length != 0 && !ramCapa.contains(device.ramCapa)) return false;
    if (ramBus.length != 0 && !ramBus.contains(device.ramBus.toString()))
      return false;
    return true;
  }

  List<Ram> filters(List<Ram> list) {
    List<Ram> result = [];
    list.forEach((v) {
      if (filter(v)) result.add(v);
    });

    return result;
  }
}

class Ram {
  String cat;
  int id;
  int view;
  int currentweek;
  int lastweek;
  int last2week;
  int lastupdate;
  int ramId;
  String ramBrand;
  String ramModel;
  String ramType;
  String ramCapa;
  int ramBus;
  dynamic ramCl;
  dynamic ramVoltage;
  int ramUnit;
  String ramWaranty;
  int ramScore;
  int ramPriceAdv;
  int ramPriceBan;
  int ramPriceJib;
  int ramPriceTk;
  int ramPriceJedi;
  int ramPriceCommore;
  int ramPriceHwh;
  int ramPriceBusitek;
  int ramPriceEtc;
  String ramPicture;
  dynamic advId;
  dynamic tkId;
  dynamic jediId;
  int commId;
  int soldout;
  String when;
  int tmpClose;
  String timestampTmpClose;
  dynamic commoreId;
  dynamic jibId;
  int bananaId;
  int isHighlight;
  dynamic ramPriceTopvalue;
  dynamic topvalueId;
  int lowestPrice;
  String advPath;

  Ram(
      {this.cat,
      this.id,
      this.view,
      this.currentweek,
      this.lastweek,
      this.last2week,
      this.lastupdate,
      this.ramId,
      this.ramBrand,
      this.ramModel,
      this.ramType,
      this.ramCapa,
      this.ramBus,
      this.ramCl,
      this.ramVoltage,
      this.ramUnit,
      this.ramWaranty,
      this.ramScore,
      this.ramPriceAdv,
      this.ramPriceBan,
      this.ramPriceJib,
      this.ramPriceTk,
      this.ramPriceJedi,
      this.ramPriceCommore,
      this.ramPriceHwh,
      this.ramPriceBusitek,
      this.ramPriceEtc,
      this.ramPicture,
      this.advId,
      this.tkId,
      this.jediId,
      this.commId,
      this.soldout,
      this.when,
      this.tmpClose,
      this.timestampTmpClose,
      this.commoreId,
      this.jibId,
      this.bananaId,
      this.isHighlight,
      this.ramPriceTopvalue,
      this.topvalueId,
      this.advPath,
      this.lowestPrice});

  Ram.fromJson(Map<String, dynamic> json) {
    cat = json['cat'];
    id = json['id'];
    view = json['view'];
    currentweek = json['currentweek'];
    lastweek = json['lastweek'];
    last2week = json['last2week'];
    lastupdate = json['lastupdate'];
    ramId = json['ram_id'];
    ramBrand = json['ram_brand'];
    ramModel = json['ram_model'];
    ramType = json['ram_type'];
    ramCapa = json['ram_capa'];
    ramBus = json['ram_bus'];
    ramCl = json['ram_cl'];
    ramVoltage = json['ram_voltage'];
    ramUnit = json['ram_unit'];
    ramWaranty = json['ram_waranty'];
    ramScore = json['ram_score'];
    ramPriceAdv = json['ram_price_adv'];
    ramPriceBan = json['ram_price_ban'];
    ramPriceJib = json['ram_price_jib'];
    ramPriceTk = json['ram_price_tk'];
    ramPriceJedi = json['ram_price_jedi'];
    ramPriceCommore = json['ram_price_commore'];
    ramPriceHwh = json['ram_price_hwh'];
    ramPriceBusitek = json['ram_price_busitek'];
    ramPriceEtc = json['ram_price_etc'];
    ramPicture = json['ram_picture'];
    advId = json['adv_id'];
    tkId = json['tk_id'];
    jediId = json['jedi_id'];
    commId = json['comm_id'];
    soldout = json['soldout'];
    when = json['when'];
    tmpClose = json['tmp_close'];
    timestampTmpClose = json['timestamp_tmp_close'];
    commoreId = json['commore_id'];
    jibId = json['jib_id'];
    bananaId = json['banana_id'];
    isHighlight = json['is_highlight'];
    ramPriceTopvalue = json['ram_price_topvalue'];
    topvalueId = json['topvalue_id'];
    lowestPrice = json['lowest_price'];
    advPath = json['adv_path'];
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
    data['ram_id'] = this.ramId;
    data['ram_brand'] = this.ramBrand;
    data['ram_model'] = this.ramModel;
    data['ram_type'] = this.ramType;
    data['ram_capa'] = this.ramCapa;
    data['ram_bus'] = this.ramBus;
    data['ram_cl'] = this.ramCl;
    data['ram_voltage'] = this.ramVoltage;
    data['ram_unit'] = this.ramUnit;
    data['ram_waranty'] = this.ramWaranty;
    data['ram_score'] = this.ramScore;
    data['ram_price_adv'] = this.ramPriceAdv;
    data['ram_price_ban'] = this.ramPriceBan;
    data['ram_price_jib'] = this.ramPriceJib;
    data['ram_price_tk'] = this.ramPriceTk;
    data['ram_price_jedi'] = this.ramPriceJedi;
    data['ram_price_commore'] = this.ramPriceCommore;
    data['ram_price_hwh'] = this.ramPriceHwh;
    data['ram_price_busitek'] = this.ramPriceBusitek;
    data['ram_price_etc'] = this.ramPriceEtc;
    data['ram_picture'] = this.ramPicture;
    data['adv_id'] = this.advId;
    data['tk_id'] = this.tkId;
    data['jedi_id'] = this.jediId;
    data['comm_id'] = this.commId;
    data['soldout'] = this.soldout;
    data['when'] = this.when;
    data['tmp_close'] = this.tmpClose;
    data['timestamp_tmp_close'] = this.timestampTmpClose;
    data['commore_id'] = this.commoreId;
    data['jib_id'] = this.jibId;
    data['banana_id'] = this.bananaId;
    data['is_highlight'] = this.isHighlight;
    data['ram_price_topvalue'] = this.ramPriceTopvalue;
    data['topvalue_id'] = this.topvalueId;
    data['lowest_price'] = this.lowestPrice;
    data['adv_path'] = this.advPath;
    return data;
  }
}
