class ListAdsResponse {
  List<AdsResponse>? listAdsResponse;

  ListAdsResponse({this.listAdsResponse});

  ListAdsResponse.fromJson(json) {
    if (json != null) {
      listAdsResponse = <AdsResponse>[];
      json.forEach((v) {
        listAdsResponse!.add(AdsResponse.fromJson(v));
      });

      // sort the list based on a specific order of image URLs
      // listAdsResponse!.sort((a, b) {
      //   List<String> imageOrder = [
      //     'https://nafahat.com/wp-content/uploads/sites/2/2023/03/حياكم-عروض-نفحات-بتستناكم-.png',
      //     'https://nafahat.com/wp-content/uploads/sites/2/2023/04/5.png',
      //     'https://nafahat.com/wp-content/uploads/sites/2/2023/04/2_1.png',
      //   ];
      //
      //   int aIndex = imageOrder.indexOf(a.image!);
      //   int bIndex = imageOrder.indexOf(b.image!);
      //
      //   if (aIndex != -1 && bIndex != -1) {
      //     return aIndex.compareTo(bIndex); // sort by image order if both have specified images
      //   } else if (aIndex != -1) {
      //     return -1; // a should come before b
      //   } else if (bIndex != -1) {
      //     return 1; // b should come before a
      //   } else {
      //     return a.image!.compareTo(b.image!); // sort by name for all other items
      //   }
      // });
    }
  }
}

class AdsResponse {
  List<Brand>? brand;
  String? url;
  String? image;

  AdsResponse({this.brand, this.url, this.image});

  AdsResponse.fromJson(Map<String, dynamic> json) {
    if (json['brand'] != null && (json['brand'] as List).isNotEmpty) {
      brand = <Brand>[];
      json['brand'].forEach((v) {
        brand!.add(Brand.fromJson(v));
      });
    } else {
      brand = [Brand()];
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
    brandImage =
        json['brand_image'] is bool ? [] : json['brand_image'].cast<String>();
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
