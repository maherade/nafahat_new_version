

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:html/parser.dart';
import 'package:perfume_store_mobile_app/controller/app_controller.dart';

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
  AppController appController = myGet.Get.find();

  String decryptToken(token){
    final encodedPayload = token.split('.')[1];
    final payloadData =
    utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    print('payloadData' +payloadData.toString());
    final payload = DecodeTokenResponse.fromJson(jsonDecode(payloadData));
    print('id' +payload.data!.user!.id!.toString());

    return payload.data!.user!.id!;
  }
  Future getAdminToken() async {
    try {
      Response response = await Dio().post(
        'https://nafahat.com/wp-json/jwt-auth/v1/token',
        queryParameters: {
          "username":"mohammed",
          "password":"As0987654@",

        }
      );
      if (response.statusCode == 200 ) {
        print(response.data);
         SPHelper.spHelper.setAdminToken(response.data['token']);
          print("Admin Token"+SPHelper.spHelper.getAdminToken().toString());
      } else{
      }
    }on DioError catch(err){
    } catch (err) {
      print(err);
    }
  }


  login(String userName, String password) async {
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

      if (response.statusCode! >= 200 && response.data['token']!=null) {

        SPHelper.spHelper.setToken(response.data['token']);
        SPHelper.spHelper.setUserId(decryptToken(response.data['token']));

        getCustomerInformation(decryptToken(response.data['token']));
        Helper.getSheetSucsses('login_successful_value'.tr);
        myGet.Get.to(()=> NavBarScreen());
        ProgressDialogUtils.hide();
      } else{
        ProgressDialogUtils.hide();
        Helper.getSheetError('check_entered_data_value'.tr);
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

      if (response.statusCode! >= 200 && response.data['success'] == true) {
        print(response.data);
        Helper.getSheetSucsses('register_successful_value'.tr);

        login(email,password);
        ProgressDialogUtils.hide();
      } else{
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['data']['message']);
      }
    }on DioError catch(err){
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response!.data['data']['message']);
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

      if (response.statusCode! >= 200 && response.data['data']['status'] == 200) {
        print(response.data);
        appController.startTimer();
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

      if (response.statusCode! >= 200 && response.data['message']!='You must provide a code.') {
        print(response.data);

        Helper.getSheetSucsses(response.data['message']);
        myGet.Get.to(()=>ResetPasswordScreen(email:email , code:code));
        ProgressDialogUtils.hide();
      } else{
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    }on DioError catch(err){
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response!.data['data']['message']);
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

      if (response.statusCode! >= 200 && response.data['data']['message'] == 'You must provide a code.') {
        print(response.data);

        Helper.getSheetSucsses(response.data['message']);
        myGet.Get.offAll(()=>LoginScreen());
        ProgressDialogUtils.hide();
      } else{
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['data']['message']);
      }
    }on DioError catch(err){
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response?.data['data']['message']);
      print(err.response);

    } catch (err) {
      ProgressDialogUtils.hide();
      print(err);
    }
  }

  Future getCustomerInformation(String? customerId)async{

    authController.getCustomerInformationData!.value = ListViewAllInformationAboutCustomerResponse();
    try {
      Response response = await Dio().get(
          'https://nafahat.com/wp-json/nafahatapi/v1/userdata?user_id=$customerId',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getAdminToken()}',
          },
        ),
      );
      if (response.statusCode! >= 200) {
        authController.getCustomerInformationData!.value = ListViewAllInformationAboutCustomerResponse.fromJson(response.data);
        print('getCustomerInformation Successful');

      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  updateCustomerProfile({String? user_id, String? user_email, String? user_fullname, String? user_password, String? user_address, String? user_lang}) async {
    try {
      ProgressDialogUtils.show();

      Response response = await Dio().post(
          'https://nafahat.com/wp-json/nafahatapi/v1/user-update',
          queryParameters: {
            "user_id" : user_id,
            "user_email" : user_email,
            "user_fullname" : user_fullname,
            "user_password" : user_password,
            "user_address" : user_address,
            "user_lang" : user_lang
          },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getAdminToken()}',
          },
        ),
      );

      if (response.statusCode! >= 200 ) {
        print(response.data);
        getCustomerInformation(user_id);
        Helper.getSheetSucsses(response.data['message']);
        ProgressDialogUtils.hide();
      } else{
        ProgressDialogUtils.hide();
        Helper.getSheetError('حدث خطأ');
      }
    }on DioError catch(err){
      ProgressDialogUtils.hide();
      Helper.getSheetError('حدث خطأ');
      print(err.response);

    } catch (err) {
      ProgressDialogUtils.hide();
      print(err);
    }
  }


}
