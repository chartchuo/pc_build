class PsuFilter {
  Set<String> psuBrand;
  Set<String> psuModular;
  Set<String> psuEnergyEff;
  Set<String> psuMaxPw;
  int minPrice;
  int maxPrice;

  PsuFilter() {
    psuBrand = Set<String>();
    psuModular = Set<String>();
    psuEnergyEff = Set<String>();
    psuMaxPw = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  PsuFilter.fromList(List<Psu> list) {
    psuBrand = list.map((v) => v.psuBrand).toSet();
    psuModular = list.map((v) => v.psuModular).toSet();
    psuEnergyEff = list.map((v) => v.psuEnergyEff).toSet();
    psuMaxPw = list.map((v) => v.psuMaxPw).toSet();
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
  PsuFilter.clone(PsuFilter filter) {
    psuBrand = Set<String>()..addAll(filter.psuBrand);
    psuModular = Set<String>()..addAll(filter.psuModular);
    psuEnergyEff = Set<String>()..addAll(filter.psuEnergyEff);
    psuMaxPw = Set<String>()..addAll(filter.psuMaxPw);
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Psu device) {
    if (device.lowestPrice < minPrice) return false;
    if (device.lowestPrice > maxPrice) return false;
    if (psuBrand.length != 0 && !psuBrand.contains(device.psuBrand))
      return false;
    if (psuModular.length != 0 && !psuModular.contains(device.psuModular))
      return false;
    if (psuEnergyEff.length != 0 && !psuEnergyEff.contains(device.psuEnergyEff))
      return false;
    if (psuMaxPw.length != 0 && !psuMaxPw.contains(device.psuMaxPw))
      return false;
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

class Psu {
  String cat;
  int id;
  int view;
  int currentweek;
  int lastweek;
  int last2week;
  int lastupdate;
  int psuId;
  String psuBrand;
  String psuModel;
  String psuSeries;
  String psuType;
  String psuMaxPw;
  String psuFans;
  String psuPfc;
  String psuMainConnect;
  String psuPciEx;
  int psuSataConnect;
  String psuSli;
  String psuCf;
  String psuModular;
  String psuEfficiency;
  String psuEnergyEff;
  String psuOverVolt;
  String psuInputVolt;
  String psuInputFrequency;
  String psuMtbf;
  String psuDimension;
  String psuFeature;
  int psuWaranty;
  int psuScore;
  int psuPriceAdv;
  int psuPriceBan;
  int psuPriceJib;
  int psuPriceTk;
  int psuPriceJedi;
  int psuPriceCommore;
  int psuPriceHwh;
  int psuPriceBusitek;
  int psuPriceEtc;
  String psuPicture;
  dynamic advId;
  dynamic tkId;
  String jediId;
  int soldout;
  String when;
  int tmpClose;
  String timestampTmpClose;
  dynamic commoreId;
  dynamic jibId;
  int bananaId;
  int isHighlight;
  dynamic psuPriceTopvalue;
  dynamic topvalueId;
  int advSoldout;
  String advPath;
  int priceAdv;
  int lowestPrice;

  Psu(
      {this.cat,
      this.id,
      this.view,
      this.currentweek,
      this.lastweek,
      this.last2week,
      this.lastupdate,
      this.psuId,
      this.psuBrand,
      this.psuModel,
      this.psuSeries,
      this.psuType,
      this.psuMaxPw,
      this.psuFans,
      this.psuPfc,
      this.psuMainConnect,
      this.psuPciEx,
      this.psuSataConnect,
      this.psuSli,
      this.psuCf,
      this.psuModular,
      this.psuEfficiency,
      this.psuEnergyEff,
      this.psuOverVolt,
      this.psuInputVolt,
      this.psuInputFrequency,
      this.psuMtbf,
      this.psuDimension,
      this.psuFeature,
      this.psuWaranty,
      this.psuScore,
      this.psuPriceAdv,
      this.psuPriceBan,
      this.psuPriceJib,
      this.psuPriceTk,
      this.psuPriceJedi,
      this.psuPriceCommore,
      this.psuPriceHwh,
      this.psuPriceBusitek,
      this.psuPriceEtc,
      this.psuPicture,
      this.advId,
      this.tkId,
      this.jediId,
      this.soldout,
      this.when,
      this.tmpClose,
      this.timestampTmpClose,
      this.commoreId,
      this.jibId,
      this.bananaId,
      this.isHighlight,
      this.psuPriceTopvalue,
      this.topvalueId,
      this.advSoldout,
      this.advPath,
      this.priceAdv,
      this.lowestPrice});

  Psu.fromJson(Map<String, dynamic> json) {
    cat = json['cat'];
    id = json['id'];
    view = json['view'];
    currentweek = json['currentweek'];
    lastweek = json['lastweek'];
    last2week = json['last2week'];
    lastupdate = json['lastupdate'];
    psuId = json['psu_id'];
    psuBrand = json['psu_brand'];
    psuModel = json['psu_model'];
    psuSeries = json['psu_series'];
    psuType = json['psu_type'];
    psuMaxPw = json['psu_max_pw'];
    psuFans = json['psu_fans'];
    psuPfc = json['psu_pfc'];
    psuMainConnect = json['psu_main_connect'];
    psuPciEx = json['psu_pci_ex'];
    psuSataConnect = json['psu_sata_connect'];
    psuSli = json['psu_sli'];
    psuCf = json['psu_cf'];
    psuModular = json['psu_modular'];
    psuEfficiency = json['psu_efficiency'];
    psuEnergyEff = json['psu_energy_eff'];
    psuOverVolt = json['psu_over_volt'];
    psuInputVolt = json['psu_input_volt'];
    psuInputFrequency = json['psu_input_frequency'];
    psuMtbf = json['psu_mtbf'];
    psuDimension = json['psu_dimension'];
    psuFeature = json['psu_feature'];
    psuWaranty = json['psu_waranty'];
    psuScore = json['psu_score'];
    psuPriceAdv = json['psu_price_adv'];
    psuPriceBan = json['psu_price_ban'];
    psuPriceJib = json['psu_price_jib'];
    psuPriceTk = json['psu_price_tk'];
    psuPriceJedi = json['psu_price_jedi'];
    psuPriceCommore = json['psu_price_commore'];
    psuPriceHwh = json['psu_price_hwh'];
    psuPriceBusitek = json['psu_price_busitek'];
    psuPriceEtc = json['psu_price_etc'];
    psuPicture = json['psu_picture'];
    advId = json['adv_id'];
    tkId = json['tk_id'];
    jediId = json['jedi_id'];
    soldout = json['soldout'];
    when = json['when'];
    tmpClose = json['tmp_close'];
    timestampTmpClose = json['timestamp_tmp_close'];
    commoreId = json['commore_id'];
    jibId = json['jib_id'];
    bananaId = json['banana_id'];
    isHighlight = json['is_highlight'];
    psuPriceTopvalue = json['psu_price_topvalue'];
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
    data['psu_id'] = this.psuId;
    data['psu_brand'] = this.psuBrand;
    data['psu_model'] = this.psuModel;
    data['psu_series'] = this.psuSeries;
    data['psu_type'] = this.psuType;
    data['psu_max_pw'] = this.psuMaxPw;
    data['psu_fans'] = this.psuFans;
    data['psu_pfc'] = this.psuPfc;
    data['psu_main_connect'] = this.psuMainConnect;
    data['psu_pci_ex'] = this.psuPciEx;
    data['psu_sata_connect'] = this.psuSataConnect;
    data['psu_sli'] = this.psuSli;
    data['psu_cf'] = this.psuCf;
    data['psu_modular'] = this.psuModular;
    data['psu_efficiency'] = this.psuEfficiency;
    data['psu_energy_eff'] = this.psuEnergyEff;
    data['psu_over_volt'] = this.psuOverVolt;
    data['psu_input_volt'] = this.psuInputVolt;
    data['psu_input_frequency'] = this.psuInputFrequency;
    data['psu_mtbf'] = this.psuMtbf;
    data['psu_dimension'] = this.psuDimension;
    data['psu_feature'] = this.psuFeature;
    data['psu_waranty'] = this.psuWaranty;
    data['psu_score'] = this.psuScore;
    data['psu_price_adv'] = this.psuPriceAdv;
    data['psu_price_ban'] = this.psuPriceBan;
    data['psu_price_jib'] = this.psuPriceJib;
    data['psu_price_tk'] = this.psuPriceTk;
    data['psu_price_jedi'] = this.psuPriceJedi;
    data['psu_price_commore'] = this.psuPriceCommore;
    data['psu_price_hwh'] = this.psuPriceHwh;
    data['psu_price_busitek'] = this.psuPriceBusitek;
    data['psu_price_etc'] = this.psuPriceEtc;
    data['psu_picture'] = this.psuPicture;
    data['adv_id'] = this.advId;
    data['tk_id'] = this.tkId;
    data['jedi_id'] = this.jediId;
    data['soldout'] = this.soldout;
    data['when'] = this.when;
    data['tmp_close'] = this.tmpClose;
    data['timestamp_tmp_close'] = this.timestampTmpClose;
    data['commore_id'] = this.commoreId;
    data['jib_id'] = this.jibId;
    data['banana_id'] = this.bananaId;
    data['is_highlight'] = this.isHighlight;
    data['psu_price_topvalue'] = this.psuPriceTopvalue;
    data['topvalue_id'] = this.topvalueId;
    data['adv_soldout'] = this.advSoldout;
    data['adv_path'] = this.advPath;
    data['price_adv'] = this.priceAdv;
    data['lowest_price'] = this.lowestPrice;
    return data;
  }
}
