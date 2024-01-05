class PostDetailResponse {
  int? id;
  String? date;
  String? dateGmt;
  Guid? guid;
  String? modified;
  String? modifiedGmt;
  String? slug;
  String? status;
  String? type;
  String? link;
  Guid? title;
  Content? content;
  Content? excerpt;
  int? author;
  int? featuredMedia;
  String? commentStatus;
  String? pingStatus;
  bool? sticky;
  String? template;
  String? format;
  List<int>? categories;
  Embedded? eEmbedded;

  PostDetailResponse({
    this.id,
    this.date,
    this.dateGmt,
    this.guid,
    this.modified,
    this.modifiedGmt,
    this.slug,
    this.status,
    this.type,
    this.link,
    this.title,
    this.content,
    this.excerpt,
    this.author,
    this.featuredMedia,
    this.commentStatus,
    this.pingStatus,
    this.sticky,
    this.template,
    this.format,
    this.categories,
    this.eEmbedded,
  });

  PostDetailResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateGmt = json['date_gmt'];
    guid = json['guid'] != null ? Guid.fromJson(json['guid']) : null;
    modified = json['modified'];
    modifiedGmt = json['modified_gmt'];
    slug = json['slug'];
    status = json['status'];
    type = json['type'];
    link = json['link'];
    title = json['title'] != null ? Guid.fromJson(json['title']) : null;
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    excerpt =
        json['excerpt'] != null ? Content.fromJson(json['excerpt']) : null;
    author = json['author'];
    featuredMedia = json['featured_media'];
    commentStatus = json['comment_status'];
    pingStatus = json['ping_status'];
    sticky = json['sticky'];
    template = json['template'];
    format = json['format'];
    categories = json['categories'].cast<int>();
    eEmbedded =
        json['_embedded'] != null ? Embedded.fromJson(json['_embedded']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['date_gmt'] = dateGmt;
    if (guid != null) {
      data['guid'] = guid!.toJson();
    }
    data['modified'] = modified;
    data['modified_gmt'] = modifiedGmt;
    data['slug'] = slug;
    data['status'] = status;
    data['type'] = type;
    data['link'] = link;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (content != null) {
      data['content'] = content!.toJson();
    }
    if (excerpt != null) {
      data['excerpt'] = excerpt!.toJson();
    }
    data['author'] = author;
    data['featured_media'] = featuredMedia;
    data['comment_status'] = commentStatus;
    data['ping_status'] = pingStatus;
    data['sticky'] = sticky;
    data['template'] = template;
    data['format'] = format;
    data['categories'] = categories;
    if (eEmbedded != null) {
      data['_embedded'] = eEmbedded!.toJson();
    }
    return data;
  }
}

class Guid {
  String? rendered;

  Guid({this.rendered});

  Guid.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rendered'] = rendered;
    return data;
  }
}

class Content {
  String? rendered;
  bool? protected;

  Content({this.rendered, this.protected});

  Content.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
    protected = json['protected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rendered'] = rendered;
    data['protected'] = protected;
    return data;
  }
}

class Embedded {
  List<WpFeaturedmedia>? wpFeaturedmedia;

  Embedded({this.wpFeaturedmedia});

