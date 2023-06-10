class ListGiftPackageProductResponse {
  List<Data>? data;
  Headers? headers;
  int? status;

  ListGiftPackageProductResponse({this.data, this.headers, this.status});

  ListGiftPackageProductResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    headers =
    json['headers'] != null ? new Headers.fromJson(json['headers']) : null;
    status = json['status'];
  }


}

class Data {
  String? title;
  int? id;
  String? price;
  String? regularPrice;
  String? salePrice;
  String? description;
  String? averageRating;
  int? ratingCount;
  List<Images>? images;
  List<Brands>? brands;
  String? metaData;
  List<dynamic>? relatedAds;
  List<Variations>? variations;
  List<VariationsAttributes>? attributes;


  Data(
      {this.title,
        this.id,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.description,
        this.averageRating,
        this.ratingCount,
        this.images,
        this.brands,
        this.metaData,
        this.relatedAds,});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    description = json['description'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    if (json['attributes'] != null) {
      attributes = <VariationsAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new VariationsAttributes.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['variations'] != null && json['variations'] is List) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(new Variations.fromJson(v));
      });
    }
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(new Brands.fromJson(v));
      });
    }
    if (json['meta_data'] != null) {
      json['meta_data'].forEach((v) {
        if(v['key']=='_lpfw_product_custom_points'){
          metaData = v['value'].toString();
          print('metaData'+v['value'].toString());
        }
      });
    }
    if (json['related_ids'] != null) {
      relatedAds = [];
      json['related_ids'].forEach((v) {
        relatedAds!.add(v);
      });
    }
  }


}

class VariationsAttributes {
  int? id;
  String? name;
  int? position;
  bool? visible;
  bool? variation;
  List<String>? options;

  VariationsAttributes({
    this.id,
    this.name,
    this.position,
    this.visible,
    this.variation,
    this.options
  });

  VariationsAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    position = json['position'];
    visible = json['visible'];
    variation = json['variation'];
    options = json['options'].cast<String>();
  }

}

class Variations {
  Attributes? attributes;
  dynamic availabilityHtml;
  bool? backordersAllowed;
  Dimensions? dimensions;
  String? dimensionsHtml;
  dynamic displayPrice;
  dynamic displayRegularPrice;
  Image? image;
  dynamic imageId;
  bool? isDownloadable;
  bool? isInStock;
  bool? isPurchasable;
  String? isSoldIndividually;
  bool? isVirtual;
  String? maxQty;
  dynamic minQty;
  String? priceHtml;
  String? sku;
  String? variationDescription;
  dynamic variationId;
  bool? variationIsActive;
  bool? variationIsVisible;
  String? weight;
  String? weightHtml;

  Variations(
      {this.attributes,
        this.availabilityHtml,
        this.backordersAllowed,
        this.dimensions,
        this.dimensionsHtml,
        this.displayPrice,
        this.displayRegularPrice,
        this.image,
        this.imageId,
        this.isDownloadable,
        this.isInStock,
        this.isPurchasable,
        this.isSoldIndividually,
        this.isVirtual,
        this.maxQty,
        this.minQty,
        this.priceHtml,
        this.sku,
        this.variationDescription,
        this.variationId,
        this.variationIsActive,
        this.variationIsVisible,
        this.weight,
        this.weightHtml});

  Variations.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
    availabilityHtml = json['availability_html'];
    backordersAllowed = json['backorders_allowed'];
    dimensions = json['dimensions'] != null
        ? new Dimensions.fromJson(json['dimensions'])
        : null;
    dimensionsHtml = json['dimensions_html'];
    displayPrice = json['display_price'];
    displayRegularPrice = json['display_regular_price'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    imageId = json['image_id'];
    isDownloadable = json['is_downloadable'];
    isInStock = json['is_in_stock'];
    isPurchasable = json['is_purchasable'];
    isSoldIndividually = json['is_sold_individually'];
    isVirtual = json['is_virtual'];
    maxQty = json['max_qty'];
    minQty = json['min_qty'];
    priceHtml = json['price_html'];
    sku = json['sku'];
    variationDescription = json['variation_description'];
    variationId = json['variation_id'];
    variationIsActive = json['variation_is_active'];
    variationIsVisible = json['variation_is_visible'];
    weight = json['weight'];
    weightHtml = json['weight_html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    data['availability_html'] = this.availabilityHtml;
    data['backorders_allowed'] = this.backordersAllowed;
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions!.toJson();
    }
    data['dimensions_html'] = this.dimensionsHtml;
    data['display_price'] = this.displayPrice;
    data['display_regular_price'] = this.displayRegularPrice;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['image_id'] = this.imageId;
    data['is_downloadable'] = this.isDownloadable;
    data['is_in_stock'] = this.isInStock;
    data['is_purchasable'] = this.isPurchasable;
    data['is_sold_individually'] = this.isSoldIndividually;
    data['is_virtual'] = this.isVirtual;
    data['max_qty'] = this.maxQty;
    data['min_qty'] = this.minQty;
    data['price_html'] = this.priceHtml;
    data['sku'] = this.sku;
    data['variation_description'] = this.variationDescription;
    data['variation_id'] = this.variationId;
    data['variation_is_active'] = this.variationIsActive;
    data['variation_is_visible'] = this.variationIsVisible;
    data['weight'] = this.weight;
    data['weight_html'] = this.weightHtml;
    return data;
  }
}

