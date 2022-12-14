import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;

import '../const_urls.dart';
import '../controller/category_controller.dart';
import '../model/category_response.dart';
import '../model/sub_category_response.dart';
import '../services/Settingss.dart';



class CategoryApies {
  CategoryApies._();

  static CategoryApies categoryApies = CategoryApies._();
  CategoryController categoryController = myGet.Get.find();

  getCategoryData(String id) async {
    categoryController.getCategoryData!.value = ListCategoryResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        categoryURL,
        queryParameters: {'parent': id}
      );
      if (response.statusCode == 200) {
         categoryController.getCategoryData!.value = ListCategoryResponse.fromJson(response.data);
        print("getCategoryData Successful ${categoryController.getCategoryData!.value.listCategoryResponse![0].name}");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getSubCategoryData(String id) async {
    categoryController.getSubCategoryData!.value = ListSubCategoryResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        categoryURL,
        queryParameters: {'parent': id}
      );
      if (response.statusCode == 200) {
         categoryController.getSubCategoryData!.value = ListSubCategoryResponse.fromJson(response.data);
        print("getSubCategoryData Successful ${categoryController.getSubCategoryData!.value.listSupCategoryResponse![0].name}");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }


}
