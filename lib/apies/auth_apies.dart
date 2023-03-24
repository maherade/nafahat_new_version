

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:html/parser.dart';

import '../const_urls.dart';
import '../controller/auth_controller.dart';
import '../model/decode_token_response.dart';
import '../model/user_response.dart';
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

  String decryptToken(token){
    final encodedPayload = token.split('.')[1];
    final payloadData =
    utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    print('payloadData' +payloadData.toString());
    final payload = DecodeTokenResponse.fromJson(jsonDecode(payloadData));
    print('id' +payload.data!.user!.id!.toString());

    return payload.data!.user!.id!;
  }

  login(String userName, String password) async {
    authController.getUserData!.value = UserResponse();
    try {
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        "username" : userName,
        "password" : password
      });
      Response response = await Dio().post(
        'https://nafahat.com/wp-content/plugins/nafahat/rest/v1/api-request.php?endpoint=login',
        data: data,

      );

      if (response.statusCode == 200 && response.data['token']!=null) {
        authController.getUserData!.value = UserResponse.fromJson(response.data);

        SPHelper.spHelper.setToken(response.data['token']);

        getCustomerInformation(decryptToken(response.data['token']));
        Helper.getSheetSucsses('تم تسجيل الدخول بنجاح');
        myGet.Get.to(()=> NavBarScreen());
        ProgressDialogUtils.hide();
      } else{
        ProgressDialogUtils.hide();
        Helper.getSheetError('يرجى التأكد من المعلومات المدخلة');
      }
    }on DioError catch(err){
      ProgressDialogUtils.hide();
      Helper.getSheetError('an error ${err.response}');
      print(err.response);

    } catch (err) {
      ProgressDialogUtils.hide();
      print(err);
    }
  }

  register(String userName, String email , String password) async {
    try {
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        "username" : userName,
        "email" : email,
        "password" : password
      });
      Response response = await Settingss.settings.dio!.post(
          registerURL,
        data: data
      );

      if (response.statusCode == 201) {
        myGet.Get.to(()=> LoginScreen());
        Helper.getSheetSucsses('تم التسجيل بنجاح');
        ProgressDialogUtils.hide();
      } else{
        ProgressDialogUtils.hide();
      }
    }on DioError catch(err){
      ProgressDialogUtils.hide();
      Helper.getSheetError(parse(err.response!.data['message']).documentElement!.text);
      print(err.response);

    } catch (err) {
      ProgressDialogUtils.hide();
      print(err);
    }
  }

  resetPassword({String? email}) async{
    try {
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        "email" : email,

      });
      Response response = await Dio().post(
          'https://nafahat.com/wp-content/plugins/nafahat/rest/v1/api-request.php?endpoint=reset-password',
         data: data,
          options: Options(
              headers: {}
          )
      );

      if (response.statusCode == 200) {
        Helper.getSheetSucsses(response.data['message']);
        myGet.Get.to(()=> const  VerificationCodeScreen());
        ProgressDialogUtils.hide();
      } else{
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    }on DioError catch(err){
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response!.data['message']);
      print(err.response);

    } catch (err) {
      ProgressDialogUtils.hide();
      print(err);
    }
  }

  validateCode({String? email , String? code}) async{
    try {
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        "email" : email,
        "code" : code,
      });
      Response response = await Dio().post(
          'https://nafahat.com/wp-content/plugins/nafahat/rest/v1/api-request.php?endpoint=validate-code',
         data: data,
          options: Options(
              headers: {}
          )
      );

      if (response.statusCode == 200) {
        Helper.getSheetSucsses(response.data['message']);
        myGet.Get.to(()=>ResetPasswordScreen(email:email , code:code));
        ProgressDialogUtils.hide();
      } else{
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    }on DioError catch(err){
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response!.data['message']);
      print(err.response);

    } catch (err) {
      ProgressDialogUtils.hide();
      print(err);
    }
  }

  setPassword({String? email ,String? password , String? code}) async{
    try {
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        "email" : email,
        "password" : password,
        "code" : code,
      });
      Response response = await Dio().post(
          'https://nafahat.com/wp-content/plugins/nafahat/rest/v1/api-request.php?endpoint=set-password',
         data: data,
          options: Options(
              headers: {}
          )
      );

      if (response.statusCode == 200) {
        Helper.getSheetSucsses(response.data['message']);
        myGet.Get.offAll(()=>LoginScreen());
        ProgressDialogUtils.hide();
      } else{
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    }on DioError catch(err){
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response!.data['message']);
      print(err.response);

    } catch (err) {
      ProgressDialogUtils.hide();
      print(err);
    }
  }

  getCustomerInformation(String customerId)async{
    authController.getCustomerInformationData!.value = ViewAllInformationAboutCustomerResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          'api-request.php?endpoint=customers&id=$customerId',
      );
      if (response.statusCode == 200) {
        authController.getCustomerInformationData!.value = ViewAllInformationAboutCustomerResponse.fromJson(response.data);
        print('getCustomerInformation Successful'+authController.getCustomerInformationData!.value.data!.id.toString());

      } else {}
    } catch (e) {
      print(e.toString());
    }
  }



}