class Attributes {
  String? attributePaD8A7D984D8AdD8AcD985;

  Attributes({this.attributePaD8A7D984D8AdD8AcD985});

  Attributes.fromJson(Map<String, dynamic> json) {
    attributePaD8A7D984D8AdD8AcD985 =
    json['attribute_pa_%d8%a7%d9%84%d8%ad%d8%ac%d9%85'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_pa_%d8%a7%d9%84%d8%ad%d8%ac%d9%85'] =
        this.attributePaD8A7D984D8AdD8AcD985;
    return data;
  }
}

class Dimensions {
  String? length;
  String? width;
  String? height;

  Dimensions({this.length, this.width, this.height});

  Dimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Image {
  String? title;
  String? caption;
  String? url;
  String? alt;
  String? src;
  bool? srcset;
  String? sizes;
  String? fullSrc;
  int? fullSrcW;
  int? fullSrcH;
  String? galleryThumbnailSrc;
  int? galleryThumbnailSrcW;
  int? galleryThumbnailSrcH;
  String? thumbSrc;
  int? thumbSrcW;
  int? thumbSrcH;
  int? srcW;
  int? srcH;

  Image(
      {this.title,
        this.caption,
        this.url,
        this.alt,
        this.src,
        this.srcset,
        this.sizes,
        this.fullSrc,
        this.fullSrcW,
        this.fullSrcH,
        this.galleryThumbnailSrc,
        this.galleryThumbnailSrcW,
        this.galleryThumbnailSrcH,
        this.thumbSrc,
        this.thumbSrcW,
        this.thumbSrcH,
        this.srcW,
        this.srcH});

  Image.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    caption = json['caption'];
    url = json['url'];
    alt = json['alt'];
    src = json['src'];
    srcset = json['srcset'];
    sizes = json['sizes'];
    fullSrc = json['full_src'];
    fullSrcW = json['full_src_w'];
    fullSrcH = json['full_src_h'];
    galleryThumbnailSrc = json['gallery_thumbnail_src'];
    galleryThumbnailSrcW = json['gallery_thumbnail_src_w'];
    galleryThumbnailSrcH = json['gallery_thumbnail_src_h'];
    thumbSrc = json['thumb_src'];
    thumbSrcW = json['thumb_src_w'];
    thumbSrcH = json['thumb_src_h'];
    srcW = json['src_w'];
    srcH = json['src_h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['caption'] = this.caption;
    data['url'] = this.url;
    data['alt'] = this.alt;
    data['src'] = this.src;
    data['srcset'] = this.srcset;
    data['sizes'] = this.sizes;
    data['full_src'] = this.fullSrc;
    data['full_src_w'] = this.fullSrcW;
    data['full_src_h'] = this.fullSrcH;
    data['gallery_thumbnail_src'] = this.galleryThumbnailSrc;
    data['gallery_thumbnail_src_w'] = this.galleryThumbnailSrcW;
    data['gallery_thumbnail_src_h'] = this.galleryThumbnailSrcH;
    data['thumb_src'] = this.thumbSrc;
    data['thumb_src_w'] = this.thumbSrcW;
    data['thumb_src_h'] = this.thumbSrcH;
    data['src_w'] = this.srcW;
    data['src_h'] = this.srcH;
    return data;
  }
}

class Images {
  int? id;
  String? src;

  Images({this.id, this.src});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['src'] = this.src;
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

class Headers {
  int? xWPTotal;
  int? xWPTotalPages;

  Headers({this.xWPTotal, this.xWPTotalPages});

  Headers.fromJson(Map<String, dynamic> json) {
    xWPTotal = json['X-WP-Total'];
    xWPTotalPages = json['X-WP-TotalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['X-WP-Total'] = this.xWPTotal;
    data['X-WP-TotalPages'] = this.xWPTotalPages;
    return data;
  }
}