  Embedded.fromJson(Map<String, dynamic> json) {
    if (json['wp:featuredmedia'] != null) {
      wpFeaturedmedia = <WpFeaturedmedia>[];
      json['wp:featuredmedia'].forEach((v) {
        wpFeaturedmedia!.add(WpFeaturedmedia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wpFeaturedmedia != null) {
      data['wp:featuredmedia'] =
          wpFeaturedmedia!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WpFeaturedmedia {
  int? id;
  String? date;
  String? slug;
  String? type;
  String? link;
  Guid? title;
  int? author;
  Guid? caption;
  String? altText;
  String? mediaType;
  String? mimeType;
  MediaDetails? mediaDetails;
  String? sourceUrl;
  Links? lLinks;

  WpFeaturedmedia({
    this.id,
    this.date,
    this.slug,
    this.type,
    this.link,
    this.title,
    this.author,
    this.caption,
    this.altText,
    this.mediaType,
    this.mimeType,
    this.mediaDetails,
    this.sourceUrl,
    this.lLinks,
  });

  WpFeaturedmedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    slug = json['slug'];
    type = json['type'];
    link = json['link'];
    title = json['title'] != null ? Guid.fromJson(json['title']) : null;
    author = json['author'];
    caption = json['caption'] != null ? Guid.fromJson(json['caption']) : null;
    altText = json['alt_text'];
    mediaType = json['media_type'];
    mimeType = json['mime_type'];
    mediaDetails = json['media_details'] != null
        ? MediaDetails.fromJson(json['media_details'])
        : null;
    sourceUrl = json['source_url'];
    lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['slug'] = slug;
    data['type'] = type;
    data['link'] = link;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['author'] = author;
    if (caption != null) {
      data['caption'] = caption!.toJson();
    }
    data['alt_text'] = altText;
    data['media_type'] = mediaType;
    data['mime_type'] = mimeType;
    if (mediaDetails != null) {
      data['media_details'] = mediaDetails!.toJson();
    }
    data['source_url'] = sourceUrl;
    if (lLinks != null) {
      data['_links'] = lLinks!.toJson();
    }
    return data;
  }
}

class MediaDetails {
  int? width;
  int? height;
  String? file;
  int? filesize;
  Sizes? sizes;
  ImageMeta? imageMeta;

  MediaDetails({
    this.width,
    this.height,
    this.file,
    this.filesize,
    this.sizes,
    this.imageMeta,
  });

  MediaDetails.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    file = json['file'];
    filesize = json['filesize'];
    sizes = json['sizes'] != null ? Sizes.fromJson(json['sizes']) : null;
    imageMeta = json['image_meta'] != null
        ? ImageMeta.fromJson(json['image_meta'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    data['file'] = file;
    data['filesize'] = filesize;
    if (sizes != null) {
      data['sizes'] = sizes!.toJson();
    }
    if (imageMeta != null) {
      data['image_meta'] = imageMeta!.toJson();
    }
    return data;
  }
}

class Sizes {
  Medium? medium;
  Medium? thumbnail;
  Medium? mediumLarge;
  Medium? yithWoocompareImage;
  Medium? yithWcbrLogoSize;
  WoocommerceThumbnail? woocommerceThumbnail;
  Medium? woocommerceSingle;
  Medium? woocommerceGalleryThumbnail;
  Medium? dgwtWcasProductSuggestion;
  Full? full;

  Sizes({
    this.medium,
    this.thumbnail,
    this.mediumLarge,
    this.yithWoocompareImage,
    this.yithWcbrLogoSize,
    this.woocommerceThumbnail,
    this.woocommerceSingle,
    this.woocommerceGalleryThumbnail,
    this.dgwtWcasProductSuggestion,
    this.full,
  });

  Sizes.fromJson(Map<String, dynamic> json) {
    medium = json['medium'] != null ? Medium.fromJson(json['medium']) : null;
    thumbnail =
        json['thumbnail'] != null ? Medium.fromJson(json['thumbnail']) : null;
    mediumLarge = json['medium_large'] != null
        ? Medium.fromJson(json['medium_large'])
        : null;
    yithWoocompareImage = json['yith-woocompare-image'] != null
        ? Medium.fromJson(json['yith-woocompare-image'])
        : null;
    yithWcbrLogoSize = json['yith_wcbr_logo_size'] != null
        ? Medium.fromJson(json['yith_wcbr_logo_size'])
        : null;
    woocommerceThumbnail = json['woocommerce_thumbnail'] != null
        ? WoocommerceThumbnail.fromJson(json['woocommerce_thumbnail'])
        : null;
    woocommerceSingle = json['woocommerce_single'] != null
        ? Medium.fromJson(json['woocommerce_single'])
        : null;
    woocommerceGalleryThumbnail = json['woocommerce_gallery_thumbnail'] != null
        ? Medium.fromJson(json['woocommerce_gallery_thumbnail'])
        : null;
    dgwtWcasProductSuggestion = json['dgwt-wcas-product-suggestion'] != null
        ? Medium.fromJson(json['dgwt-wcas-product-suggestion'])
        : null;
    full = json['full'] != null ? Full.fromJson(json['full']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medium != null) {
      data['medium'] = medium!.toJson();
    }
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail!.toJson();
    }
    if (mediumLarge != null) {
      data['medium_large'] = mediumLarge!.toJson();
    }
    if (yithWoocompareImage != null) {
      data['yith-woocompare-image'] = yithWoocompareImage!.toJson();
    }
    if (yithWcbrLogoSize != null) {
      data['yith_wcbr_logo_size'] = yithWcbrLogoSize!.toJson();
    }
    if (woocommerceThumbnail != null) {
      data['woocommerce_thumbnail'] = woocommerceThumbnail!.toJson();
    }
    if (woocommerceSingle != null) {
      data['woocommerce_single'] = woocommerceSingle!.toJson();
    }
    if (woocommerceGalleryThumbnail != null) {
      data['woocommerce_gallery_thumbnail'] =
          woocommerceGalleryThumbnail!.toJson();
    }
    if (dgwtWcasProductSuggestion != null) {
      data['dgwt-wcas-product-suggestion'] =
          dgwtWcasProductSuggestion!.toJson();
    }
    if (full != null) {
      data['full'] = full!.toJson();
    }
    return data;
  }
}

class Medium {
  String? file;
  int? width;
  int? height;
  int? filesize;
  String? mimeType;
  String? sourceUrl;

  Medium({
    this.file,
    this.width,
    this.height,
    this.filesize,
    this.mimeType,
    this.sourceUrl,
  });

  Medium.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    width = json['width'];
    height = json['height'];
    filesize = json['filesize'];
    mimeType = json['mime_type'];
    sourceUrl = json['source_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    data['width'] = width;
    data['height'] = height;
    data['filesize'] = filesize;
    data['mime_type'] = mimeType;
    data['source_url'] = sourceUrl;
    return data;
  }
}

class WoocommerceThumbnail {
  String? file;
  int? width;
  int? height;
  int? filesize;
  bool? uncropped;
  String? mimeType;
  String? sourceUrl;

  WoocommerceThumbnail({
    this.file,
    this.width,
    this.height,
    this.filesize,
    this.uncropped,
    this.mimeType,
    this.sourceUrl,
  });

  WoocommerceThumbnail.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    width = json['width'];
    height = json['height'];
    filesize = json['filesize'];
    uncropped = json['uncropped'];
    mimeType = json['mime_type'];
    sourceUrl = json['source_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    data['width'] = width;
    data['height'] = height;
    data['filesize'] = filesize;
    data['uncropped'] = uncropped;
    data['mime_type'] = mimeType;
    data['source_url'] = sourceUrl;
    return data;
  }
}

class Full {
  String? file;
  int? width;
  int? height;
  String? mimeType;
  String? sourceUrl;

  Full({this.file, this.width, this.height, this.mimeType, this.sourceUrl});

  Full.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    width = json['width'];
    height = json['height'];
    mimeType = json['mime_type'];
    sourceUrl = json['source_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    data['width'] = width;
    data['height'] = height;
    data['mime_type'] = mimeType;
    data['source_url'] = sourceUrl;
    return data;
  }
}

class ImageMeta {
  String? aperture;
  String? credit;
  String? camera;
  String? caption;
  String? createdTimestamp;
  String? copyright;
  String? focalLength;
  String? iso;
  String? shutterSpeed;
  String? title;
  String? orientation;

  ImageMeta({
    this.aperture,
    this.credit,
    this.camera,
    this.caption,
    this.createdTimestamp,
    this.copyright,
    this.focalLength,
    this.iso,
    this.shutterSpeed,
    this.title,
    this.orientation,
  });

  ImageMeta.fromJson(Map<String, dynamic> json) {
    aperture = json['aperture'];
    credit = json['credit'];
    camera = json['camera'];
    caption = json['caption'];
    createdTimestamp = json['created_timestamp'];
    copyright = json['copyright'];
    focalLength = json['focal_length'];
    iso = json['iso'];
    shutterSpeed = json['shutter_speed'];
    title = json['title'];
    orientation = json['orientation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aperture'] = aperture;
    data['credit'] = credit;
    data['camera'] = camera;
    data['caption'] = caption;
    data['created_timestamp'] = createdTimestamp;
    data['copyright'] = copyright;
    data['focal_length'] = focalLength;
    data['iso'] = iso;
    data['shutter_speed'] = shutterSpeed;
    data['title'] = title;
    data['orientation'] = orientation;
    return data;
  }
}

class Links {
  List<Self>? self;
  List<Author>? author;

  Links({this.self, this.author});

  Links.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <Self>[];
      json['self'].forEach((v) {
        self!.add(Self.fromJson(v));
      });
    }
    if (json['author'] != null) {
      author = <Author>[];
      json['author'].forEach((v) {
        author!.add(Author.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (self != null) {
      data['self'] = self!.map((v) => v.toJson()).toList();
    }
    if (author != null) {
      data['author'] = author!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}

class Author {
  bool? embeddable;
  String? href;

  Author({this.embeddable, this.href});

  Author.fromJson(Map<String, dynamic> json) {
    embeddable = json['embeddable'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['embeddable'] = embeddable;
    data['href'] = href;
    return data;
  }
}
