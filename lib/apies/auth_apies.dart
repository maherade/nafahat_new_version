import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as myGet;
import 'package:perfume_store_mobile_app/controller/app_controller.dart';

import '../const_urls.dart';
import '../controller/auth_controller.dart';
import '../model/decode_token_response.dart';
import '../model/view_all_information_about_customer_response.dart';
import '../services/Settingss.dart';
import '../services/helper.dart';
import '../services/progress_dialog_utils.dart';
import '../services/sp_helper.dart';
import '../view/auth/screens/login_screen.dart';
import '../view/auth/screens/reset_password_screen.dart';
import '../view/auth/screens/verification_code_screen.dart';
import '../view/bottom_nav_screens/screens/nav_bar_screen.dart';

class AuthApis {
  AuthApis._();

  static AuthApis authApis = AuthApis._();
  AuthController authController = myGet.Get.find();
  AppController appController = myGet.Get.find();

  String decryptToken(token) {
    final encodedPayload = token.split('.')[1];
    final payloadData =
        utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    debugPrint('payloadData$payloadData');
    final payload = DecodeTokenResponse.fromJson(jsonDecode(payloadData));
    debugPrint('id${payload.data!.user!.id!}');

    return payload.data!.user!.id!;
  }

  // Future getAdminToken() async {
  //   try {
  //     Response response = await Dio().post(
  //       'https://nafahat.com/wp-json/jwt-auth/v1/token',
  //       queryParameters: {
  //         "username": "mohammed",
  //         "password": "As0987654@",
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       debugPrint(response.data);
  //       SPHelper.spHelper.setAdminToken(response.data['token']);
  //       debugPrint("Admin Token${SPHelper.spHelper.getAdminToken()}");
  //     } else {}
  //   } catch (err) {
  //     debugPrint(err);
  //   }
  // }

  login(String userName, String password) async {
    try {
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        "username": userName,
        "password": password,
      });
      Response response = await Dio().post(
        'https://nafahat.com/wp-content/plugins/nafahat/rest/v1/api-request.php?endpoint=login',
        data: data,
      );

      log("response.data['token']${response.data} $response");

