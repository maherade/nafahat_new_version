class ListShippingMethodsResponse {
  List<ShippingMethodsResponse>? listShippingMethodsResponse ;
  String? totalPage ;

  ListShippingMethodsResponse({this.listShippingMethodsResponse,this.totalPage});
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
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
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
        self!.add(new Self.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.map((v) => v.toJson()).toList();
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
