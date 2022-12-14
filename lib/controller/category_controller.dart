

import 'package:get/get.dart';

import '../model/category_response.dart';
import '../model/sub_category_response.dart';

class CategoryController extends GetxController{
   Rx<ListCategoryResponse>? getCategoryData = ListCategoryResponse().obs;
   Rx<ListSubCategoryResponse>? getSubCategoryData = ListSubCategoryResponse().obs;
}