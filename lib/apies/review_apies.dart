import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';

import '../const_urls.dart';
import '../controller/review_controller.dart';
import '../model/brand_response.dart';
import '../model/decode_token_response.dart';
import '../model/review_response.dart';
import '../services/Settingss.dart';
import '../services/helper.dart';
import '../services/progress_dialog_utils.dart';



class ReviewApies {
  ReviewApies._();

  static ReviewApies reviewApies = ReviewApies._();
  ReviewController reviewController = myGet.Get.find();


  getReviewData(String productId) async {
    reviewController.getReviewData!.value = ListReviewResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          reviewURL,
        queryParameters: {
          'endpoint': 'reviews',
          'product': productId
        }
      );
      if (response.statusCode == 200) {
        reviewController.getReviewData!.value = ListReviewResponse.fromJson(response.data);
        print("getReviewData Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }


  postComment({String? productId,String? userName,String? userEmail,String? reviewContent,int? rate}) async {
    try {
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        'product_id': productId,
        'reviewer': userName,
        'reviewer_email': userEmail,
        'review': reviewContent,
        'status': 'approved',
        'rating': rate,
      });
      Response response = await Settingss.settings.dio!.post(
          reviewURL,
        data: data,
        queryParameters: {
            "endpoint":"reviews",
            "create":"true"
        }
      );
      if (response.statusCode! >= 200) {
        getReviewData(productId!);
        ProgressDialogUtils.hide();
        Helper.getSheetSucsses('تم إضافة التقييم بنجاح');
        print("postComment Successful ");
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


}
