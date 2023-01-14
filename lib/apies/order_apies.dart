import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;

import '../const_urls.dart';
import '../controller/order_controller.dart';
import '../controller/review_controller.dart';
import '../model/countries_response.dart';
import '../model/order.dart';
import '../model/payment_method_response.dart';
import '../model/review_response.dart';
import '../model/shipping_method_response.dart';
import '../services/Settingss.dart';
import '../services/helper.dart';
import '../services/progress_dialog_utils.dart';

class OrderApies {
  OrderApies._();

  static OrderApies orderApies = OrderApies._();
  OrderController orderController = myGet.Get.find();

  getShippingMethods() async {
    orderController.getShippingMethodsData!.value = ListShippingMethodsResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        shippingMethodsURL,
      );
      if (response.statusCode == 200) {
        orderController.getShippingMethodsData!.value = ListShippingMethodsResponse.fromJson(response.data);
        print("getReviewData Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getCountries() async {
    orderController.getCountriesData!.value = ListCountriesResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        getCountriesURL,
      );
      if (response.statusCode == 200) {
        print(response.data);
        orderController.getCountriesData!.value = ListCountriesResponse.fromJson(response.data);
        print("getCountries Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getPaymentMethods() async {
    orderController.getPaymentMethodsData!.value = ListPaymentMethodsResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        getPaymentMethodsURL,
      );
      if (response.statusCode == 200) {
        print(response.data);
        orderController.getPaymentMethodsData!.value = ListPaymentMethodsResponse.fromJson(response.data);
        print("getPaymentMethods Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  createOrder({
    String? parent_id,
    String? payment_method,
    String? currency,
    String? customer_id,
    String? payment_method_title,
    String? set_paid,
    Map<String,dynamic>? billing,
    Map<String,dynamic>? shipping,
    List<Map<String,dynamic>>? line_items,
    List<Map<String,dynamic>>? shipping_lines,
  }) async {
    try {
      ProgressDialogUtils.show();
      Response response = await Settingss.settings.dio!.post(orderURL, queryParameters: {
        'parent_id': parent_id,
        'customer_id': customer_id,
        'currency': currency,
        'payment_method': payment_method,
        'payment_method_title': payment_method_title,
        'set_paid': set_paid,
        'billing': billing,
        'shipping': shipping,
        'line_items': line_items,
        'shipping_lines': shipping_lines,
      });
      if (response.statusCode == 201) {
        ProgressDialogUtils.hide();
        Helper.getSheetSucsses('تم إضافة الطلب بنجاح');
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError('يرجى التأكد من المعلومات المدخلة');
      }
    } catch (e) {
      ProgressDialogUtils.hide();
      Helper.getSheetError('يرجى التأكد من المعلومات المدخلة');
      print(e.toString());
    }
  }


  final client = HttpClient();
  final key = 'ck_54b7ebd52fd718be81cb1043637c84732aa1705c';
  final secret = 'cs_df50caa82b6d05266923b0f9a6e2aaa000960410';
  Future<Order> createOrder2({
    required String? customer_id,
    required String payment_method,
    required String payment_method_title,
    required String firstName,
    required String lastName,
    required String addressOne,
    required String addressTwo,
    required String city,
    required String country,
    required String state,
    required String postcode,
    required String email,
    required String phone,
    required String total,
    required List<Map<String,dynamic>> listProduct,

  }) async {
    print('yehya$customer_id');
    final url = Uri.parse(
      'https://nafahat.com/wp-json/wc/v3/orders?consumer_key=$key&consumer_secret=$secret',
    );
    final parameters = <String, dynamic>{
      ...(customer_id != 'null' ? {'customer_id': customer_id} : {}),
      'payment_method_title': payment_method_title,
      'payment_method': payment_method,
      'billing': {
        'first_name': firstName,
        'last_name': lastName,
        'address_1': addressOne,
        'address_2': addressTwo,
        'city': city,
        'country': country,
        'state': state,
        'postcode': postcode,
        'email': email,
        'phone': phone,
      },
      'shipping': {
        'first_name': firstName,
        'last_name': lastName,
        'address_1': addressOne,
        'address_2': addressTwo,
        'city': city,
        'country': country,
        'state': state,
        'postcode': postcode,
        'email': email,
        'phone': phone,
      },
      'line_items': listProduct,
    };
    ProgressDialogUtils.show();

    final request = await client.postUrl(url);
    request.headers.set("Content-Type", "application/json; charset=utf-8");
    request.write(jsonEncode(parameters));
    final response = await request.close();
    if(response.statusCode == 201){
      ProgressDialogUtils.hide();
      Helper.getSheetSucsses('تم إرسال الطلب');
    }else{
      ProgressDialogUtils.hide();
      Helper.getSheetError('حدث خطأ');
    }
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    print(json);
    final order = Order.fromJson(json);
    return order;
  }
}

