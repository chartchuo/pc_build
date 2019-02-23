class VgaFilter {
  Set<String> allBrands;
  Set<String> selectedBrands;
}

class Vga {
  String cat;
  int id;
  int view;
  int currentweek;
  int lastweek;
  int last2week;
  int lastupdate;
  int vgaId;
  String vgaBrand;
  String vgaModel;
  String vgaCodeName;
  String vgaBusType;
  String vgaChipset;
  String vgaSeries;
  String vgaTech;
  String vgaClock;
  dynamic vgaShader;
  dynamic vgaShaderUnit;
  dynamic vgaMemSpeed;
  String vgaMemSize;
  String vgaMemType;
  String vgaBit;
  String vgaMaxReso;
  dynamic vgaDirectx;
  String vgaCfSli;
  String vga3d;
  dynamic vgaCooling;
  int vgaDsub;
  int vgaDvi;
  int vgaHdmi;
  int vgaMhdmi;
  int vgaDisplayport;
  int vgaMdisplayport;
  String vgaOptionPort;
  String vgaPower;
  String vgaPsuRequire;
  dynamic vgaFeature;
  int vgaWaranty;
  int vgaScore;
  int score3D11;
  int vgaPriceAdv;
  int vgaPriceBan;
  int vgaPriceJib;
  int vgaPriceTk;
  int vgaPriceJedi;
  int vgaPriceCommore;
  int vgaPriceHwh;
  int vgaPriceBusitek;
  int vgaPriceEtc;
  String vgaPicture;
  dynamic advId;
  dynamic tkId;
  dynamic jediId;
  int soldout;
  String when;
  int tmpClose;
  String timestampTmpClose;
  dynamic commoreId;
  dynamic jibId;
  int bananaId;
  int isHighlight;
  dynamic vgaPriceTopvalue;
  dynamic topvalueId;
  int lowestPrice;
  String vgaMemModel;

  Vga(
      {this.cat,
      this.id,
      this.view,
      this.currentweek,
      this.lastweek,
      this.last2week,
      this.lastupdate,
      this.vgaId,
      this.vgaBrand,
      this.vgaModel,
      this.vgaCodeName,
      this.vgaBusType,
      this.vgaChipset,
      this.vgaSeries,
      this.vgaTech,
      this.vgaClock,
      this.vgaShader,
      this.vgaShaderUnit,
      this.vgaMemSpeed,
      this.vgaMemSize,
      this.vgaMemType,
      this.vgaBit,
      this.vgaMaxReso,
      this.vgaDirectx,
      this.vgaCfSli,
      this.vga3d,
      this.vgaCooling,
      this.vgaDsub,
      this.vgaDvi,
      this.vgaHdmi,
      this.vgaMhdmi,
      this.vgaDisplayport,
      this.vgaMdisplayport,
      this.vgaOptionPort,
      this.vgaPower,
      this.vgaPsuRequire,
      this.vgaFeature,
      this.vgaWaranty,
      this.vgaScore,
      this.score3D11,
      this.vgaPriceAdv,
      this.vgaPriceBan,
      this.vgaPriceJib,
      this.vgaPriceTk,
      this.vgaPriceJedi,
      this.vgaPriceCommore,
      this.vgaPriceHwh,
      this.vgaPriceBusitek,
      this.vgaPriceEtc,
      this.vgaPicture,
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
      this.vgaPriceTopvalue,
      this.topvalueId,
      this.lowestPrice,
      this.vgaMemModel});

