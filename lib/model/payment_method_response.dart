class ListPaymentMethodsResponse {
  List<PaymentMethodsResponse>? listPaymentMethodsResponse;

  ListPaymentMethodsResponse({this.listPaymentMethodsResponse});

  ListPaymentMethodsResponse.fromJson(json) {
    if (json != null) {
      listPaymentMethodsResponse = <PaymentMethodsResponse>[];
      json.forEach((v) {
        if ((v['enabled']) && v['id'] != 'tabby_installments') {
          listPaymentMethodsResponse!.add(PaymentMethodsResponse.fromJson(v));
        }
      });
    }
  }
}

class PaymentMethodsResponse {
  String? id;
  String? title;
  String? description;
  String? methodTitle;
  String? methodDescription;

  PaymentMethodsResponse({
    this.id,
    this.title,
    this.description,
    this.methodTitle,
    this.methodDescription,
  });

  PaymentMethodsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    methodTitle = json['method_title'];
    methodDescription = json['method_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['method_title'] = methodTitle;
    data['method_description'] = methodDescription;
    return data;
  }

  @override
  String toString() {
    return 'PaymentMethodsResponse{id: $id, title: $title, description: $description, methodTitle: $methodTitle, methodDescription: $methodDescription}';
  }
}
