class ListProductResponse {
  List<Data>? data;
  Headers? headers;
  int? status;

  ListProductResponse({this.data, this.headers, this.status});

  ListProductResponse.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.headers != null) {
      data['headers'] = this.headers!.toJson();
    }
    data['status'] = this.status;
    return data;
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
        this.brands});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    description = json['description'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['description'] = this.description;
    data['average_rating'] = this.averageRating;
    data['rating_count'] = this.ratingCount;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
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
