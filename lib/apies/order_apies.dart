import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:get/get.dart' as myGet;
import 'package:perfume_store_mobile_app/controller/app_controller.dart';
import 'package:perfume_store_mobile_app/model/customer_point_response.dart';
import 'package:perfume_store_mobile_app/model/points_response.dart';
import 'package:perfume_store_mobile_app/model/red_box_response.dart';
import 'package:perfume_store_mobile_app/services/sp_helper.dart';

import '../const_urls.dart';
import '../controller/order_controller.dart';
import '../model/countries_response.dart';
import '../model/coupon_response.dart';
import '../model/delivery_time_response.dart';
import '../model/order.dart';
import '../model/order_list_response.dart';
import '../model/payment_method_response.dart';
import '../model/shipping_method_response.dart';
import '../services/Settingss.dart';
import '../services/helper.dart';
import '../services/progress_dialog_utils.dart';
import '../view/custom_widget/custom_dialog.dart';

class OrderApies {
  OrderApies._();

  static OrderApies orderApies = OrderApies._();
  OrderController orderController = myGet.Get.find();
  AppController appController = myGet.Get.find();

  getShippingMethods() async {
    orderController.getShippingMethodsData!.value =
        ListShippingMethodsResponse();
    try {
      Response response = await Dio().get(
        'https://nafahat.com/wp-json/wc/v3/shipping_methods',
        queryParameters: {
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        orderController.getShippingMethodsData!.value =
            ListShippingMethodsResponse.fromJson(response.data);
        log("getShippingMethods Successful");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  Future getCountries() async {
    orderController.getCountriesData!.value = ListCountriesResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        getCountriesURL,
        queryParameters: {
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        orderController.getCountriesData!.value =
            ListCountriesResponse.fromJson(response.data);
        log("getCountries Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getPaymentMethods() async {
    orderController.getPaymentMethodsData!.value = ListPaymentMethodsResponse();
    try {
      Response response = await Dio().get(
        'https://nafahat.com/wp-json/wc/v3/payment_gateways',
        queryParameters: {
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        orderController.getPaymentMethodsData!.value =
            ListPaymentMethodsResponse.fromJson(response.data);
        log("getPaymentMethods Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  Future<CreateOrderResponse> createTamaraOrder({
    required String? customer_id,
    String? status,
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
    required bool setPaid,
    required List<Map<String, dynamic>> listProduct,
    required List<Map<String, dynamic>> listShipment,
    required List<Map<String, dynamic>> listMetaData,
    required List<Map<String, dynamic>> items,
    String? couponCode,
  }) async {
    try {
      orderController.getCreateOrderData!.value = CreateOrderResponse();

      log('yehya$customer_id');

      //* delete authorization
      // final options = Options(
      //   headers: {
      //     "Content-Type": "application/json; charset=utf-8",
      //     'authorization':
      //         'Basic ${base64.encode(utf8.encode('$username:$password'))}'
      //   },
      // );

      final data = {
        if (customer_id != 'null') 'customer_id': customer_id,
        "status": status ?? "processing",
        "currency": "SAR",
        'payment_method_title': payment_method_title,
        'payment_method': payment_method,
        "set_paid": setPaid,
        'billing': {
          'first_name': firstName,
          'last_name': lastName,
          'address_1': addressOne,
          'address_2': addressTwo,
          'city': city,
          'country': country,
          // 'state': state,
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
          // 'state': state,
          'postcode': postcode,
          'email': email,
          'phone': phone,
        },
        'line_items': listProduct,
        "shipping_lines": listShipment,
        'meta_data': listMetaData,
        if (couponCode != '' && couponCode != null)
          'coupon_lines': [
            {
              'code': couponCode,
            }
          ],
      };

      ProgressDialogUtils.show();
      log(data.toString());
      final response = await Dio().post(
        'https://nafahat.com/wp-json/wc/v3/orders',
        // options: options,
        data: data,
      );

      if (response.statusCode! >= 200) {
        orderController.getCreateOrderData!.value =
            CreateOrderResponse.fromJson(response.data);

        log('createTamaraOrder${response.data}');

        ProgressDialogUtils.hide();

        return CreateOrderResponse.fromJson(response.data);
      } else {
        ProgressDialogUtils.hide();
        SVProgressHUD.showError(status: 'حدث خطأ');
        return Future.error('حدث خطأ');
      }
    } on DioError catch (err) {
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response!.data['message'].toString());
      log(err.response.toString());
      return Future.error(err);
    } catch (err) {
      ProgressDialogUtils.hide();
      log(err.toString());
      return Future.error(err);
    }
  }

  updateTamaraOrder({
    required String? orderID,
    required String? customer_id,
    String? status,
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
    required bool setPaid,
    required List<Map<String, dynamic>> listProduct,
    required List<Map<String, dynamic>> listShipment,
    required List<Map<String, dynamic>> listMetaData,
    required List<Map<String, dynamic>> items,
    String? couponCode,
  }) async {
    try {
      final options =
          Options(headers: {"Content-Type": "application/json; charset=utf-8"});

      final data = {
        if (customer_id != 'null') 'customer_id': customer_id,
        "status": status ?? "processing",
        "currency": "SAR",
        'payment_method_title': payment_method_title,
        'payment_method': payment_method,
        "set_paid": setPaid,
        'billing': {
          'first_name': firstName,
          'last_name': lastName,
          'address_1': addressOne,
          'address_2': addressTwo,
          'city': city,
          'country': country,
          // 'state': state,
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
          // 'state': state,
          'postcode': postcode,
          'email': email,
          'phone': phone,
        },
        'line_items': listProduct,
        "shipping_lines": listShipment,
        'meta_data': listMetaData,
        if (couponCode != '' && couponCode != null)
          'coupon_lines': [
            {
              'code': couponCode,
            }
          ],
      };

      ProgressDialogUtils.show();

      final response = await Dio().put(
        "https://nafahat.com/wp-json/wc/v3/orders/$orderID",
        options: options,
        data: data,
      );

      if (response.statusCode == 200) {
        log('orderUpdate${response.data}');
        orderController.getCouponData!.value = CouponResponse();
        appController.myMarker != null
            ? createRedBoxShippment(
                items: items,
                reference: response.data['id'].toString(),
                point_id: appController.myMarker?.point?.id ?? '',
                sender_name: 'مؤسسة الجمال والصحة للتجارة',
                sender_email: 'info@dermarollersystemsa.com',
                sender_phone: '0114130336',
                sender_address: 'Riyadh -  - ',
                customer_name: '$firstName - $lastName',
                customer_email: email,
                customer_phone: phone,
                customer_address: '$addressOne - $addressTwo',
                cod_currency: 'SAR',
                cod_amount: total,
                nameOfPackage: 'nameOfPackage',
              )
            : null;
        ProgressDialogUtils.hide();
        CustomDialog.customDialog.showOrderDoneDialog();
      } else {
        ProgressDialogUtils.hide();
        SVProgressHUD.showError(status: 'حدث خطأ');
      }
    } on DioError catch (err) {
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response!.data);
      log(err.response.toString());
    } catch (err) {
      ProgressDialogUtils.hide();
      log(err.toString());
    }
  }

  Future<CreateOrderResponse> createOrder2({
    required String? customer_id,
    String? status,
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
    required bool setPaid,
    required List<Map<String, dynamic>> listProduct,
    required List<Map<String, dynamic>> listShipment,
    required List<Map<String, dynamic>> listMetaData,
    required List<Map<String, dynamic>> items,
    String? couponCode,
  }) async {
    try {
      orderController.getCreateOrderData!.value = CreateOrderResponse();

      log('yehya$customer_id');

      // final options = Options(
      //   headers: {
      //     "Content-Type": "application/json; charset=utf-8",
      //     'authorization':
      //         'Basic ${base64.encode(utf8.encode('$username:$password'))}'
      //   },
      // );

      final data = {
        if (customer_id != 'null') 'customer_id': customer_id,
        "status": status ?? "processing",
        "currency": "SAR",
        'payment_method_title': payment_method_title,
        'payment_method': payment_method,
        "set_paid": setPaid,
        'billing': {
          'first_name': firstName,
          'last_name': lastName,
          'address_1': addressOne,
          'address_2': addressTwo,
          'city': city,
          'country': country,
          // 'state': state,
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
          // 'state': state,
          'postcode': postcode,
          'email': email,
          'phone': phone,
        },
        'line_items': listProduct,
        "shipping_lines": listShipment,
        'meta_data': listMetaData,
        if (couponCode != '' && couponCode != null)
          'coupon_lines': [
            {
              'code': couponCode,
            }
          ],
      };

      ProgressDialogUtils.show();

      final response = await Dio().post(
        'https://nafahat.com/wp-json/wc/v3/orders',
        // options: options,
        data: data,
      );

      if (response.statusCode! >= 200) {
        orderController.getCreateOrderData!.value =
            CreateOrderResponse.fromJson(response.data);

        orderController.getCouponData!.value = CouponResponse();
        appController.myMarker != null
            ? createRedBoxShippment(
                items: items,
                reference: response.data['id'].toString(),
                point_id: appController.myMarker?.point?.id ?? '',
                sender_name: 'مؤسسة الجمال والصحة للتجارة',
                sender_email: 'info@dermarollersystemsa.com',
                sender_phone: '0114130336',
                sender_address: 'Riyadh -  - ',
                customer_name: '$firstName - $lastName',
                customer_email: email,
                customer_phone: phone,
                customer_address: '$addressOne - $addressTwo',
                cod_currency: 'SAR',
                cod_amount: total,
                nameOfPackage: 'nameOfPackage',
              )
            : null;
        ProgressDialogUtils.hide();
        CustomDialog.customDialog.showOrderDoneDialog();

        return CreateOrderResponse.fromJson(response.data);
      } else {
        ProgressDialogUtils.hide();
        SVProgressHUD.showError(status: 'حدث خطأ');
        return Future.error('حدث خطأ');
      }
    } on DioError catch (err) {
      ProgressDialogUtils.hide();

      log("createOrder2 ${err.response}");
      Helper.getSheetError(err.response!.data);

      return Future.error(err);
    } catch (err) {
      log("createOrder2 err $err");
      ProgressDialogUtils.hide();

      return Future.error(err);
    }
  }

  updateOrder({
    required String? orderID,
    required List<Map<String, dynamic>> listMetaData,
  }) async {
    try {
      final options =
          Options(headers: {"Content-Type": "application/json; charset=utf-8"});

      final data = {
        'meta_data': listMetaData,
      };

      ProgressDialogUtils.show();

      final response = await Dio().put(
        "https://nafahat.com/wp-json/wc/v3/orders/$orderID",
        options: options,
        data: data,
      );

      if (response.statusCode == 200) {
        log('orderUpdate${response.data}');
        ProgressDialogUtils.hide();
      } else {
        ProgressDialogUtils.hide();
        SVProgressHUD.showError(status: 'حدث خطأ');
      }
    } on DioError catch (err) {
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response!.data);
      log(err.response.toString());
    } catch (err) {
      ProgressDialogUtils.hide();
      log(err.toString());
    }
  }

  getRedBoxPlaces({String? lat, String? long, String? distance}) async {
    try {
      String token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb25faWQiOiI2MTU5ZDdlNGNmNTczZTBkYzc2NzQzNWMiLCJrZXkiOiIyMDIzLTAzLTI0VDIwOjIwOjE2LjgwM1oiLCJpYXQiOjE2Nzk2ODkyMTZ9.KpIjND0ReqYnMx-pBypVWnzIs1DYViqVuuHN51yO0Tc';

      orderController.getRedBoxData!.value = RedBoxResponse();

      Response response = await Dio().get(
        "https://app.redboxsa.com/api/business/v1/get-points?lat=$lat&lng=$long&distance=$distance",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode! >= 200) {
        orderController.getRedBoxData!.value =
            RedBoxResponse.fromJson(jsonDecode(response.data));
        log("getRedBoxPlaces");
      } else {
        Helper.getSheetError('error');
      }
    } catch (e) {
      Helper.getSheetError('error');
      log(e.toString());
    }
  }

  Future<Response> createRedBoxShippment({
    required List<Map<String, dynamic>> items,
    required String? reference,
    required String point_id,
    required String sender_name,
    required String sender_email,
    required String sender_phone,
    required String sender_address,
    required String customer_name,
    required String customer_email,
    required String customer_phone,
    required String customer_address,
    required String cod_currency,
    required String cod_amount,
    required String nameOfPackage,
  }) async {
    // orderController.getShipmentLabelData!.value = ShipmentLabelResponse();
    try {
      String token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb25faWQiOiI2MTU5ZDdlNGNmNTczZTBkYzc2NzQzNWMiLCJrZXkiOiIyMDIzLTAzLTI0VDIwOjIwOjE2LjgwM1oiLCJpYXQiOjE2Nzk2ODkyMTZ9.KpIjND0ReqYnMx-pBypVWnzIs1DYViqVuuHN51yO0Tc';

      final data = {
        'items': items,
        "reference": reference,
        "point_id": point_id,
        "sender_name": sender_name,
        'sender_email': sender_email,
        'sender_phone': sender_phone,
        'sender_address': sender_address,
        'customer_name': customer_name,
        'customer_email': customer_email,
        'customer_phone': customer_phone,
        'customer_address': customer_address,
        'cod_currency': cod_currency,
        'cod_amount': cod_amount,
      };
      // ProgressDialogUtils.show();

      Response response = await Dio().post(
        "https://app.redboxsa.com/api/business/v1/create-shipment",
        queryParameters: {"nameOfPackage": nameOfPackage},
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.data);

        log('createRedBoxShippment${response.data}');
        log(
          'url_shipping_label${responseData['url_shipping_label']}',
        );

        // orderController.getShipmentLabelData!.value = ShipmentLabelResponse.fromJson(response.data);
        updateOrder(
          orderID: reference,
          listMetaData: [
            {
              'key': '_redbox_point',
              'value':
                  "${appController.myMarker?.point?.pointName} - ${appController.myMarker?.point?.city} - ${appController.myMarker?.point?.address?.street}",
            },
            {
              'key': '_redbox_point_id',
              'value': "${appController.myMarker?.point?.id}",
            },
            {
              'key': 'redbox_shipment_url_shipping_label',
              'value': responseData['url_shipping_label'],
            },
          ],
        );
        return response;
        // ProgressDialogUtils.hide();
      } else {
        return response;
        // ProgressDialogUtils.hide();
        // SVProgressHUD.showError(status: 'حدث خطأ');
      }
    } on DioError catch (err) {
      return err.response!;

      // ProgressDialogUtils.hide();
      // Helper.getSheetError(err.response!.data);
    } catch (err) {
      // ProgressDialogUtils.hide();
      log(err.toString());
      rethrow;
    }
  }

  Future<Response> getRedBoxLabel({
    required String? shipment_id,
    required String? orderId,
  }) async {
    try {
      String token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb25faWQiOiI2MTU5ZDdlNGNmNTczZTBkYzc2NzQzNWMiLCJrZXkiOiIyMDIzLTAzLTI0VDIwOjIwOjE2LjgwM1oiLCJpYXQiOjE2Nzk2ODkyMTZ9.KpIjND0ReqYnMx-pBypVWnzIs1DYViqVuuHN51yO0Tc';
      Response response = await Dio().post(
        "https://app.redboxsa.com/api/business/v1/get-shipment-shipping-label",
        queryParameters: {
          'shipment_id': shipment_id,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        log('getRedBoxLabel${response.data}');
        updateOrder(
          orderID: orderId,
          listMetaData: [
            {
              'key': '_redbox_point',
              'value':
                  "${appController.myMarker?.point?.pointName} - ${appController.myMarker?.point?.city} - ${appController.myMarker?.point?.address?.street}",
            },
            {
              'key': '_redbox_point_id',
              'value': "${appController.myMarker?.point?.id}",
            },
            {
              'key': 'redbox_shipment_url_shipping_label',
              'value': response.data['url'],
            },
          ],
        );
        return response;
      } else {
        return response;
      }
    } on DioError catch (err) {
      log(err.response.toString());
      return err.response!;
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  getOrderList({String? customerID, String? status}) async {
    orderController.getOrderListData!.value = ListOrderListResponse();
    try {
      Response response = await Dio().get(
        'https://nafahat.com/wp-json/wc/v3/orders',
        queryParameters: {
          if (status != null) 'status': status,
          "customer": customerID,
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode! >= 200) {
        orderController.getOrderListData!.value =
            ListOrderListResponse.fromJson(response.data);
        log("getOrderList Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  cancelOrder({
    required String? orderID,
  }) async {
    try {
      final options =
          Options(headers: {"Content-Type": "application/json; charset=utf-8"});

      final data = {
        "status": "cancelled",
      };

      ProgressDialogUtils.show();

      final response = await Dio().put(
        "https://nafahat.com/wp-json/wc/v3/orders/$orderID",
        options: options,
        data: data,
      );

      if (response.statusCode == 200) {
        log('orderCancelled${response.data}');
        ProgressDialogUtils.hide();
        getOrderList(
          customerID: SPHelper.spHelper.getUserId(),
          status: 'processing',
        );
      } else {
        ProgressDialogUtils.hide();
        SVProgressHUD.showError(status: 'حدث خطأ');
      }
    } on DioError catch (err) {
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response!.data);
      log(err.response.toString());
    } catch (err) {
      ProgressDialogUtils.hide();
      log(err.toString());
    }
  }

  getPointList({String? customerID}) async {
    orderController.getPointsListData!.value = PointsResponse();
    try {
      Response response = await Dio().get(
        'https://nafahat.com/wp-json/loyalty-program/v1/customers/status/$customerID',
        queryParameters: {
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
        // options: Options(
        //   headers: {
        //     'Authorization': 'Bearer ${SPHelper.spHelper.getAdminToken()}',
        //   },
        // ),
      );
      if (response.statusCode! >= 200) {
        orderController.getPointsListData!.value =
            PointsResponse.fromJson(response.data);
        log("getPointList Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getCustomerPoints({String? customerID}) async {
    log("getUserId: $customerID");
    orderController.getCustomerPointsData!.value = CustomerPointResponse();
    try {
      Response response = await Dio().get(
        'https://nafahat.com/wp-json/wc-loyalty-program/v1/customers/points/$customerID',
        queryParameters: {
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
        // options: Options(
        //   headers: {
        //     'Authorization': 'Bearer ${SPHelper.spHelper.getAdminToken()}',
        //   },
        // ),
      );
      if (response.statusCode! >= 200) {
        orderController.getCustomerPointsData!.value =
            CustomerPointResponse.fromJson(response.data);
        log("getCustomerPoints Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  Future decreasePoints({
    String? point,
  }) async {
    ProgressDialogUtils.show();

    try {
      final data = {"type": "decrease", "points": point};
      Response response = await Dio().post(
        'https://nafahat.com/wp-json/wc-loyalty-program/v1/customers/points/${SPHelper.spHelper.getUserId()}',
        options: Options(
          headers: {
            // 'Authorization': 'Bearer ${SPHelper.spHelper.getAdminToken()}',
            "Content-Type": "application/json; charset=utf-8"
          },
        ),
        data: data,
      );
      if (response.statusCode! >= 200) {
        ProgressDialogUtils.hide();
        SVProgressHUD.showSuccess(status: 'تم خصم النقاط');
        getCustomerPoints(customerID: SPHelper.spHelper.getUserId());
        log("decreasePoints Successful ");
      } else {
        ProgressDialogUtils.hide();
        // SVProgressHUD.showError(status: 'ليس لديك نقاط كافية');
      }
    } catch (e) {
      // SVProgressHUD.showError(status: 'ليس لديك نقاط كافية');
      ProgressDialogUtils.hide();

      log(e.toString());
    }
  }

  Future checkCoupon({String? coupon}) async {
    ProgressDialogUtils.show();

    orderController.getCouponData!.value = CouponResponse();
    try {
      Response response = await Dio().get(
        'https://nafahat.com/wp-json/nafahatapi/v1/validcoupon?code=$coupon',
        // options: Options(
        //   headers: {
        //     'Authorization': 'Bearer ${SPHelper.spHelper.getAdminToken()}',
        //   },
        // ),
      );
      if (response.statusCode == 200) {
        ProgressDialogUtils.hide();

        orderController.getCouponData!.value =
            CouponResponse.fromJson(response.data);
        Helper.getSheetSucsses(
          '${'coupon_active_value'.tr}${response.data['amount']}${'sar_value'.tr}',
        );
      } else {
        ProgressDialogUtils.hide();
      }
    } on DioError catch (e) {
      ProgressDialogUtils.hide();

      Helper.getSheetError(e.response!.data['message'].toString());
    } catch (e) {
      ProgressDialogUtils.hide();

      Helper.getSheetError('Not Valid');
    }
  }

  getTheEstimateDeliveryTime() async {
    orderController.getDeliveryTimeData!.value = DeliveryTimeResponse();
    try {
      String token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmdhbml6YXRpb25faWQiOiI2MTU5ZDdlNGNmNTczZTBkYzc2NzQzNWMiLCJrZXkiOiIyMDIzLTAzLTI0VDIwOjIwOjE2LjgwM1oiLCJpYXQiOjE2Nzk2ODkyMTZ9.KpIjND0ReqYnMx-pBypVWnzIs1DYViqVuuHN51yO0Tc';

      Response response = await Dio().get(
        "https://app.redboxsa.com/api/business/v1/estimate-delivery-day",
        queryParameters: {"point_id": '5ff814063fa47933f7b28f45'},
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        orderController.getDeliveryTimeData!.value =
            DeliveryTimeResponse.fromJson(json.decode(response.data));

        log('getTheEstimateDeliveryTime${response.data}');
      } else {}
    } on DioError catch (err) {
      log(err.response.toString());
    } catch (err) {
      log(err.toString());
    }
  }

  Future<Response> sendSms({String? phone, String? pinCode}) async {
    log(phone.toString());
    ProgressDialogUtils.show();

    final options =
        Options(headers: {"Content-Type": "application/json; charset=utf-8"});

    try {
      final data = {
        "userName": "Kh500",
        "numbers": phone,
        "userSender": 'dermaroller',
        "apiKey": 'df8e159c310ec9f6d5226720801dedbb',
        "msg": "Your OTP is: $pinCode @Nafahat app #$pinCode"
      };
      Response response = await Dio().post(
        'https://www.msegat.com/gw/sendsms.php',
        options: options,
        data: data,
      );
      if (response.data['code'] == '1') {
        ProgressDialogUtils.hide();
        SVProgressHUD.showSuccess(
          status: 'تم إرسال رمز التحقق برسالة إلى رقم هاتفك المسجل بنجاح',
        );
        log("sendSms Successful ${response.data}");
      } else {
        ProgressDialogUtils.hide();
        SVProgressHUD.showError(status: 'الرجاء التحقق من الرقم المدخل');
      }
      return response;
    } catch (e) {
      SVProgressHUD.showError(status: 'حدث خطأ');
      ProgressDialogUtils.hide();
      log(e.toString());
      rethrow;
    }
  }
}
