class ListBrandResponse {
  List<BrandResponse>? listBrandResponse;

  ListBrandResponse({this.listBrandResponse});

  ListBrandResponse.fromJson(json) {
    if (json != null) {
      listBrandResponse = <BrandResponse>[];
      json.forEach((v) {
        if (v['Logo'] != false && v['Logo'] != null) {
          listBrandResponse!.add(BrandResponse.fromJson(v));
        }
      });
    }
  }
}

class BrandResponse {
  Data? data;
  String? logo;
  List<int>? category;

  BrandResponse({this.data, this.logo, this.category});

  BrandResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    logo = json['Logo'];
    category = json['Category'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['Logo'] = logo;
    data['Category'] = category;
    return data;
  }
}

class Data {
  dynamic termId;
  dynamic name;
  dynamic slug;
  dynamic termGroup;

  Data({this.termId, this.name, this.slug, this.termGroup});

  Data.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_id'] = termId;
    data['name'] = name;
    data['slug'] = slug;
    data['term_group'] = termGroup;
    return data;
  }
}
