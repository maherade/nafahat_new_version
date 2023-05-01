class ListRelatedProductModel {
  List<RelatedProductModel>? listRelatedProductModel ;

  ListRelatedProductModel({this.listRelatedProductModel});
  ListRelatedProductModel.fromJson(json) {
    if (json != null) {
      listRelatedProductModel = <RelatedProductModel>[];
      json.forEach((v) {
        listRelatedProductModel!.add(RelatedProductModel.fromJson(v));
      });
    }
  }
}

class RelatedProductModel {
  int? id;
  dynamic name;
  dynamic dateCreated;
  dynamic dateCreatedGmt;
  bool? featured;
  dynamic description;
  dynamic shortDescription;
  dynamic sku;
  dynamic price;
  dynamic regularPrice;
  dynamic salePrice;
  bool? onSale;
  bool? purchasable;
  int? totalSales;
  bool? manageStock;
  int? stockQuantity;
  dynamic backorders;
  bool? backordersAllowed;
  bool? soldIndividually;
  bool? shippingRequired;
  bool? shippingTaxable;
  int? shippingClassId;
  bool? reviewsAllowed;
  dynamic averageRating;
  int? ratingCount;
  int? parentId;
  dynamic purchaseNote;
  List<Categories>? categories;
  List<Images>? images;
  int? menuOrder;
  List<int>? relatedIds;
  List<MetaData>? metaData;
  dynamic stockStatus;
  bool? hasOptions;
  YoastHeadJson? yoastHeadJson;

  RelatedProductModel(
      {this.id,
        this.name,
        this.dateCreated,
        this.dateCreatedGmt,
        this.featured,
        this.description,
        this.shortDescription,
        this.sku,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.onSale,
        this.purchasable,
        this.totalSales,
        this.manageStock,
        this.stockQuantity,
        this.backorders,
        this.backordersAllowed,
        this.soldIndividually,
        this.shippingRequired,
        this.shippingTaxable,
        this.shippingClassId,
        this.reviewsAllowed,
        this.averageRating,
        this.ratingCount,
        this.parentId,
        this.purchaseNote,
        this.categories,
        this.images,
        this.menuOrder,
        this.relatedIds,
        this.metaData,
        this.stockStatus,
        this.hasOptions,
        this.yoastHeadJson});

  RelatedProductModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    featured = json['featured'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    onSale = json['on_sale'];
    purchasable = json['purchasable'];
    totalSales = json['total_sales'];
    manageStock = json['manage_stock'];
    stockQuantity = json['stock_quantity'];
    backorders = json['backorders'];
    backordersAllowed = json['backorders_allowed'];
    soldIndividually = json['sold_individually'];
    shippingRequired = json['shipping_required'];
    shippingTaxable = json['shipping_taxable'];
    shippingClassId = json['shipping_class_id'];
    reviewsAllowed = json['reviews_allowed'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    parentId = json['parent_id'];
    purchaseNote = json['purchase_note'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    menuOrder = json['menu_order'];
    relatedIds = json['related_ids'].cast<int>();
    if (json['meta_data'] != null) {
      metaData = <MetaData>[];
      json['meta_data'].forEach((v) {
        metaData!.add(new MetaData.fromJson(v));
      });
    }
    stockStatus = json['stock_status'];
    hasOptions = json['has_options'];
    yoastHeadJson = json['yoast_head_json'] != null
        ? new YoastHeadJson.fromJson(json['yoast_head_json'])
        : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['featured'] = this.featured;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['on_sale'] = this.onSale;
    data['purchasable'] = this.purchasable;
    data['total_sales'] = this.totalSales;
    data['manage_stock'] = this.manageStock;
    data['stock_quantity'] = this.stockQuantity;
    data['backorders'] = this.backorders;
    data['backorders_allowed'] = this.backordersAllowed;
    data['sold_individually'] = this.soldIndividually;
    data['shipping_required'] = this.shippingRequired;
    data['shipping_taxable'] = this.shippingTaxable;
    data['shipping_class_id'] = this.shippingClassId;
    data['reviews_allowed'] = this.reviewsAllowed;
    data['average_rating'] = this.averageRating;
    data['rating_count'] = this.ratingCount;
    data['parent_id'] = this.parentId;
    data['purchase_note'] = this.purchaseNote;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['menu_order'] = this.menuOrder;
    data['related_ids'] = this.relatedIds;
    if (this.metaData != null) {
      data['meta_data'] = this.metaData!.map((v) => v.toJson()).toList();
    }
    data['stock_status'] = this.stockStatus;
    data['has_options'] = this.hasOptions;
    if (this.yoastHeadJson != null) {
      data['yoast_head_json'] = this.yoastHeadJson!.toJson();
    }
    return data;
  }
}

class Categories {
  int? id;
  dynamic name;
  dynamic slug;

  Categories({this.id, this.name, this.slug});

  Categories.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class Images {
  int? id;
  dynamic dateCreated;
  dynamic dateCreatedGmt;
  dynamic dateModified;
  dynamic dateModifiedGmt;
  dynamic src;
  dynamic name;
  dynamic alt;

  Images(
      {this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.src,
        this.name,
        this.alt});

  Images.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['src'] = this.src;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}

class MetaData {
  int? id;
  dynamic key;
  dynamic value;

  MetaData({this.id, this.key, this.value});

  MetaData.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class YoastHeadJson {
  dynamic title;
  dynamic description;
  dynamic ogTitle;
  dynamic ogDescription;
  dynamic ogUrl;
  dynamic ogSiteName;
  dynamic articleModifiedTime;
  List<OgImage>? ogImage;

  YoastHeadJson(
      {this.title,
        this.description,
        this.ogTitle,
        this.ogDescription,
        this.ogUrl,
        this.ogSiteName,
        this.articleModifiedTime,
        this.ogImage});

  YoastHeadJson.fromJson(Map<dynamic, dynamic> json) {
    title = json['title'];
    description = json['description'];
    ogTitle = json['og_title'];
    ogDescription = json['og_description'];
    ogUrl = json['og_url'];
    ogSiteName = json['og_site_name'];
    articleModifiedTime = json['article_modified_time'];
    if (json['og_image'] != null) {
      ogImage = <OgImage>[];
      json['og_image'].forEach((v) {
        ogImage!.add(new OgImage.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['og_title'] = this.ogTitle;
    data['og_description'] = this.ogDescription;
    data['og_url'] = this.ogUrl;
    data['og_site_name'] = this.ogSiteName;
    data['article_modified_time'] = this.articleModifiedTime;
    if (this.ogImage != null) {
      data['og_image'] = this.ogImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OgImage {
  int? width;
  int? height;
  dynamic url;
  dynamic type;

  OgImage({this.width, this.height, this.url, this.type});

  OgImage.fromJson(Map<dynamic, dynamic> json) {
    width = json['width'];
    height = json['height'];
    url = json['url'];
    type = json['type'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}
