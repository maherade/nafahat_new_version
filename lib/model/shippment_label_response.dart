class ShipmentLabelResponse {
  bool? success;
  String? shipmentId;
  String? trackingNumber;
  String? urlShippingLabel;

  ShipmentLabelResponse({
    this.success,
    this.shipmentId,
    this.trackingNumber,
    this.urlShippingLabel,
  });

  ShipmentLabelResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    shipmentId = json['shipment_id'];
    trackingNumber = json['tracking_number'];
    urlShippingLabel = json['url_shipping_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['shipment_id'] = shipmentId;
    data['tracking_number'] = trackingNumber;
    data['url_shipping_label'] = urlShippingLabel;
    return data;
  }
}
