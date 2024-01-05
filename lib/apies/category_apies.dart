import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;

import '../const_urls.dart';
import '../controller/category_controller.dart';
import '../model/category_response.dart';
import '../model/sub_category_response.dart';
import '../services/Settingss.dart';
import '../services/sp_helper.dart';

class CategoryApies {
  CategoryApies._();

  static CategoryApies categoryApies = CategoryApies._();
  CategoryController categoryController = myGet.Get.find();

  getCategoryData(String id) async {
    // String? token = SPHelper.spHelper.getToken();

    categoryController.getCategoryData!.value = ListCategoryResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        categoryURL,
        queryParameters: {
          'endpoint': 'product-category',
          'parent': id,
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        log("getCategoryData Successful ");

        categoryController.getCategoryData!.value =
            ListCategoryResponse.fromJson(response.data);
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getSubCategoryData(String id) async {
    categoryController.getSubCategoryData!.value = ListSubCategoryResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        categoryURL,
        queryParameters: {
          'endpoint': 'product-category',
          'parent': id,
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        categoryController.getSubCategoryData!.value =
            ListSubCategoryResponse.fromJson(response.data);
        log("getSubCategoryData Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }
}
