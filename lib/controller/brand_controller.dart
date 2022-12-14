

import 'package:get/get.dart';

import '../model/brand_response.dart';


class BrandController extends GetxController{
  Rx<ListBrandResponse>? getBrandData = ListBrandResponse().obs;
}