      if (response.statusCode! >= 200 && response.data['token'] != null) {
        SPHelper.spHelper.setToken(response.data['token']);
        SPHelper.spHelper.setUserId(decryptToken(response.data['token']));

        getCustomerInformation(decryptToken(response.data['token']));
        Helper.getSheetSucsses('login_successful_value'.tr);
        myGet.Get.to(() => const NavBarScreen());
        ProgressDialogUtils.hide();
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError('check_entered_data_value'.tr);
      }
    } on DioError catch (err) {
      ProgressDialogUtils.hide();
      Helper.getSheetError('an error ${err.response}');
      debugPrint(err.response.toString());
      log("error from DioError catch login $err");
    } catch (err) {
      ProgressDialogUtils.hide();
      log("error from catch login $err");
      debugPrint(err.toString());
    }
  }

  register(String userName, String email, String password) async {
    try {
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap(
        {"username": userName, "email": email, "password": password},
      );
      Response response =
          await Settingss.settings.dio!.post(registerURL, data: data);

      if (response.statusCode! >= 200 && response.data['success'] == true) {
        debugPrint(response.data);
        Helper.getSheetSucsses('register_successful_value'.tr);

        login(email, password);
        ProgressDialogUtils.hide();
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['data']['message']);
      }
    } on DioError catch (err) {
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response!.data['data']['message']);
      debugPrint(err.response.toString());
    } catch (err) {
      ProgressDialogUtils.hide();
      debugPrint(err.toString());
    }
  }

  resetPassword({String? email}) async {
    try {
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        "email": email,
      });
      Response response = await Dio().post(
        'https://nafahat.com/wp-content/plugins/nafahat/rest/v1/api-request.php?endpoint=reset-password',
        data: data,
        options: Options(headers: {}),
      );

      if (response.statusCode! >= 200 &&
          response.data['data']['status'] == 200) {
        debugPrint(response.data);
        appController.startTimer();
        Helper.getSheetSucsses(response.data['message']);
        myGet.Get.to(() => const VerificationCodeScreen());
        ProgressDialogUtils.hide();
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    } on DioError catch (err) {
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response!.data['message']);
      debugPrint(err.response.toString());
    } catch (err) {
      ProgressDialogUtils.hide();
      debugPrint(err.toString());
    }
  }

  validateCode({String? email, String? code}) async {
    try {
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        "email": email,
        "code": code,
      });
      Response response = await Dio().post(
        'https://nafahat.com/wp-content/plugins/nafahat/rest/v1/api-request.php?endpoint=validate-code',
        data: data,
        options: Options(headers: {}),
      );

      if (response.statusCode! >= 200 &&
          response.data['message'] != 'You must provide a code.') {
        debugPrint(response.data);

        Helper.getSheetSucsses(response.data['message']);
        myGet.Get.to(() => ResetPasswordScreen(email: email, code: code));
        ProgressDialogUtils.hide();
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    } on DioError catch (err) {
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response!.data['data']['message']);
      debugPrint(err.response.toString());
    } catch (err) {
      ProgressDialogUtils.hide();
      debugPrint(err.toString());
    }
  }

  setPassword({String? email, String? password, String? code}) async {
    try {
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        "email": email,
        "password": password,
        "code": code,
      });
      Response response = await Dio().post(
        'https://nafahat.com/wp-content/plugins/nafahat/rest/v1/api-request.php?endpoint=set-password',
        data: data,
        options: Options(headers: {}),
      );

      if (response.statusCode! >= 200 &&
          response.data['data']['message'] == 'You must provide a code.') {
        debugPrint(response.data);

        Helper.getSheetSucsses(response.data['message']);
        myGet.Get.offAll(() => const LoginScreen());
        ProgressDialogUtils.hide();
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['data']['message']);
      }
    } on DioError catch (err) {
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response?.data['data']['message']);
      debugPrint(err.response.toString());
    } catch (err) {
      ProgressDialogUtils.hide();
      debugPrint(err.toString());
    }
  }

  Future getCustomerInformation(String? customerId) async {
    authController.getCustomerInformationData!.value =
        ListViewAllInformationAboutCustomerResponse();
    try {
      Response response = await Dio().get(
        'https://nafahat.com/wp-content/plugins/nafahat/rest/v1/api-request.php',
        queryParameters: {
          "endpoint": "customers",
          "id": customerId,
        },
        // options: Options(
        //   headers: {
        //     'Authorization': 'Bearer ${SPHelper.spHelper.getAdminToken()}',
        //   },
        // ),
      );
      if (response.statusCode! >= 200) {
        authController.getCustomerInformationData!.value =
            ListViewAllInformationAboutCustomerResponse.fromJson(response.data);
        debugPrint('getCustomerInformation Successful');
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  updateCustomerProfile({
    String? user_id,
    String? user_email,
    String? user_fullname,
    String? user_password,
    String? user_address,
    String? user_lang,
  }) async {
    try {
      ProgressDialogUtils.show();

      Response response = await Dio().post(
        'https://nafahat.com/wp-json/nafahatapi/v1/user-update',
        queryParameters: {
          "user_id": user_id,
          "user_email": user_email,
          "user_fullname": user_fullname,
          "user_password": user_password,
          "user_address": user_address,
          "user_lang": user_lang,
        },
        // options: Options(
        //   headers: {
        //     'Authorization': 'Bearer ${SPHelper.spHelper.getAdminToken()}',
        //   },
        // ),
      );

      if (response.statusCode! >= 200) {
        debugPrint(response.data);
        getCustomerInformation(user_id);
        Helper.getSheetSucsses(response.data['message']);
        ProgressDialogUtils.hide();
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError('حدث خطأ');
      }
    } on DioError catch (err) {
      ProgressDialogUtils.hide();
      Helper.getSheetError('حدث خطأ');
      debugPrint(err.response.toString());
    } catch (err) {
      ProgressDialogUtils.hide();
      debugPrint(err.toString());
    }
  }
}
