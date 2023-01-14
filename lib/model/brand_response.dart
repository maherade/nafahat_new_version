class ListBrandResponse {
  List<BrandResponse>? listBrandResponse ;

  ListBrandResponse({this.listBrandResponse});
  ListBrandResponse.fromJson(json) {
    if (json != null) {
      listBrandResponse = <BrandResponse>[];
      json.forEach((v) {
        if(v['brand_image'] != false){
          listBrandResponse!.add(BrandResponse.fromJson(v));
        }
      });
    }

  }
}
class BrandResponse {
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
  List<dynamic>? brandImage;
  bool? boolBrandImage;
  bool? brandBanner;

  BrandResponse(
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
        this.boolBrandImage,
        this.brandBanner});

  BrandResponse.fromJson(Map<String, dynamic> json) {
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
    json['brand_image'] is bool ? boolBrandImage = json['brand_image'] : brandImage = json['brand_image']  ;
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
