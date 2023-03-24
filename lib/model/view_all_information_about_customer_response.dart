class ViewAllInformationAboutCustomerResponse {
  bool? success;
  Data? data;

  ViewAllInformationAboutCustomerResponse({this.success, this.data});

  ViewAllInformationAboutCustomerResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? dateCreated;
  String? dateModified;
  String? email;
  String? firstName;
  String? lastName;
  String? displayName;
  String? role;
  String? username;
  String? avatarUrl;

  Data(
      {this.id,
        this.dateCreated,
        this.dateModified,
        this.email,
        this.firstName,
        this.lastName,
        this.displayName,
        this.role,
        this.username,
        this.avatarUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateModified = json['date_modified'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    displayName = json['display_name'];
    role = json['role'];
    username = json['username'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_modified'] = this.dateModified;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['display_name'] = this.displayName;
    data['role'] = this.role;
    data['username'] = this.username;
    data['avatar_url'] = this.avatarUrl;
    return data;
  }
}
