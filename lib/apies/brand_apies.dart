import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';

import '../const_urls.dart';
import '../model/brand_by_id_response.dart';
import '../model/brand_response.dart';
import '../services/Settingss.dart';
import '../services/sp_helper.dart';



class BrandApies {
  BrandApies._();

  static BrandApies brandApies = BrandApies._();
  BrandController brandController = myGet.Get.find();

  getBrandData({String? search,String? categoryID}) async {
    print(" Admin Token "+SPHelper.spHelper.getAdminToken().toString());
    brandController.getBrandData!.value = ListBrandResponse();
    try {
      Response response = await Dio().get(
          'https://nafahat.com/wp-content/plugins/nafahat/rest/v1/api-request.php',
        queryParameters: {
            "endpoint":"brands",
            "search": search ??'',
            "orderasc":"name",
            "cat_id": categoryID ?? '',
          'lang' : SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'

        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getAdminToken()}',
          },
        ),
      );
      if (response.statusCode == 200) {

         brandController.getBrandData!.value = ListBrandResponse.fromJson(response.data);

        print("getBrandData Successful ");

      } else {}
    } catch (e) {
      print(e.toString());
    }
  }
  getBrandById({String? brandID}) async {

    brandController.getBrandByIdData!.value = BrandByIdResponse();
    try {
      Response response = await Dio().get(
          'https://nafahat.com/wp-json/wc/v3/brands/${brandID??''}',
        queryParameters: {
          'lang' : SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        }
      );
      if (response.statusCode == 200) {
        brandController.getBrandByIdData!.value = BrandByIdResponse.fromJson(response.data);
        print("getBrandByIdData Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }


}
