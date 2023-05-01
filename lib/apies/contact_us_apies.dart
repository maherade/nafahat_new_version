import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';

import '../const_urls.dart';
import '../controller/contact_us_controller.dart';
import '../controller/review_controller.dart';
import '../model/brand_response.dart';
import '../model/common_question_response.dart';
import '../model/decode_token_response.dart';
import '../model/review_response.dart';
import '../services/Settingss.dart';
import '../services/helper.dart';
import '../services/progress_dialog_utils.dart';
import '../services/sp_helper.dart';



class ContactUsApies {
  ContactUsApies._();

  static ContactUsApies contactUsApies = ContactUsApies._();
  ContactUsController contactUsController = myGet.Get.find();


  getCommonQuestionData() async {
    contactUsController.getCommonQuestionData!.value = CommonQuestionResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          'api-request.php',
          queryParameters: {
            'endpoint': 'page',
            'lang' : SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'

          }
      );
      if (response.statusCode == 200) {
        contactUsController.getCommonQuestionData!.value = CommonQuestionResponse.fromJson(response.data);
        print("getCommonQuestionData Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }


  contactUs({String? email, String? notes}) async {
    try {
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        'your-email': email,
        'notes': notes,
      });
      Response response = await Settingss.settings.dio!.post(
          reviewURL,
          data: data,
          queryParameters: {
            "endpoint":"forms",
            "contact":"true",
            'lang' : SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'

          }
      );
      if (response.statusCode! >= 200) {
        ProgressDialogUtils.hide();
        Helper.getSheetSucsses(response.data['message']);
        print("postComment Successful ");
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError('check_entered_data_value'.tr);
      }
    } catch (e) {
      ProgressDialogUtils.hide();
      Helper.getSheetError('check_entered_data_value'.tr);
      print(e.toString());
    }
  }


}
