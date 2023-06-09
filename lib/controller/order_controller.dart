

import 'package:get/get.dart';
import 'package:perfume_store_mobile_app/model/coupon_response.dart';
import 'package:perfume_store_mobile_app/model/order.dart';
import 'package:perfume_store_mobile_app/model/shippment_label_response.dart';

import '../model/countries_response.dart';
import '../model/customer_point_response.dart';
import '../model/delivery_time_response.dart';
import '../model/order_list_response.dart';
import '../model/payment_method_response.dart';
import '../model/payment_response.dart';
import '../model/points_response.dart';
import '../model/red_box_response.dart';
import '../model/shipping_method_response.dart';




class OrderController extends GetxController{
   Rx<ListShippingMethodsResponse>? getShippingMethodsData = ListShippingMethodsResponse().obs;
   Rx<ListCountriesResponse>? getCountriesData = ListCountriesResponse().obs;
   Rx<ListPaymentMethodsResponse>? getPaymentMethodsData = ListPaymentMethodsResponse().obs;
   Rx<PaymentResponse>? getPaymentHtmlPage = PaymentResponse().obs;
   Rx<RedBoxResponse>? getRedBoxData = RedBoxResponse().obs;
   Rx<ShipmentLabelResponse>? getShipmentLabelData = ShipmentLabelResponse().obs;
   Rx<ListOrderListResponse>? getOrderListData = ListOrderListResponse().obs;
   Rx<PointsResponse>? getPointsListData = PointsResponse().obs;
   Rx<CustomerPointResponse>? getCustomerPointsData = CustomerPointResponse().obs;
   Rx<CouponResponse>? getCouponData = CouponResponse().obs;
   Rx<DeliveryTimeResponse>? getDeliveryTimeData = DeliveryTimeResponse().obs;
   Rx<CreateOrderResponse>? getCreateOrderData = CreateOrderResponse().obs;
}