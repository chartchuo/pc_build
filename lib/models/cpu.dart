class CpuFilter {
  Set<String> cpuBrand;
  Set<String> cpuSeries;
  Set<String> cpuModel;
  Set<String> cpuSocket;
  int minPrice;
  int maxPrice;

  CpuFilter() {
    cpuBrand = Set<String>();
    cpuSeries = Set<String>();
    cpuModel = Set<String>();
    cpuSocket = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  CpuFilter.fromVgas(List<Cpu> cpus) {
    cpuBrand = cpus.map((v) => v.cpuBrand).toSet();
    cpuSeries = cpus.map((v) => v.cpuSeries).toSet();
    cpuModel = cpus.map((v) => v.cpuModel).toSet();
    cpuSocket = cpus.map((v) => v.cpuSocket).toSet();
    if (cpus.length > 0) {
      minPrice = cpus.map((v) => v.cpuPriceAdv).reduce((a, b) => a < b ? a : b);
      maxPrice = cpus.map((v) => v.cpuPriceAdv).reduce((a, b) => a > b ? a : b);
      minPrice = minPrice ~/ 1000 * 1000;
      maxPrice = maxPrice ~/ 1000 * 1000 + 1000;
    } else {
      minPrice = 0;
      maxPrice = 1000000;
    }
  }
  CpuFilter.clone(CpuFilter filter) {
    cpuBrand = Set<String>()..addAll(filter.cpuBrand);
    cpuSeries = Set<String>()..addAll(filter.cpuSeries);
    cpuModel = Set<String>()..addAll(filter.cpuModel);
    cpuSocket = Set<String>()..addAll(filter.cpuSocket);
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Cpu cpu) {
    if (cpu.cpuPriceAdv < minPrice) return false;
    if (cpu.cpuPriceAdv > maxPrice) return false;
    if (cpuBrand.length != 0 && !cpuBrand.contains(cpu.cpuBrand)) return false;
    if (cpuSeries.length != 0 && !cpuSeries.contains(cpu.cpuSeries))
      return false;
    if (cpuModel.length != 0 && !cpuModel.contains(cpu.cpuModel)) return false;
    if (cpuSocket.length != 0 && !cpuSocket.contains(cpu.cpuSocket))
      return false;
    return true;
  }

  List<Cpu> filters(List<Cpu> cpus) {
    List<Cpu> result = [];
    cpus.forEach((v) {
      if (filter(v)) result.add(v);
    });

    return result;
  }
}

class Cpu {
  String cat;
  int id;
  int view;
  int currentweek;
  int lastweek;
  int last2week;
  int lastupdate;
  int cpuId;
  String cpuBrand;
  String cpuSeries;
  String cpuModel;
  String cpuSocket;
  String cpuCt;
  dynamic cpuFrequency;
  dynamic cpuTurbo;
  String cpuBus;
  dynamic cpuArchitec;
  String cpuL2;
  String cpuL3;
  int cpuVgaChip;
  dynamic cpuPower;
  int cpuWaranty;
  int cpuScore;
  int score3D11;
  int cpuPriceAdv;
  int cpuPriceBan;
  int cpuPriceJib;
  int cpuPriceTk;
  int cpuPriceJedi;
  int cpuPriceCommore;
  int cpuPriceHwh;
  int cpuPriceBusitek;
  int cpuPriceEtc;
  int priceMark;
  String cpuPicture;
  dynamic jediId;
  dynamic tkId;
  int soldout;
  String when;
  int tmpClose;
  String timestampTmpClose;
  dynamic advId;
  dynamic jibId;
  dynamic commoreId;
  dynamic bananaId;
  int isHighlight;
  dynamic topvalueId;
  dynamic cpuPriceTopvalue;
  int advSoldout;
  String advPath;
  int priceAdv;
  int lowestPrice;

  Cpu(
      {this.cat,
      this.id,
      this.view,
      this.currentweek,
      this.lastweek,
      this.last2week,
      this.lastupdate,
      this.cpuId,
      this.cpuBrand,
      this.cpuSeries,
      this.cpuModel,
      this.cpuSocket,
      this.cpuCt,
      this.cpuFrequency,
      this.cpuTurbo,
      this.cpuBus,
      this.cpuArchitec,
      this.cpuL2,
      this.cpuL3,
      this.cpuVgaChip,
      this.cpuPower,
      this.cpuWaranty,
      this.cpuScore,
      this.score3D11,
      this.cpuPriceAdv,
      this.cpuPriceBan,
      this.cpuPriceJib,
      this.cpuPriceTk,
      this.cpuPriceJedi,
      this.cpuPriceCommore,
      this.cpuPriceHwh,
      this.cpuPriceBusitek,
      this.cpuPriceEtc,
      this.priceMark,
      this.cpuPicture,
      this.jediId,
      this.tkId,
      this.soldout,
      this.when,
      this.tmpClose,
      this.timestampTmpClose,
      this.advId,
      this.jibId,
      this.commoreId,
      this.bananaId,
      this.isHighlight,
      this.topvalueId,
      this.cpuPriceTopvalue,
      this.advSoldout,
      this.advPath,
      this.priceAdv,
      this.lowestPrice});

  Cpu.fromJson(Map<String, dynamic> json) {
    cat = json['cat'];
    id = json['id'];
    view = json['view'];
    currentweek = json['currentweek'];
    lastweek = json['lastweek'];
    last2week = json['last2week'];
    lastupdate = json['lastupdate'];
    cpuId = json['cpu_id'];
    cpuBrand = json['cpu_brand'];
    cpuSeries = json['cpu_series'];
    cpuModel = json['cpu_model'];
    cpuSocket = json['cpu_socket'];
    cpuCt = json['cpu_ct'];
    cpuFrequency = json['cpu_frequency'];
    cpuTurbo = json['cpu_turbo'];
    cpuBus = json['cpu_bus'];
    cpuArchitec = json['cpu_architec'];
    cpuL2 = json['cpu_L2'];
    cpuL3 = json['cpu_L3'];
    cpuVgaChip = json['cpu_vga_chip'];
    cpuPower = json['cpu_power'];
    cpuWaranty = json['cpu_waranty'];
    cpuScore = json['cpu_score'];
    score3D11 = json['score3D11'];
    cpuPriceAdv = json['cpu_price_adv'];
    cpuPriceBan = json['cpu_price_ban'];
    cpuPriceJib = json['cpu_price_jib'];
    cpuPriceTk = json['cpu_price_tk'];
    cpuPriceJedi = json['cpu_price_jedi'];
    cpuPriceCommore = json['cpu_price_commore'];
    cpuPriceHwh = json['cpu_price_hwh'];
    cpuPriceBusitek = json['cpu_price_busitek'];
    cpuPriceEtc = json['cpu_price_etc'];
    priceMark = json['price_mark'];
    cpuPicture = json['cpu_picture'];
    jediId = json['jedi_id'];
    tkId = json['tk_id'];
    soldout = json['soldout'];
    when = json['when'];
    tmpClose = json['tmp_close'];
    timestampTmpClose = json['timestamp_tmp_close'];
    advId = json['adv_id'];
    jibId = json['jib_id'];
    commoreId = json['commore_id'];
    bananaId = json['banana_id'];
    isHighlight = json['is_highlight'];
    topvalueId = json['topvalue_id'];
    cpuPriceTopvalue = json['cpu_price_topvalue'];
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
    data['cpu_id'] = this.cpuId;
    data['cpu_brand'] = this.cpuBrand;
    data['cpu_series'] = this.cpuSeries;
    data['cpu_model'] = this.cpuModel;
    data['cpu_socket'] = this.cpuSocket;
    data['cpu_ct'] = this.cpuCt;
    data['cpu_frequency'] = this.cpuFrequency;
    data['cpu_turbo'] = this.cpuTurbo;
    data['cpu_bus'] = this.cpuBus;
    data['cpu_architec'] = this.cpuArchitec;
    data['cpu_L2'] = this.cpuL2;
    data['cpu_L3'] = this.cpuL3;
    data['cpu_vga_chip'] = this.cpuVgaChip;
    data['cpu_power'] = this.cpuPower;
    data['cpu_waranty'] = this.cpuWaranty;
    data['cpu_score'] = this.cpuScore;
    data['score3D11'] = this.score3D11;
    data['cpu_price_adv'] = this.cpuPriceAdv;
    data['cpu_price_ban'] = this.cpuPriceBan;
    data['cpu_price_jib'] = this.cpuPriceJib;
    data['cpu_price_tk'] = this.cpuPriceTk;
    data['cpu_price_jedi'] = this.cpuPriceJedi;
    data['cpu_price_commore'] = this.cpuPriceCommore;
    data['cpu_price_hwh'] = this.cpuPriceHwh;
    data['cpu_price_busitek'] = this.cpuPriceBusitek;
    data['cpu_price_etc'] = this.cpuPriceEtc;
    data['price_mark'] = this.priceMark;
    data['cpu_picture'] = this.cpuPicture;
    data['jedi_id'] = this.jediId;
    data['tk_id'] = this.tkId;
    data['soldout'] = this.soldout;
    data['when'] = this.when;
    data['tmp_close'] = this.tmpClose;
    data['timestamp_tmp_close'] = this.timestampTmpClose;
    data['adv_id'] = this.advId;
    data['jib_id'] = this.jibId;
    data['commore_id'] = this.commoreId;
    data['banana_id'] = this.bananaId;
    data['is_highlight'] = this.isHighlight;
    data['topvalue_id'] = this.topvalueId;
    data['cpu_price_topvalue'] = this.cpuPriceTopvalue;
    data['adv_soldout'] = this.advSoldout;
    data['adv_path'] = this.advPath;
    data['price_adv'] = this.priceAdv;
    data['lowest_price'] = this.lowestPrice;
    return data;
  }
}
