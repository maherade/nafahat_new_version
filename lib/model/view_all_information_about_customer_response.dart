class ListViewAllInformationAboutCustomerResponse {
  List<ViewAllInformationAboutCustomerResponse>? listViewAllInformationAboutCustomerList;

  ListViewAllInformationAboutCustomerResponse({this.listViewAllInformationAboutCustomerList});
  ListViewAllInformationAboutCustomerResponse.fromJson(json) {
    if (json != null) {
      listViewAllInformationAboutCustomerList = <ViewAllInformationAboutCustomerResponse>[];
      for (var v in json) {
        listViewAllInformationAboutCustomerList!.add(ViewAllInformationAboutCustomerResponse.fromJson(v));
      }
    }

  }

}

class ViewAllInformationAboutCustomerResponse {
  String? userId;
  String? userAvatar;
  String? userBillingFullname;
  String? userAddress;
  String? userBillingEmail;
  String? userMainEmail;
  String? userLang;

  ViewAllInformationAboutCustomerResponse(
      {this.userId,
        this.userAvatar,
        this.userBillingFullname,
        this.userAddress,
        this.userBillingEmail,
        this.userMainEmail,
        this.userLang});

  ViewAllInformationAboutCustomerResponse.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userAvatar = json['user_avatar'];
    userBillingFullname = json['user_billing_fullname'];
    userAddress = json['user_address'];
    userBillingEmail = json['user_billing_email'];
    userMainEmail = json['user_main_email'];
    userLang = json['user_lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_avatar'] = this.userAvatar;
    data['user_billing_fullname'] = this.userBillingFullname;
    data['user_address'] = this.userAddress;
    data['user_billing_email'] = this.userBillingEmail;
    data['user_main_email'] = this.userMainEmail;
    data['user_lang'] = this.userLang;
    return data;
  }
}
