class DeliveryTimeResponse {
  bool? success;
  double? deliveryTime;

  DeliveryTimeResponse({this.success, this.deliveryTime});

  DeliveryTimeResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    deliveryTime = json['delivery_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['delivery_time'] = this.deliveryTime;
    return data;
  }
}
