class ListViewAllInformationAboutCustomerResponse {
  bool? success;
  List<Data>? data;

  ListViewAllInformationAboutCustomerResponse({this.success, this.data});

  ListViewAllInformationAboutCustomerResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? userAvatar;
  String? userBillingFullname;
  String? userAddress;
  String? userBillingEmail;
  String? userMainEmail;
  String? userLang;

  Data({
    this.userId,
    this.userAvatar,
    this.userBillingFullname,
    this.userAddress,
    this.userBillingEmail,
    this.userMainEmail,
    this.userLang,
  });

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userAvatar = json['user_avatar'];
    userBillingFullname = json['user_billing_fullname'];
    userAddress = json['user_address'];
    userBillingEmail = json['user_billing_email'];
    userMainEmail = json['user_main_email'];
    userLang = json['user_lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_avatar'] = userAvatar;
    data['user_billing_fullname'] = userBillingFullname;
    data['user_address'] = userAddress;
    data['user_billing_email'] = userBillingEmail;
    data['user_main_email'] = userMainEmail;
    data['user_lang'] = userLang;
    return data;
  }
}
