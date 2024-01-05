class CouponResponse {
  int? id;
  String? code;
  String? amount;
  String? status;
  String? discountType;
  String? description;
  int? usageCount;

  CouponResponse({
    this.id,
    this.code,
    this.amount,
    this.status,
    this.discountType,
    this.description,
    this.usageCount,
  });

  CouponResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    amount = json['amount'];
    status = json['status'];
    discountType = json['discount_type'];
    description = json['description'];
    usageCount = json['usage_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['amount'] = amount;
    data['status'] = status;
    data['discount_type'] = discountType;
    data['description'] = description;
    data['usage_count'] = usageCount;
    return data;
  }
}
