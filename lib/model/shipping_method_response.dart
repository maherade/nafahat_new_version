class ListShippingMethodsResponse {
  List<ShippingMethodsResponse>? listShippingMethodsResponse;

  String? totalPage;

  ListShippingMethodsResponse({
    this.listShippingMethodsResponse,
    this.totalPage,
  });

  ListShippingMethodsResponse.fromJson(json) {
    if (json != null) {
      listShippingMethodsResponse = <ShippingMethodsResponse>[];
      json.forEach((v) {
        listShippingMethodsResponse!.add(ShippingMethodsResponse.fromJson(v));
      });
    }
  }
}

class ShippingMethodsResponse {
  String? id;
  String? title;
  String? description;
  Links? lLinks;

  ShippingMethodsResponse({this.id, this.title, this.description, this.lLinks});

  ShippingMethodsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    if (lLinks != null) {
      data['_links'] = lLinks!.toJson();
    }
    return data;
  }
}

class Links {
  List<Self>? self;

  Links({this.self});

  Links.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <Self>[];
      json['self'].forEach((v) {
        self!.add(Self.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (self != null) {
      data['self'] = self!.map((v) => v.toJson()).toList();
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
