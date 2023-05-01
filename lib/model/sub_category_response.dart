import 'dart:convert';

class ListSubCategoryResponse {
  List<SubCategoryResponse>? listSubCategoryResponse ;

  ListSubCategoryResponse({this.listSubCategoryResponse});
  ListSubCategoryResponse.fromJson( json) {
    if (json != null) {
      listSubCategoryResponse = <SubCategoryResponse>[];
      json.forEach((v) {

          listSubCategoryResponse!.add(SubCategoryResponse.fromJson(v));

      });
    }

  }
}
class SubCategoryResponse {
  int? id;
  String? name;
  int? parent;
  String? description;
  String? display;
  Image? image;
  int? count;

  SubCategoryResponse(
      {this.id,
        this.name,
        this.parent,
        this.description,
        this.display,
        this.image,
        this.count});

  SubCategoryResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
    description = json['description'];
    display = json['display'];
    image = json['image'] != null && json['image'] is !List ? new Image.fromJson(json['image']) : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent'] = this.parent;
    data['description'] = this.description;
    data['display'] = this.display;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['count'] = this.count;
    return data;
  }
}

class Image {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? title;
  String? alt;

  Image(
      {this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.src,
        this.title,
        this.alt});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    title = json['title'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['src'] = this.src;
    data['title'] = this.title;
    data['alt'] = this.alt;
    return data;
  }
}


