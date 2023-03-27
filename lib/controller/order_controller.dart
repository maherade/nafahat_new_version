

import 'package:get/get.dart';

import '../model/countries_response.dart';
import '../model/payment_method_response.dart';
import '../model/payment_response.dart';
import '../model/red_box_response.dart';
import '../model/shipping_method_response.dart';




class OrderController extends GetxController{
   Rx<ListShippingMethodsResponse>? getShippingMethodsData = ListShippingMethodsResponse().obs;
   Rx<ListCountriesResponse>? getCountriesData = ListCountriesResponse().obs;
   Rx<ListPaymentMethodsResponse>? getPaymentMethodsData = ListPaymentMethodsResponse().obs;
   Rx<PaymentResponse>? getPaymentHtmlPage = PaymentResponse().obs;
   Rx<RedBoxResponse>? getRedBoxData = RedBoxResponse().obs;
}