  Vga.fromJson(Map<String, dynamic> json) {
    cat = json['cat'];
    id = json['id'];
    view = json['view'];
    currentweek = json['currentweek'];
    lastweek = json['lastweek'];
    last2week = json['last2week'];
    lastupdate = json['lastupdate'];
    vgaId = json['vga_id'];
    vgaBrand = json['vga_brand'];
    vgaModel = json['vga_model'];
    vgaCodeName = json['vga_code_name'];
    vgaBusType = json['vga_bus_type'];
    vgaChipset = json['vga_chipset'];
    vgaSeries = json['vga_series'];
    vgaTech = json['vga_tech'];
    vgaClock = json['vga_clock'];
    vgaShader = json['vga_shader'];
    vgaShaderUnit = json['vga_shader_unit'];
    vgaMemSpeed = json['vga_mem_speed'];
    vgaMemSize = json['vga_mem_size'];
    vgaMemType = json['vga_mem_type'];
    vgaBit = json['vga_bit'];
    vgaMaxReso = json['vga_max_reso'];
    vgaDirectx = json['vga_directx'];
    vgaCfSli = json['vga_cf_sli'];
    vga3d = json['vga_3d'];
    vgaCooling = json['vga_cooling'];
    vgaDsub = json['vga_dsub'];
    vgaDvi = json['vga_dvi'];
    vgaHdmi = json['vga_hdmi'];
    vgaMhdmi = json['vga_mhdmi'];
    vgaDisplayport = json['vga_displayport'];
    vgaMdisplayport = json['vga_mdisplayport'];
    vgaOptionPort = json['vga_option_port'];
    vgaPower = json['vga_power'];
    vgaPsuRequire = json['vga_psu_require'];
    vgaFeature = json['vga_feature'];
    vgaWaranty = json['vga_waranty'];
    vgaScore = json['vga_score'];
    score3D11 = json['score3D11'];
    vgaPriceAdv = json['vga_price_adv'];
    vgaPriceBan = json['vga_price_ban'];
    vgaPriceJib = json['vga_price_jib'];
    vgaPriceTk = json['vga_price_tk'];
    vgaPriceJedi = json['vga_price_jedi'];
    vgaPriceCommore = json['vga_price_commore'];
    vgaPriceHwh = json['vga_price_hwh'];
    vgaPriceBusitek = json['vga_price_busitek'];
    vgaPriceEtc = json['vga_price_etc'];
    vgaPicture = json['vga_picture'];
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
    vgaPriceTopvalue = json['vga_price_topvalue'];
    topvalueId = json['topvalue_id'];
    lowestPrice = json['lowest_price'];
    vgaMemModel = json['vga_mem_model'];
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
    data['vga_id'] = this.vgaId;
    data['vga_brand'] = this.vgaBrand;
    data['vga_model'] = this.vgaModel;
    data['vga_code_name'] = this.vgaCodeName;
    data['vga_bus_type'] = this.vgaBusType;
    data['vga_chipset'] = this.vgaChipset;
    data['vga_series'] = this.vgaSeries;
    data['vga_tech'] = this.vgaTech;
    data['vga_clock'] = this.vgaClock;
    data['vga_shader'] = this.vgaShader;
    data['vga_shader_unit'] = this.vgaShaderUnit;
    data['vga_mem_speed'] = this.vgaMemSpeed;
    data['vga_mem_size'] = this.vgaMemSize;
    data['vga_mem_type'] = this.vgaMemType;
    data['vga_bit'] = this.vgaBit;
    data['vga_max_reso'] = this.vgaMaxReso;
    data['vga_directx'] = this.vgaDirectx;
    data['vga_cf_sli'] = this.vgaCfSli;
    data['vga_3d'] = this.vga3d;
    data['vga_cooling'] = this.vgaCooling;
    data['vga_dsub'] = this.vgaDsub;
    data['vga_dvi'] = this.vgaDvi;
    data['vga_hdmi'] = this.vgaHdmi;
    data['vga_mhdmi'] = this.vgaMhdmi;
    data['vga_displayport'] = this.vgaDisplayport;
    data['vga_mdisplayport'] = this.vgaMdisplayport;
    data['vga_option_port'] = this.vgaOptionPort;
    data['vga_power'] = this.vgaPower;
    data['vga_psu_require'] = this.vgaPsuRequire;
    data['vga_feature'] = this.vgaFeature;
    data['vga_waranty'] = this.vgaWaranty;
    data['vga_score'] = this.vgaScore;
    data['score3D11'] = this.score3D11;
    data['vga_price_adv'] = this.vgaPriceAdv;
    data['vga_price_ban'] = this.vgaPriceBan;
    data['vga_price_jib'] = this.vgaPriceJib;
    data['vga_price_tk'] = this.vgaPriceTk;
    data['vga_price_jedi'] = this.vgaPriceJedi;
    data['vga_price_commore'] = this.vgaPriceCommore;
    data['vga_price_hwh'] = this.vgaPriceHwh;
    data['vga_price_busitek'] = this.vgaPriceBusitek;
    data['vga_price_etc'] = this.vgaPriceEtc;
    data['vga_picture'] = this.vgaPicture;
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
    data['vga_price_topvalue'] = this.vgaPriceTopvalue;
    data['topvalue_id'] = this.topvalueId;
    data['lowest_price'] = this.lowestPrice;
    data['vga_mem_model'] = this.vgaMemModel;
    return data;
  }
}
