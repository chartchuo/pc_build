class MonFilter {
  Set<String> monBrand;
  Set<String> monPanel2;
  Set<String> monSize;
  int minPrice;
  int maxPrice;

  MonFilter() {
    monBrand = Set<String>();
    monPanel2 = Set<String>();
    monSize = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  MonFilter.fromList(List<Mon> list) {
    monBrand = list.map((v) => v.monBrand).toSet();
    monPanel2 = list.map((v) => v.monPanel2).toSet();
    monSize = list.map((v) => v.monSize.toString()).toSet();
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
  MonFilter.clone(MonFilter filter) {
    monBrand = Set<String>()..addAll(filter.monBrand);
    monPanel2 = Set<String>()..addAll(filter.monPanel2);
    monSize = Set<String>()..addAll(filter.monSize);
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Mon device) {
    if (device.lowestPrice < minPrice) return false;
    if (device.lowestPrice > maxPrice) return false;
    if (monBrand.length != 0 && !monBrand.contains(device.monBrand))
      return false;
    if (monPanel2.length != 0 && !monPanel2.contains(device.monPanel2))
      return false;
    if (monSize.length != 0 && !monSize.contains(device.monSize.toString()))
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

class Mon {
  String cat;
  int id;
  int view;
  int currentweek;
  int lastweek;
  int last2week;
  int lastupdate;
  int monId;
  String monBrand;
  String monType;
  String monModel;
  int monFullHD;
  dynamic monSize;
  String monSizeDetail;
  String monPanel;
  String monPanel2;
  String monReso;
  int monRefreshRate;
  String monPitch;
  String monResponse;
  dynamic monCont;
  int monBright;
  String monAngle;
  int monVga;
  int monDvi;
  int monHdmi;
  int monUsb;
  int monDisplayport;
  int monComp;
  String monFeature1;
  int monWar;
  int monPriceAdv;
  int monPriceBan;
  int monPriceJib;
  int monPriceTk;
  int monPriceJedi;
  int monPriceHwh;
  int monPriceCommore;
  int monPriceBusitek;
  int monPriceEtc;
  int priceMark;
  String monPicture;
  int monSold;
  dynamic advId;
  dynamic tkId;
  String jediId;
  String when;
  int tmpClose;
  String timestampTmpClose;
  dynamic commoreId;
  dynamic jibId;
  int bananaId;
  int isHighlight;
  dynamic monPriceTopvalue;
  dynamic topvalueId;
  String review;
  int lowestPrice;

  Mon(
      {this.cat,
      this.id,
      this.view,
      this.currentweek,
      this.lastweek,
      this.last2week,
      this.lastupdate,
      this.monId,
      this.monBrand,
      this.monType,
      this.monModel,
      this.monFullHD,
      this.monSize,
      this.monSizeDetail,
      this.monPanel,
      this.monPanel2,
      this.monReso,
      this.monRefreshRate,
      this.monPitch,
      this.monResponse,
      this.monCont,
      this.monBright,
      this.monAngle,
      this.monVga,
      this.monDvi,
      this.monHdmi,
      this.monUsb,
      this.monDisplayport,
      this.monComp,
      this.monFeature1,
      this.monWar,
      this.monPriceAdv,
      this.monPriceBan,
      this.monPriceJib,
      this.monPriceTk,
      this.monPriceJedi,
      this.monPriceHwh,
      this.monPriceCommore,
      this.monPriceBusitek,
      this.monPriceEtc,
      this.priceMark,
      this.monPicture,
      this.monSold,
      this.advId,
      this.tkId,
      this.jediId,
      this.when,
      this.tmpClose,
      this.timestampTmpClose,
      this.commoreId,
      this.jibId,
      this.bananaId,
      this.isHighlight,
      this.monPriceTopvalue,
      this.topvalueId,
      this.review,
      this.lowestPrice});

  Mon.fromJson(Map<String, dynamic> json) {
    cat = json['cat'];
    id = json['id'];
    view = json['view'];
    currentweek = json['currentweek'];
    lastweek = json['lastweek'];
    last2week = json['last2week'];
    lastupdate = json['lastupdate'];
    monId = json['mon_id'];
    monBrand = json['mon_brand'];
    monType = json['mon_type'];
    monModel = json['mon_model'];
    monFullHD = json['mon_Full_HD'];
    monSize = json['mon_size'];
    monSizeDetail = json['mon_size_detail'];
    monPanel = json['mon_panel'];
    monPanel2 = json['mon_panel2'];
    monReso = json['mon_reso'];
    monRefreshRate = json['mon_refresh_rate'];
    monPitch = json['mon_pitch'];
    monResponse = json['mon_response'];
    monCont = json['mon_cont'];
    monBright = json['mon_bright'];
    monAngle = json['mon_angle'];
    monVga = json['mon_vga'];
    monDvi = json['mon_dvi'];
    monHdmi = json['mon_hdmi'];
    monUsb = json['mon_usb'];
    monDisplayport = json['mon_displayport'];
    monComp = json['mon_comp'];
    monFeature1 = json['mon_feature1'];
    monWar = json['mon_war'];
    monPriceAdv = json['mon_price_adv'];
    monPriceBan = json['mon_price_ban'];
    monPriceJib = json['mon_price_jib'];
    monPriceTk = json['mon_price_tk'];
    monPriceJedi = json['mon_price_jedi'];
    monPriceHwh = json['mon_price_hwh'];
    monPriceCommore = json['mon_price_commore'];
    monPriceBusitek = json['mon_price_busitek'];
    monPriceEtc = json['mon_price_etc'];
    priceMark = json['price_mark'];
    monPicture = json['mon_picture'];
    monSold = json['mon_sold'];
    advId = json['adv_id'];
    tkId = json['tk_id'];
    jediId = json['jedi_id'];
    when = json['when'];
    tmpClose = json['tmp_close'];
    timestampTmpClose = json['timestamp_tmp_close'];
    commoreId = json['commore_id'];
    jibId = json['jib_id'];
    bananaId = json['banana_id'];
    isHighlight = json['is_highlight'];
    monPriceTopvalue = json['mon_price_topvalue'];
    topvalueId = json['topvalue_id'];
    review = json['review'];
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
    data['mon_id'] = this.monId;
    data['mon_brand'] = this.monBrand;
    data['mon_type'] = this.monType;
    data['mon_model'] = this.monModel;
    data['mon_Full_HD'] = this.monFullHD;
    data['mon_size'] = this.monSize;
    data['mon_size_detail'] = this.monSizeDetail;
    data['mon_panel'] = this.monPanel;
    data['mon_panel2'] = this.monPanel2;
    data['mon_reso'] = this.monReso;
    data['mon_refresh_rate'] = this.monRefreshRate;
    data['mon_pitch'] = this.monPitch;
    data['mon_response'] = this.monResponse;
    data['mon_cont'] = this.monCont;
    data['mon_bright'] = this.monBright;
    data['mon_angle'] = this.monAngle;
    data['mon_vga'] = this.monVga;
    data['mon_dvi'] = this.monDvi;
    data['mon_hdmi'] = this.monHdmi;
    data['mon_usb'] = this.monUsb;
    data['mon_displayport'] = this.monDisplayport;
    data['mon_comp'] = this.monComp;
    data['mon_feature1'] = this.monFeature1;
    data['mon_war'] = this.monWar;
    data['mon_price_adv'] = this.monPriceAdv;
    data['mon_price_ban'] = this.monPriceBan;
    data['mon_price_jib'] = this.monPriceJib;
    data['mon_price_tk'] = this.monPriceTk;
    data['mon_price_jedi'] = this.monPriceJedi;
    data['mon_price_hwh'] = this.monPriceHwh;
    data['mon_price_commore'] = this.monPriceCommore;
    data['mon_price_busitek'] = this.monPriceBusitek;
    data['mon_price_etc'] = this.monPriceEtc;
    data['price_mark'] = this.priceMark;
    data['mon_picture'] = this.monPicture;
    data['mon_sold'] = this.monSold;
    data['adv_id'] = this.advId;
    data['tk_id'] = this.tkId;
    data['jedi_id'] = this.jediId;
    data['when'] = this.when;
    data['tmp_close'] = this.tmpClose;
    data['timestamp_tmp_close'] = this.timestampTmpClose;
    data['commore_id'] = this.commoreId;
    data['jib_id'] = this.jibId;
    data['banana_id'] = this.bananaId;
    data['is_highlight'] = this.isHighlight;
    data['mon_price_topvalue'] = this.monPriceTopvalue;
    data['topvalue_id'] = this.topvalueId;
    data['review'] = this.review;
    data['lowest_price'] = this.lowestPrice;
    return data;
  }
}
