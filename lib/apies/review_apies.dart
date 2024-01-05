import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as myGet;

import '../const_urls.dart';
import '../controller/review_controller.dart';
import '../model/review_response.dart';
import '../services/Settingss.dart';
import '../services/helper.dart';
import '../services/progress_dialog_utils.dart';
import '../services/sp_helper.dart';

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
          'product': productId,
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        reviewController.getReviewData!.value =
            ListReviewResponse.fromJson(response.data);
        debugPrint("getReviewData Successful ");
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  postComment({
    String? productId,
    String? userName,
    String? userEmail,
    String? reviewContent,
    int? rate,
  }) async {
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
          "endpoint": "reviews",
          "create": "true",
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode! >= 200) {
        getReviewData(productId!);
        ProgressDialogUtils.hide();
        Helper.getSheetSucsses('rate_add_successful_value'.tr);
        debugPrint("postComment Successful ");
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError('check_entered_data_value'.tr);
      }
    } catch (e) {
      ProgressDialogUtils.hide();
      Helper.getSheetError('check_entered_data_value'.tr);
      debugPrint(e.toString());
    }
  }
}
