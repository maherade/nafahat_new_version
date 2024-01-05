class ListRelatedPostsResponse {
  List<RelatedPostsResponse>? listRelatedPostResponse;

  ListRelatedPostsResponse({this.listRelatedPostResponse});

  ListRelatedPostsResponse.fromJson(json) {
    if (json != null) {
      listRelatedPostResponse = <RelatedPostsResponse>[];
      json.forEach((v) {
        listRelatedPostResponse!.add(RelatedPostsResponse.fromJson(v));
      });
    }
  }
}

class RelatedPostsResponse {
  int? id;
  String? date;
  Title? title;
  Content? content;
  Content? excerpt;
  List<int>? categories;
  YoastHeadJson? yoastHeadJson;

  RelatedPostsResponse({
    this.id,
    this.date,
    this.title,
    this.content,
    this.excerpt,
    this.categories,
    this.yoastHeadJson,
  });

  RelatedPostsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    excerpt =
        json['excerpt'] != null ? Content.fromJson(json['excerpt']) : null;
    categories = json['categories'].cast<int>();
    yoastHeadJson = json['yoast_head_json'] != null
        ? YoastHeadJson.fromJson(json['yoast_head_json'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (content != null) {
      data['content'] = content!.toJson();
    }
    if (excerpt != null) {
      data['excerpt'] = excerpt!.toJson();
    }
    data['categories'] = categories;
    if (yoastHeadJson != null) {
      data['yoast_head_json'] = yoastHeadJson!.toJson();
    }
    return data;
  }
}

class Title {
  String? rendered;

  Title({this.rendered});

  Title.fromJson(Map<String, dynamic> json) {
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

class YoastHeadJson {
  List<OgImage>? ogImage;

  YoastHeadJson({this.ogImage});

  YoastHeadJson.fromJson(Map<String, dynamic> json) {
    if (json['og_image'] != null) {
      ogImage = <OgImage>[];
      json['og_image'].forEach((v) {
        ogImage!.add(OgImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ogImage != null) {
      data['og_image'] = ogImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OgImage {
  int? width;
  int? height;
  String? url;
  String? type;

  OgImage({this.width, this.height, this.url, this.type});

  OgImage.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['type'] = type;
    return data;
  }
}
