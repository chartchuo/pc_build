class MbFilter {
  Set<String> mbBrand;
  Set<String> mbFactor;
  Set<String> mbChipset;
  Set<String> mbSocket;
  int minPrice;
  int maxPrice;

  MbFilter() {
    mbBrand = Set<String>();
    mbFactor = Set<String>();
    mbChipset = Set<String>();
    mbSocket = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  MbFilter.fromList(List<Mb> list) {
    mbBrand = list.map((v) => v.mbBrand).toSet();
    mbFactor = list.map((v) => v.mbFactor).toSet();
    mbChipset = list.map((v) => v.mbChipset).toSet();
    mbSocket = list.map((v) => v.mbSocket).toSet();
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
  MbFilter.clone(MbFilter filter) {
    mbBrand = Set<String>()..addAll(filter.mbBrand);
    mbFactor = Set<String>()..addAll(filter.mbFactor);
    mbChipset = Set<String>()..addAll(filter.mbChipset);
    mbSocket = Set<String>()..addAll(filter.mbSocket);
    minPrice = filter.minPrice;
    maxPrice = filter.maxPrice;
  }
  bool filter(Mb device) {
    if (device.lowestPrice < minPrice) return false;
    if (device.lowestPrice > maxPrice) return false;
    if (mbBrand.length != 0 && !mbBrand.contains(device.mbBrand)) return false;
    if (mbFactor.length != 0 && !mbFactor.contains(device.mbFactor))
      return false;
    if (mbSocket.length != 0 && !mbSocket.contains(device.mbSocket))
      return false;
    if (mbChipset.length != 0 && !mbChipset.contains(device.mbChipset))
      return false;
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

class Mb {
  String cat;
  int id;
  int view;
  int currentweek;
  int lastweek;
  int last2week;
  int lastupdate;
  int mbId;
  String mbBrand;
  String mbModel;
  String mbSocket;
  String mbMbList;
  String mbChipset;
  int mbMemSlot;
  String mbMemType;
  String mbMaxCapa;
  String mbMbPeak;
  String mbVgaOn;
  String mbAudioChip;
  String mbAudioChan;
  int mbSata2;
  int mbSata3;
  int mbM2;
  String mbM2type;
  int mbMsata;
  String mbRaid;
  int mbUsb2;
  int mbUsb3;
  int mbUsb3a;
  int mbUsb3c;
  dynamic mbSerial;
  dynamic parallel;
  int mbDsub;
  int mbDvi;
  int mbHdmi;
  int mbMinihdmi;
  int mbDisplayport;
  int mbMinidisplayport;
  int mbAudioRear;
  int mbPs2;
  dynamic mbOptPort;
  dynamic mbSli;
  dynamic mbCf;
  dynamic mbPowerPhrase;
  int mbPciNo;
  int mbPcieNo;
  String mbPciDetail;
  String mbLan;
  String mbLanSpeed;
  String mbFactor;
  String mbPwPin;
  String mbDimension;
  String mbFeature;
  int mbWaranty;
  int mbScore;
  int mbPriceAdv;
  int mbPriceBan;
  int mbPriceJib;
  int mbPriceTk;
  int mbPriceJedi;
  int mbPriceCommore;
  int mbPriceHwh;
  int mbPriceBusitek;
  int mbPriceEtc;
  int priceMark;
  String mbPicture;
  dynamic advId;
  int soldout;
  dynamic tkId;
  dynamic jediId;
  String when;
  int tmpClose;
  String timestampTmpClose;
  dynamic commoreId;
  dynamic jibId;
  dynamic bananaId;
  int isHighlight;
  dynamic mbPriceTopvalue;
  dynamic topvalueId;
  int lowestPrice;
  String advPath;

  Mb(
      {this.cat,
      this.id,
      this.view,
      this.currentweek,
      this.lastweek,
      this.last2week,
      this.lastupdate,
      this.mbId,
      this.mbBrand,
      this.mbModel,
      this.mbSocket,
      this.mbMbList,
      this.mbChipset,
      this.mbMemSlot,
      this.mbMemType,
      this.mbMaxCapa,
      this.mbMbPeak,
      this.mbVgaOn,
      this.mbAudioChip,
      this.mbAudioChan,
      this.mbSata2,
      this.mbSata3,
      this.mbM2,
      this.mbM2type,
      this.mbMsata,
      this.mbRaid,
      this.mbUsb2,
      this.mbUsb3,
      this.mbUsb3a,
      this.mbUsb3c,
      this.mbSerial,
      this.parallel,
      this.mbDsub,
      this.mbDvi,
      this.mbHdmi,
      this.mbMinihdmi,
      this.mbDisplayport,
      this.mbMinidisplayport,
      this.mbAudioRear,
      this.mbPs2,
      this.mbOptPort,
      this.mbSli,
      this.mbCf,
      this.mbPowerPhrase,
      this.mbPciNo,
      this.mbPcieNo,
      this.mbPciDetail,
      this.mbLan,
      this.mbLanSpeed,
      this.mbFactor,
      this.mbPwPin,
      this.mbDimension,
      this.mbFeature,
      this.mbWaranty,
      this.mbScore,
      this.mbPriceAdv,
      this.mbPriceBan,
      this.mbPriceJib,
      this.mbPriceTk,
      this.mbPriceJedi,
      this.mbPriceCommore,
      this.mbPriceHwh,
      this.mbPriceBusitek,
      this.mbPriceEtc,
      this.priceMark,
      this.mbPicture,
      this.advId,
      this.soldout,
      this.tkId,
      this.jediId,
      this.when,
      this.tmpClose,
      this.timestampTmpClose,
      this.commoreId,
      this.jibId,
      this.bananaId,
      this.isHighlight,
      this.mbPriceTopvalue,
      this.topvalueId,
      this.lowestPrice,
      this.advPath});

  Mb.fromJson(Map<String, dynamic> json) {
    cat = json['cat'];
    id = json['id'];
    view = json['view'];
    currentweek = json['currentweek'];
    lastweek = json['lastweek'];
    last2week = json['last2week'];
    lastupdate = json['lastupdate'];
    mbId = json['mb_id'];
    mbBrand = json['mb_brand'];
    mbModel = json['mb_model'];
    mbSocket = json['mb_socket'];
    mbMbList = json['mb_mb_list'];
    mbChipset = json['mb_chipset'];
    mbMemSlot = json['mb_mem_slot'];
    mbMemType = json['mb_mem_type'];
    mbMaxCapa = json['mb_max_capa'];
    mbMbPeak = json['mb_mb_peak'];
    mbVgaOn = json['mb_vga_on'];
    mbAudioChip = json['mb_audio_chip'];
    mbAudioChan = json['mb_audio_chan'];
    mbSata2 = json['mb_sata2'];
    mbSata3 = json['mb_sata3'];
    mbM2 = json['mb_m2'];
    mbM2type = json['mb_m2type'];
    mbMsata = json['mb_msata'];
    mbRaid = json['mb_raid'];
    mbUsb2 = json['mb_usb2'];
    mbUsb3 = json['mb_usb3'];
    mbUsb3a = json['mb_usb3a'];
    mbUsb3c = json['mb_usb3c'];
    mbSerial = json['mb_serial'];
    parallel = json['parallel'];
    mbDsub = json['mb_dsub'];
    mbDvi = json['mb_dvi'];
    mbHdmi = json['mb_hdmi'];
    mbMinihdmi = json['mb_minihdmi'];
    mbDisplayport = json['mb_displayport'];
    mbMinidisplayport = json['mb_minidisplayport'];
    mbAudioRear = json['mb_audio_rear'];
    mbPs2 = json['mb_ps2'];
    mbOptPort = json['mb_opt_port'];
    mbSli = json['mb_sli'];
    mbCf = json['mb_cf'];
    mbPowerPhrase = json['mb_power_phrase'];
    mbPciNo = json['mb_pci_no'];
    mbPcieNo = json['mb_pcie_no'];
    mbPciDetail = json['mb_pci_detail'];
    mbLan = json['mb_lan'];
    mbLanSpeed = json['mb_lan_speed'];
    mbFactor = json['mb_factor'];
    mbPwPin = json['mb_pw_pin'];
    mbDimension = json['mb_dimension'];
    mbFeature = json['mb_feature'];
    mbWaranty = json['mb_waranty'];
    mbScore = json['mb_score'];
    mbPriceAdv = json['mb_price_adv'];
    mbPriceBan = json['mb_price_ban'];
    mbPriceJib = json['mb_price_jib'];
    mbPriceTk = json['mb_price_tk'];
    mbPriceJedi = json['mb_price_jedi'];
    mbPriceCommore = json['mb_price_commore'];
    mbPriceHwh = json['mb_price_hwh'];
    mbPriceBusitek = json['mb_price_busitek'];
    mbPriceEtc = json['mb_price_etc'];
    priceMark = json['price_mark'];
    mbPicture = json['mb_picture'];
    advId = json['adv_id'];
    soldout = json['soldout'];
    tkId = json['tk_id'];
    jediId = json['jedi_id'];
    when = json['when'];
    tmpClose = json['tmp_close'];
    timestampTmpClose = json['timestamp_tmp_close'];
    commoreId = json['commore_id'];
    jibId = json['jib_id'];
    bananaId = json['banana_id'];
    isHighlight = json['is_highlight'];
    mbPriceTopvalue = json['mb_price_topvalue'];
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
    data['mb_id'] = this.mbId;
    data['mb_brand'] = this.mbBrand;
    data['mb_model'] = this.mbModel;
    data['mb_socket'] = this.mbSocket;
    data['mb_mb_list'] = this.mbMbList;
    data['mb_chipset'] = this.mbChipset;
    data['mb_mem_slot'] = this.mbMemSlot;
    data['mb_mem_type'] = this.mbMemType;
    data['mb_max_capa'] = this.mbMaxCapa;
    data['mb_mb_peak'] = this.mbMbPeak;
    data['mb_vga_on'] = this.mbVgaOn;
    data['mb_audio_chip'] = this.mbAudioChip;
    data['mb_audio_chan'] = this.mbAudioChan;
    data['mb_sata2'] = this.mbSata2;
    data['mb_sata3'] = this.mbSata3;
    data['mb_m2'] = this.mbM2;
    data['mb_m2type'] = this.mbM2type;
    data['mb_msata'] = this.mbMsata;
    data['mb_raid'] = this.mbRaid;
    data['mb_usb2'] = this.mbUsb2;
    data['mb_usb3'] = this.mbUsb3;
    data['mb_usb3a'] = this.mbUsb3a;
    data['mb_usb3c'] = this.mbUsb3c;
    data['mb_serial'] = this.mbSerial;
    data['parallel'] = this.parallel;
    data['mb_dsub'] = this.mbDsub;
    data['mb_dvi'] = this.mbDvi;
    data['mb_hdmi'] = this.mbHdmi;
    data['mb_minihdmi'] = this.mbMinihdmi;
    data['mb_displayport'] = this.mbDisplayport;
    data['mb_minidisplayport'] = this.mbMinidisplayport;
    data['mb_audio_rear'] = this.mbAudioRear;
    data['mb_ps2'] = this.mbPs2;
    data['mb_opt_port'] = this.mbOptPort;
    data['mb_sli'] = this.mbSli;
    data['mb_cf'] = this.mbCf;
    data['mb_power_phrase'] = this.mbPowerPhrase;
    data['mb_pci_no'] = this.mbPciNo;
    data['mb_pcie_no'] = this.mbPcieNo;
    data['mb_pci_detail'] = this.mbPciDetail;
    data['mb_lan'] = this.mbLan;
    data['mb_lan_speed'] = this.mbLanSpeed;
    data['mb_factor'] = this.mbFactor;
    data['mb_pw_pin'] = this.mbPwPin;
    data['mb_dimension'] = this.mbDimension;
    data['mb_feature'] = this.mbFeature;
    data['mb_waranty'] = this.mbWaranty;
    data['mb_score'] = this.mbScore;
    data['mb_price_adv'] = this.mbPriceAdv;
    data['mb_price_ban'] = this.mbPriceBan;
    data['mb_price_jib'] = this.mbPriceJib;
    data['mb_price_tk'] = this.mbPriceTk;
    data['mb_price_jedi'] = this.mbPriceJedi;
    data['mb_price_commore'] = this.mbPriceCommore;
    data['mb_price_hwh'] = this.mbPriceHwh;
    data['mb_price_busitek'] = this.mbPriceBusitek;
    data['mb_price_etc'] = this.mbPriceEtc;
    data['price_mark'] = this.priceMark;
    data['mb_picture'] = this.mbPicture;
    data['adv_id'] = this.advId;
    data['soldout'] = this.soldout;
    data['tk_id'] = this.tkId;
    data['jedi_id'] = this.jediId;
    data['when'] = this.when;
    data['tmp_close'] = this.tmpClose;
    data['timestamp_tmp_close'] = this.timestampTmpClose;
    data['commore_id'] = this.commoreId;
    data['jib_id'] = this.jibId;
    data['banana_id'] = this.bananaId;
    data['is_highlight'] = this.isHighlight;
    data['mb_price_topvalue'] = this.mbPriceTopvalue;
    data['topvalue_id'] = this.topvalueId;
    data['lowest_price'] = this.lowestPrice;
    data['adv_path'] = this.advPath;
    return data;
  }
}
