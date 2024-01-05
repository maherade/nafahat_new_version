class PaymentResponse {
  String? htmlUrl;

  PaymentResponse({this.htmlUrl});

  PaymentResponse.fromJson(json) {
    if (json != null) {
      htmlUrl = json;
    }
  }
}
