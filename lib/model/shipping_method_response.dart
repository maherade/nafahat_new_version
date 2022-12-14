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

  ShippingMethodsResponse({this.id, this.title, this.description});

  ShippingMethodsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
