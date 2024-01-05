import '../services/app_imports.dart';

class ListCareProductResponse {
  List<Data>? data;
  Headers? headers;
  int? status;

  ListCareProductResponse({this.data, this.headers, this.status});

  ListCareProductResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    headers =
        json['headers'] != null ? Headers.fromJson(json['headers']) : null;
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

  Data({
    this.title,
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
    this.relatedAds,
  });

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
        attributes!.add(VariationsAttributes.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['variations'] != null && json['variations'] is List) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(Variations.fromJson(v));
      });
    }
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(Brands.fromJson(v));
      });
    }
    if (json['meta_data'] != null) {
      json['meta_data'].forEach((v) {
        if (v['key'] == '_lpfw_product_custom_points') {
          metaData = v['value'].toString();
          debugPrint('metaData${v['value']}');
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
    this.options,
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

  Variations({
    this.attributes,
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
    this.weightHtml,
  });

  Variations.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null;
    availabilityHtml = json['availability_html'];
    backordersAllowed = json['backorders_allowed'];
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
    dimensionsHtml = json['dimensions_html'];
    displayPrice = json['display_price'];
    displayRegularPrice = json['display_regular_price'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attributes != null) {
      data['attributes'] = attributes!.toJson();
    }
    data['availability_html'] = availabilityHtml;
    data['backorders_allowed'] = backordersAllowed;
    if (dimensions != null) {
      data['dimensions'] = dimensions!.toJson();
    }
    data['dimensions_html'] = dimensionsHtml;
    data['display_price'] = displayPrice;
    data['display_regular_price'] = displayRegularPrice;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['image_id'] = imageId;
    data['is_downloadable'] = isDownloadable;
    data['is_in_stock'] = isInStock;
    data['is_purchasable'] = isPurchasable;
    data['is_sold_individually'] = isSoldIndividually;
    data['is_virtual'] = isVirtual;
    data['max_qty'] = maxQty;
    data['min_qty'] = minQty;
    data['price_html'] = priceHtml;
    data['sku'] = sku;
    data['variation_description'] = variationDescription;
    data['variation_id'] = variationId;
    data['variation_is_active'] = variationIsActive;
    data['variation_is_visible'] = variationIsVisible;
    data['weight'] = weight;
    data['weight_html'] = weightHtml;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attribute_pa_%d8%a7%d9%84%d8%ad%d8%ac%d9%85'] =
        attributePaD8A7D984D8AdD8AcD985;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
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

  Image({
    this.title,
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
    this.srcH,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['caption'] = caption;
    data['url'] = url;
    data['alt'] = alt;
    data['src'] = src;
    data['srcset'] = srcset;
    data['sizes'] = sizes;
    data['full_src'] = fullSrc;
    data['full_src_w'] = fullSrcW;
    data['full_src_h'] = fullSrcH;
    data['gallery_thumbnail_src'] = galleryThumbnailSrc;
    data['gallery_thumbnail_src_w'] = galleryThumbnailSrcW;
    data['gallery_thumbnail_src_h'] = galleryThumbnailSrcH;
    data['thumb_src'] = thumbSrc;
    data['thumb_src_w'] = thumbSrcW;
    data['thumb_src_h'] = thumbSrcH;
    data['src_w'] = srcW;
    data['src_h'] = srcH;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['src'] = src;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['X-WP-Total'] = xWPTotal;
    data['X-WP-TotalPages'] = xWPTotalPages;
    return data;
  }
}
