class ListProductByCategoryResponse {
  List<ProductByCategoryResponse>? listProductByCategoryResponse ;
  String? totalPage ;

  ListProductByCategoryResponse({this.listProductByCategoryResponse,this.totalPage});
  ListProductByCategoryResponse.fromJson(json) {
    if (json != null) {
      listProductByCategoryResponse = <ProductByCategoryResponse>[];
      json.forEach((v) {
        listProductByCategoryResponse!.add(ProductByCategoryResponse.fromJson(v));
      });
    }

  }
}
class ProductByCategoryResponse {
  int? id;
  String? name;
  String? description;
  String? price;
  String? regularPrice;
  String? salePrice;
  List<Images>? images;
  List<Brands>? brands;
  String? yoastHead;
  String? averageRating;
  int? ratingCount;

  ProductByCategoryResponse(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.images,
        this.brands,
        this.yoastHead,
        this.averageRating,
        this.ratingCount
      });

  ProductByCategoryResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(new Brands.fromJson(v));
      });
    }
    yoastHead = json['yoast_head'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    data['average_rating'] = this.averageRating;
    data['rating_count'] = this.ratingCount;
    return data;
  }
}

class Images {
  int? id;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? alt;

  Images(
      {this.id,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.src,
        this.alt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['src'] = this.src;
    data['alt'] = this.alt;
    return data;
  }
}

class Brands {
  int? id;
  String? name;
  String? slug;

  Brands({this.id, this.name, this.slug});

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}
