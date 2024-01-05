class ListFamousBrandResponse {
  List<FamousBrandResponse>? listFamousBrandResponse;

  ListFamousBrandResponse({this.listFamousBrandResponse});

  ListFamousBrandResponse.fromJson(json) {
    if (json != null) {
      listFamousBrandResponse = <FamousBrandResponse>[];
      json.forEach((v) {
        listFamousBrandResponse!.add(FamousBrandResponse.fromJson(v));
      });
    }
  }
}

class FamousBrandResponse {
  List<Brand>? brand;
  String? url;
  String? image;

  FamousBrandResponse({this.brand, this.url, this.image});

  FamousBrandResponse.fromJson(Map<String, dynamic> json) {
    if (json['brand'] != null) {
      brand = <Brand>[];
      json['brand'].forEach((v) {
        brand!.add(Brand.fromJson(v));
      });
    }
    url = json['url'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (brand != null) {
      data['brand'] = brand!.map((v) => v.toJson()).toList();
    }
    data['url'] = url;
    data['image'] = image;
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

  Brand({
    this.termId,
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
    this.brandBanner,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_id'] = termId;
    data['name'] = name;
    data['slug'] = slug;
    data['term_group'] = termGroup;
    data['term_taxonomy_id'] = termTaxonomyId;
    data['taxonomy'] = taxonomy;
    data['description'] = description;
    data['parent'] = parent;
    data['count'] = count;
    data['filter'] = filter;
    data['brand_image'] = brandImage;
    data['brand_banner'] = brandBanner;
    return data;
  }
}
