import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';

import '../const_urls.dart';
import '../model/brand_response.dart';
import '../services/Settingss.dart';



class BrandApies {
  BrandApies._();

  static BrandApies brandApies = BrandApies._();
  BrandController brandController = myGet.Get.find();

  getBrandData() async {
    brandController.getBrandData!.value = ListBrandResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          brandURL,
      );
      if (response.statusCode == 200) {
        brandController.getBrandData!.value = ListBrandResponse.fromJson(response.data);
        print("getBrandData Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }


}
