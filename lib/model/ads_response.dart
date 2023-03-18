class ListAdsResponse {
  List<AdsResponse>? listAdsResponse ;
  ListAdsResponse({this.listAdsResponse});

  ListAdsResponse.fromJson(json) {
    if (json != null) {
      listAdsResponse = <AdsResponse>[];
      json.forEach((v) {
        listAdsResponse!.add(AdsResponse.fromJson(v));
      });
    }
  }
}


class AdsResponse {
  List<Brand>? brand;
  String? url;
  String? image;

  AdsResponse({this.brand, this.url, this.image});

  AdsResponse.fromJson(Map<String, dynamic> json) {
    if (json['brand'] != null) {
      brand = <Brand>[];
      json['brand'].forEach((v) {
        brand!.add(new Brand.fromJson(v));
      });
    }
    url = json['url'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.brand != null) {
      data['brand'] = this.brand!.map((v) => v.toJson()).toList();
    }
    data['url'] = this.url;
    data['image'] = this.image;
    return data;
  }
}

class Brand {
  int? termId;
  String? name;
  String? slug;
  int? termGroup;
  int? termTaxonomyId;
  String? taxonomy;
  String? description;
  int? parent;
  int? count;
  String? filter;
  List<String>? brandImage;
  bool? brandBanner;

  Brand(
      {this.termId,
        this.name,
        this.slug,
        this.termGroup,
        this.termTaxonomyId,
        this.taxonomy,
        this.description,
        this.parent,
        this.count,
        this.filter,
        this.brandImage,
        this.brandBanner});

  Brand.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
    termTaxonomyId = json['term_taxonomy_id'];
    taxonomy = json['taxonomy'];
    description = json['description'];
    parent = json['parent'];
    count = json['count'];
    filter = json['filter'];
    brandImage = json['brand_image'].cast<String>();
    brandBanner = json['brand_banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['term_id'] = this.termId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['term_group'] = this.termGroup;
    data['term_taxonomy_id'] = this.termTaxonomyId;
    data['taxonomy'] = this.taxonomy;
    data['description'] = this.description;
    data['parent'] = this.parent;
    data['count'] = this.count;
    data['filter'] = this.filter;
    data['brand_image'] = this.brandImage;
    data['brand_banner'] = this.brandBanner;
    return data;
  }
}
