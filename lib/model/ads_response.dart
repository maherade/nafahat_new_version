class AdsResponse {
  String? nafBanner1;
  String? nafBanner2;
  String? nafBanner3;
  String? nafBanner4;
  String? nafBanner5;
  String? nafBanner6;
  String? nafBanner7;
  String? nafBanner8;
  String? nafBanner9;
  String? nafBanner10;

  AdsResponse(
      {this.nafBanner1,
        this.nafBanner2,
        this.nafBanner3,
        this.nafBanner4,
        this.nafBanner5,
        this.nafBanner6,
        this.nafBanner7,
        this.nafBanner8,
        this.nafBanner9,
        this.nafBanner10});

  AdsResponse.fromJson(Map<String, dynamic> json) {
    nafBanner1 = json['naf_banner_1'];
    nafBanner2 = json['naf_banner_2'];
    nafBanner3 = json['naf_banner_3'];
    nafBanner4 = json['naf_banner_4'];
    nafBanner5 = json['naf_banner_5'];
    nafBanner6 = json['naf_banner_6'];
    nafBanner7 = json['naf_banner_7'];
    nafBanner8 = json['naf_banner_8'];
    nafBanner9 = json['naf_banner_9'];
    nafBanner10 = json['naf_banner_1_0'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['naf_banner_1'] = this.nafBanner1;
    data['naf_banner_2'] = this.nafBanner2;
    data['naf_banner_3'] = this.nafBanner3;
    data['naf_banner_4'] = this.nafBanner4;
    data['naf_banner_5'] = this.nafBanner5;
    data['naf_banner_6'] = this.nafBanner6;
    data['naf_banner_7'] = this.nafBanner7;
    data['naf_banner_8'] = this.nafBanner8;
    data['naf_banner_9'] = this.nafBanner9;
    data['naf_banner_1_0'] = this.nafBanner10;
    return data;
  }
}
