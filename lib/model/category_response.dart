import 'dart:convert';

class ListCategoryResponse {
  List<CategoryResponse>? listCategoryResponse ;

  ListCategoryResponse({this.listCategoryResponse});
  ListCategoryResponse.fromJson(json) {
    if (json != null) {
      listCategoryResponse = <CategoryResponse>[];
      json.forEach((v) {
        if(v['id']!= 183 && v['image'] is !List){
          print(true);
          listCategoryResponse!.add(CategoryResponse.fromJson(v));
        }
      });
    }

  }
}
class CategoryResponse {
  int? id;
  String? name;
  String? slug;
  int? parent;
  String? description;
  String? display;
  dynamic image;
  int? menuOrder;
  int? count;

  CategoryResponse(
      {this.id,
        this.name,
        this.slug,
        this.parent,
        this.description,
        this.display,
        this.image,
        this.menuOrder,
        this.count});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parent = json['parent'];
    description = json['description'];
    display = json['display'];
    image = json['image'] != null ?  Image.fromJson(json['image']) : null;
    menuOrder = json['menu_order'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['parent'] = this.parent;
    data['description'] = this.description;
    data['display'] = this.display;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['menu_order'] = this.menuOrder;
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

