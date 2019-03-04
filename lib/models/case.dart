class CaseFilter {
  Set<String> caseBrand;
  Set<String> caseType;
  Set<String> caseMbSize;
  int minPrice;
  int maxPrice;

  CaseFilter() {
    caseBrand = Set<String>();
    caseType = Set<String>();
    caseMbSize = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  CaseFilter.fromList(List<Case> list) {
    caseBrand = list.map((v) => v.caseBrand).toSet();
    caseType = list.map((v) => v.caseType).toSet();
    caseMbSize = list.map((v) => v.caseMbSize).toSet();
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
  CaseFilter.clone(CaseFilter filter) {
    caseBrand = Set<String>()..addAll(filter.caseBrand);
    caseType = Set<String>()..addAll(filter.caseType);
    caseMbSize = Set<String>()..addAll(filter.caseMbSize);
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Case device) {
    if (device.lowestPrice < minPrice) return false;
    if (device.lowestPrice > maxPrice) return false;
    if (caseBrand.length != 0 && !caseBrand.contains(device.caseBrand))
      return false;
    if (caseType.length != 0 && !caseType.contains(device.caseType))
      return false;
    if (caseMbSize.length != 0 && !caseMbSize.contains(device.caseMbSize))
      return false;
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

class Case {
  String cat;
  int id;
  int view;
  int currentweek;
  int lastweek;
  int last2week;
  int lastupdate;
  int caseId;
  String caseBrand;
  String caseModel;
  String caseType;
  int caseScore;
  String caseMbSize;
  String caseMat;
  String caseDimension;
  String caseColor;
  String caseIo;
  dynamic caseWeight;
  dynamic caseVgaCompat;
  dynamic caseHeatsink;
  dynamic caseRadiator;
  String casePsuBuilt;
  dynamic caseFanFront;
  String caseFanRear;
  dynamic caseFanTop;
  String caseFanSide;
  dynamic caseFanBottom;
  int casePriceAdv;
  int casePriceBan;
  int casePriceJib;
  int casePriceTk;
  int casePriceJedi;
  int casePriceCommore;
  int casePriceHwh;
  int casePriceBusitek;
  int casePriceEtc;
  dynamic priceMark;
  String casePicture;
  int soldout;
  String tkId;
  String jediId;
  String when;
  int tmpClose;
  String timestampTmpClose;
  dynamic advId;
  dynamic commoreId;
  dynamic jibId;
  int bananaId;
  int isHighlight;
  dynamic casePriceTopvalue;
  dynamic topvalueId;
  int advSoldout;
  String advPath;
  int priceAdv;
  int lowestPrice;

  Case(
      {this.cat,
      this.id,
      this.view,
      this.currentweek,
      this.lastweek,
      this.last2week,
      this.lastupdate,
      this.caseId,
      this.caseBrand,
      this.caseModel,
      this.caseType,
      this.caseScore,
      this.caseMbSize,
      this.caseMat,
      this.caseDimension,
      this.caseColor,
      this.caseIo,
      this.caseWeight,
      this.caseVgaCompat,
      this.caseHeatsink,
      this.caseRadiator,
      this.casePsuBuilt,
      this.caseFanFront,
      this.caseFanRear,
      this.caseFanTop,
      this.caseFanSide,
      this.caseFanBottom,
      this.casePriceAdv,
      this.casePriceBan,
      this.casePriceJib,
      this.casePriceTk,
      this.casePriceJedi,
      this.casePriceCommore,
      this.casePriceHwh,
      this.casePriceBusitek,
      this.casePriceEtc,
      this.priceMark,
      this.casePicture,
      this.soldout,
      this.tkId,
      this.jediId,
      this.when,
      this.tmpClose,
      this.timestampTmpClose,
      this.advId,
      this.commoreId,
      this.jibId,
      this.bananaId,
      this.isHighlight,
      this.casePriceTopvalue,
      this.topvalueId,
      this.advSoldout,
      this.advPath,
      this.priceAdv,
      this.lowestPrice});

  Case.fromJson(Map<String, dynamic> json) {
    cat = json['cat'];
    id = json['id'];
    view = json['view'];
    currentweek = json['currentweek'];
    lastweek = json['lastweek'];
    last2week = json['last2week'];
    lastupdate = json['lastupdate'];
    caseId = json['case_id'];
    caseBrand = json['case_brand'];
    caseModel = json['case_model'].toString();
    caseType = json['case_type'];
    caseScore = json['case_score'];
    caseMbSize = json['case_mb_size'];
    caseMat = json['case_mat'];
    caseDimension = json['case_dimension'];
    caseColor = json['case_color'];
    caseIo = json['case_io'];
    caseWeight = json['case_weight'];
    caseVgaCompat = json['case_vga_compat'];
    caseHeatsink = json['case_heatsink'];
    caseRadiator = json['case_radiator'];
    casePsuBuilt = json['case_psu_built'];
    caseFanFront = json['case_fan_front'];
    caseFanRear = json['case_fan_rear'];
    caseFanTop = json['case_fan_top'];
    caseFanSide = json['case_fan_side'];
    caseFanBottom = json['case_fan_bottom'];
    casePriceAdv = json['case_price_adv'];
    casePriceBan = json['case_price_ban'];
    casePriceJib = json['case_price_jib'];
    casePriceTk = json['case_price_tk'];
    casePriceJedi = json['case_price_jedi'];
    casePriceCommore = json['case_price_commore'];
    casePriceHwh = json['case_price_hwh'];
    casePriceBusitek = json['case_price_busitek'];
    casePriceEtc = json['case_price_etc'];
    priceMark = json['price_mark'];
    casePicture = json['case_picture'];
    soldout = json['soldout'];
    tkId = json['tk_id'];
    jediId = json['jedi_id'];
    when = json['when'];
    tmpClose = json['tmp_close'];
    timestampTmpClose = json['timestamp_tmp_close'];
    advId = json['adv_id'];
    commoreId = json['commore_id'];
    jibId = json['jib_id'];
    bananaId = json['banana_id'];
    isHighlight = json['is_highlight'];
    casePriceTopvalue = json['case_price_topvalue'];
    topvalueId = json['topvalue_id'];
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
    data['case_id'] = this.caseId;
    data['case_brand'] = this.caseBrand;
    data['case_model'] = this.caseModel;
    data['case_type'] = this.caseType;
    data['case_score'] = this.caseScore;
    data['case_mb_size'] = this.caseMbSize;
    data['case_mat'] = this.caseMat;
    data['case_dimension'] = this.caseDimension;
    data['case_color'] = this.caseColor;
    data['case_io'] = this.caseIo;
    data['case_weight'] = this.caseWeight;
    data['case_vga_compat'] = this.caseVgaCompat;
    data['case_heatsink'] = this.caseHeatsink;
    data['case_radiator'] = this.caseRadiator;
    data['case_psu_built'] = this.casePsuBuilt;
    data['case_fan_front'] = this.caseFanFront;
    data['case_fan_rear'] = this.caseFanRear;
    data['case_fan_top'] = this.caseFanTop;
    data['case_fan_side'] = this.caseFanSide;
    data['case_fan_bottom'] = this.caseFanBottom;
    data['case_price_adv'] = this.casePriceAdv;
    data['case_price_ban'] = this.casePriceBan;
    data['case_price_jib'] = this.casePriceJib;
    data['case_price_tk'] = this.casePriceTk;
    data['case_price_jedi'] = this.casePriceJedi;
    data['case_price_commore'] = this.casePriceCommore;
    data['case_price_hwh'] = this.casePriceHwh;
    data['case_price_busitek'] = this.casePriceBusitek;
    data['case_price_etc'] = this.casePriceEtc;
    data['price_mark'] = this.priceMark;
    data['case_picture'] = this.casePicture;
    data['soldout'] = this.soldout;
    data['tk_id'] = this.tkId;
    data['jedi_id'] = this.jediId;
    data['when'] = this.when;
    data['tmp_close'] = this.tmpClose;
    data['timestamp_tmp_close'] = this.timestampTmpClose;
    data['adv_id'] = this.advId;
    data['commore_id'] = this.commoreId;
    data['jib_id'] = this.jibId;
    data['banana_id'] = this.bananaId;
    data['is_highlight'] = this.isHighlight;
    data['case_price_topvalue'] = this.casePriceTopvalue;
    data['topvalue_id'] = this.topvalueId;
    data['adv_soldout'] = this.advSoldout;
    data['adv_path'] = this.advPath;
    data['price_adv'] = this.priceAdv;
    data['lowest_price'] = this.lowestPrice;
    return data;
  }
}
