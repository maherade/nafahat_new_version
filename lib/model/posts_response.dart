class ListPostsResponse {
  List<PostsResponse>? listPostsResponse ;
  String? totalPage ;

  ListPostsResponse({this.listPostsResponse,this.totalPage});
  ListPostsResponse.fromJson(json) {
    if (json != null) {
      listPostsResponse = <PostsResponse>[];
      json.forEach((v) {
        listPostsResponse!.add(PostsResponse.fromJson(v));
      });
    }

  }
}

class PostsResponse {
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

  PostsResponse(
      {this.id,
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
        this.eEmbedded});

  PostsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateGmt = json['date_gmt'];
    guid = json['guid'] != null ? new Guid.fromJson(json['guid']) : null;
    modified = json['modified'];
    modifiedGmt = json['modified_gmt'];
    slug = json['slug'];
    status = json['status'];
    type = json['type'];
    link = json['link'];
    title = json['title'] != null ? new Guid.fromJson(json['title']) : null;
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    excerpt =
    json['excerpt'] != null ? new Content.fromJson(json['excerpt']) : null;
    author = json['author'];
    featuredMedia = json['featured_media'];
    commentStatus = json['comment_status'];
    pingStatus = json['ping_status'];
    sticky = json['sticky'];
    template = json['template'];
    format = json['format'];
    categories = json['categories'].cast<int>();
    eEmbedded = json['_embedded'] != null
        ? new Embedded.fromJson(json['_embedded'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['date_gmt'] = this.dateGmt;
    if (this.guid != null) {
      data['guid'] = this.guid!.toJson();
    }
    data['modified'] = this.modified;
    data['modified_gmt'] = this.modifiedGmt;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['type'] = this.type;
    data['link'] = this.link;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    if (this.excerpt != null) {
      data['excerpt'] = this.excerpt!.toJson();
    }
    data['author'] = this.author;
    data['featured_media'] = this.featuredMedia;
    data['comment_status'] = this.commentStatus;
    data['ping_status'] = this.pingStatus;
    data['sticky'] = this.sticky;
    data['template'] = this.template;
    data['format'] = this.format;
    data['categories'] = this.categories;
    if (this.eEmbedded != null) {
      data['_embedded'] = this.eEmbedded!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    data['protected'] = this.protected;
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
        wpFeaturedmedia!.add(new WpFeaturedmedia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wpFeaturedmedia != null) {
      data['wp:featuredmedia'] =
          this.wpFeaturedmedia!.map((v) => v.toJson()).toList();
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

  WpFeaturedmedia(
      {this.id,
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
        this.lLinks});

  WpFeaturedmedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    slug = json['slug'];
    type = json['type'];
    link = json['link'];
    title = json['title'] != null ? new Guid.fromJson(json['title']) : null;
    author = json['author'];
    caption =
    json['caption'] != null ? new Guid.fromJson(json['caption']) : null;
    altText = json['alt_text'];
    mediaType = json['media_type'];
    mimeType = json['mime_type'];
    mediaDetails = json['media_details'] != null
        ? new MediaDetails.fromJson(json['media_details'])
        : null;
    sourceUrl = json['source_url'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['slug'] = this.slug;
    data['type'] = this.type;
    data['link'] = this.link;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    data['author'] = this.author;
    if (this.caption != null) {
      data['caption'] = this.caption!.toJson();
    }
    data['alt_text'] = this.altText;
    data['media_type'] = this.mediaType;
    data['mime_type'] = this.mimeType;
    if (this.mediaDetails != null) {
      data['media_details'] = this.mediaDetails!.toJson();
    }
    data['source_url'] = this.sourceUrl;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
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

  MediaDetails(
      {this.width,
        this.height,
        this.file,
        this.filesize,
        this.sizes,
        this.imageMeta});

  MediaDetails.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    file = json['file'];
    filesize = json['filesize'];
    sizes = json['sizes'] != null ? new Sizes.fromJson(json['sizes']) : null;
    imageMeta = json['image_meta'] != null
        ? new ImageMeta.fromJson(json['image_meta'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['file'] = this.file;
    data['filesize'] = this.filesize;
    if (this.sizes != null) {
      data['sizes'] = this.sizes!.toJson();
    }
    if (this.imageMeta != null) {
      data['image_meta'] = this.imageMeta!.toJson();
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

  Sizes(
      {this.medium,
        this.thumbnail,
        this.mediumLarge,
        this.yithWoocompareImage,
        this.yithWcbrLogoSize,
        this.woocommerceThumbnail,
        this.woocommerceSingle,
        this.woocommerceGalleryThumbnail,
        this.dgwtWcasProductSuggestion,
        this.full});

  Sizes.fromJson(Map<String, dynamic> json) {
    medium =
    json['medium'] != null ? new Medium.fromJson(json['medium']) : null;
    thumbnail = json['thumbnail'] != null
        ? new Medium.fromJson(json['thumbnail'])
        : null;
    mediumLarge = json['medium_large'] != null
        ? new Medium.fromJson(json['medium_large'])
        : null;
    yithWoocompareImage = json['yith-woocompare-image'] != null
        ? new Medium.fromJson(json['yith-woocompare-image'])
        : null;
    yithWcbrLogoSize = json['yith_wcbr_logo_size'] != null
        ? new Medium.fromJson(json['yith_wcbr_logo_size'])
        : null;
    woocommerceThumbnail = json['woocommerce_thumbnail'] != null
        ? new WoocommerceThumbnail.fromJson(json['woocommerce_thumbnail'])
        : null;
    woocommerceSingle = json['woocommerce_single'] != null
        ? new Medium.fromJson(json['woocommerce_single'])
        : null;
    woocommerceGalleryThumbnail = json['woocommerce_gallery_thumbnail'] != null
        ? new Medium.fromJson(json['woocommerce_gallery_thumbnail'])
        : null;
    dgwtWcasProductSuggestion = json['dgwt-wcas-product-suggestion'] != null
        ? new Medium.fromJson(json['dgwt-wcas-product-suggestion'])
        : null;
    full = json['full'] != null ? new Full.fromJson(json['full']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medium != null) {
      data['medium'] = this.medium!.toJson();
    }
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    if (this.mediumLarge != null) {
      data['medium_large'] = this.mediumLarge!.toJson();
    }
    if (this.yithWoocompareImage != null) {
      data['yith-woocompare-image'] = this.yithWoocompareImage!.toJson();
    }
    if (this.yithWcbrLogoSize != null) {
      data['yith_wcbr_logo_size'] = this.yithWcbrLogoSize!.toJson();
    }
    if (this.woocommerceThumbnail != null) {
      data['woocommerce_thumbnail'] = this.woocommerceThumbnail!.toJson();
    }
    if (this.woocommerceSingle != null) {
      data['woocommerce_single'] = this.woocommerceSingle!.toJson();
    }
    if (this.woocommerceGalleryThumbnail != null) {
      data['woocommerce_gallery_thumbnail'] =
          this.woocommerceGalleryThumbnail!.toJson();
    }
    if (this.dgwtWcasProductSuggestion != null) {
      data['dgwt-wcas-product-suggestion'] =
          this.dgwtWcasProductSuggestion!.toJson();
    }
    if (this.full != null) {
      data['full'] = this.full!.toJson();
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

  Medium(
      {this.file,
        this.width,
        this.height,
        this.filesize,
        this.mimeType,
        this.sourceUrl});

  Medium.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    width = json['width'];
    height = json['height'];
    filesize = json['filesize'];
    mimeType = json['mime_type'];
    sourceUrl = json['source_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['width'] = this.width;
    data['height'] = this.height;
    data['filesize'] = this.filesize;
    data['mime_type'] = this.mimeType;
    data['source_url'] = this.sourceUrl;
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

  WoocommerceThumbnail(
      {this.file,
        this.width,
        this.height,
        this.filesize,
        this.uncropped,
        this.mimeType,
        this.sourceUrl});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['width'] = this.width;
    data['height'] = this.height;
    data['filesize'] = this.filesize;
    data['uncropped'] = this.uncropped;
    data['mime_type'] = this.mimeType;
    data['source_url'] = this.sourceUrl;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['width'] = this.width;
    data['height'] = this.height;
    data['mime_type'] = this.mimeType;
    data['source_url'] = this.sourceUrl;
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

  ImageMeta(
      {this.aperture,
        this.credit,
        this.camera,
        this.caption,
        this.createdTimestamp,
        this.copyright,
        this.focalLength,
        this.iso,
        this.shutterSpeed,
        this.title,
        this.orientation});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aperture'] = this.aperture;
    data['credit'] = this.credit;
    data['camera'] = this.camera;
    data['caption'] = this.caption;
    data['created_timestamp'] = this.createdTimestamp;
    data['copyright'] = this.copyright;
    data['focal_length'] = this.focalLength;
    data['iso'] = this.iso;
    data['shutter_speed'] = this.shutterSpeed;
    data['title'] = this.title;
    data['orientation'] = this.orientation;
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
        self!.add(new Self.fromJson(v));
      });
    }
    if (json['author'] != null) {
      author = <Author>[];
      json['author'].forEach((v) {
        author!.add(new Author.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.map((v) => v.toJson()).toList();
    }
    if (this.author != null) {
      data['author'] = this.author!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['embeddable'] = this.embeddable;
    data['href'] = this.href;
    return data;
  }
}









