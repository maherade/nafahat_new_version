import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';
import 'package:perfume_store_mobile_app/model/recently_added_product_response.dart';

import '../const_urls.dart';
import '../controller/product_controller.dart';
import '../model/ads_response.dart';
import '../model/care_product_response.dart';
import '../model/famous_brand_response.dart';
import '../model/famous_product_response.dart';
import '../model/filtered_product_response.dart';
import '../model/gift_package_product_response.dart';
import '../model/last_viewed_product_response.dart';
import '../model/less_than_price_product_response.dart';
import '../model/list_product_by_brand_response.dart';
import '../model/makup_product_response.dart';
import '../model/product_by_category_response.dart';
import '../model/product_detail_response.dart';
import '../model/product_response.dart';
import '../model/search_product_response.dart';
import '../model/sub_category_product.dart';
import '../model/whole_sale_response.dart';
import '../services/Settingss.dart';
import '../services/helper.dart';
import '../services/progress_dialog_utils.dart';
import '../services/sp_helper.dart';

class ProductApies {
  ProductApies._();

  static ProductApies productApies = ProductApies._();
  ProductController productController = myGet.Get.find();

  getFamousProductData({String? category, bool? onSale}) async {
    String? token = SPHelper.spHelper.getToken();

    productController.getFamousProductData!.value = ListFamousProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {
          "endpoint": "products",
          "category": category,
          // "on_sale" : onSale
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        productController.getFamousProductData!.value =
            ListFamousProductResponse.fromJson(response.data);
        print("getFamousProductData Successful ${response.headers}");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getProductData(
      {String? pageNumber,
      String? category,
      String? order,
      String? orderBy}) async {
    String? token = SPHelper.spHelper.getToken();

    productController.getProductData!.value = ListProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
                "endpoint": "products",
                "category": category,
                "per_page": '8',
                "page": pageNumber,
              }
            : {
                "endpoint": "products",
                "category": category,
                "per_page": '8',
                "page": pageNumber,
                "order": order,
                "orderby": orderBy,
              },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        productController.getProductData!.value =
            ListProductResponse.fromJson(response.data);
        // productController.getProductData!.value.totalPage = response.headers['X-WP-TotalPages']![0];
        print("getProductData Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getGiftPackageProductData(
      {required bool? feature,
      required String? pageNumber,
      String? order,
      String? orderBy}) async {
    String? token = SPHelper.spHelper.getToken();

    productController.getGiftPackageProductData!.value =
        ListGiftPackageProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
                "endpoint": "products",
                "category": '183',
                "per_page": '8',
                "page": pageNumber,
              }
            : {
                "endpoint": "products",
                "category": '183',
                "per_page": '8',
                "page": pageNumber,
                "order": order,
                "orderby": orderBy,
              },

      );
      if (response.statusCode == 200) {
        productController.getGiftPackageProductData!.value =
            ListGiftPackageProductResponse.fromJson(response.data);
        // productController.getGiftPackageProductData!.value.totalPage = response.headers['X-WP-TotalPages']![0];
        print("getGiftPackageProductData Successful");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getWholeSaleProductData({bool? onSale}) async {
    String? token = SPHelper.spHelper.getToken();
    productController.getListWholeSaleResponseData!.value =
        ListWholeSaleResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {"endpoint": "products", "category": '183'},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        productController.getListWholeSaleResponseData!.value =
            ListWholeSaleResponse.fromJson(response.data);
        print("getWholeSaleProductData Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getOffersProductData() async {

    productController.getListOffersProductResponseData!.value =
        ListOffersProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {
            "endpoint": "products",
            "per_page": '30',
            "page": '1',
            "on_sale": true
          });
      if (response.statusCode == 200) {
        productController.getListOffersProductResponseData!.value =
            ListOffersProductResponse.fromJson(response.data);
        print(
            "getOffersProductData Successful  ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getLessThanPriceProductResponseData(
      {required String? lessThan,
      required String? pageNumber,
      String? order,
      String? orderBy}) async {
    String? token = SPHelper.spHelper.getToken();

    productController.getListLessThanPriceProductResponseData!.value =
        ListLessThanPriceProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
                "endpoint": "products",
                "max_price": lessThan,
                "per_page": '8',
                "page": pageNumber,
              }
            : {
                "endpoint": "products",
                "max_price": lessThan,
                "per_page": '8',
                "page": pageNumber,
                "order": order,
                "orderby": orderBy,
              },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        productController.getListLessThanPriceProductResponseData!.value =
            ListLessThanPriceProductResponse.fromJson(response.data);
        // productController.getListLessThanPriceProductResponseData!.value.totalPage = response.headers['X-WP-TotalPages']![0];
        print("getLessThanPriceProductResponseData Successful");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getProductDetailData(String id) async {
    productController.getProductDetailResponseData!.value =
        ProductDetailResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {
          "endpoint": "products",
          "product_id": id,
        },

        // options: Options(validateStatus: (status) {
        //   return status! < 500;
        // },)
      );
      if (response.statusCode == 200) {
        productController.getProductDetailResponseData!.value =
            ProductDetailResponse.fromJson(response.data);
        print("getProductDetailData Successful ");
      } else {}
    } on DioError catch (e) {
      print(e.response.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  getProductByCategory(
      {String? pageNumber,
      String? category,
      String? order,
      String? orderBy,
      String? onSale,
      }) async {
    String? token = SPHelper.spHelper.getToken();

    productController.getProductByCategoryData!.value =
        ListProductByCategoryResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
                "endpoint": "products",
                "category": category,
                "per_page": '8',
                "page": pageNumber,
                "on_sale": onSale?? false,
              }
            : {
                "endpoint": "products",
                "category": category,
                "per_page": '8',
                "page": pageNumber,
                "order": order,
                "orderby": orderBy,
          "on_sale": onSale?? false,

        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        productController.getProductByCategoryData!.value =
            ListProductByCategoryResponse.fromJson(response.data);
        // productController.getProductByCategoryData!.value.totalPage = response.headers['X-WP-TotalPages']![0];
        print("getProductByCategory Successful }");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getProductByBrand(
      {String? pageNumber,
      String? brand,
      String? order,
      String? orderBy}) async {
    String? token = SPHelper.spHelper.getToken();

    productController.getProductByBrandData!.value =
        ListProductByBrandResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
                "endpoint": "products",
                "brand": brand,
                "per_page": '8',
                "page": pageNumber,
              }
            : {
                "endpoint": "products",
                "brand": brand,
                "per_page": '8',
                "page": pageNumber,
                "order": order,
                "orderby": orderBy,
              },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        productController.getProductByBrandData!.value =
            ListProductByBrandResponse.fromJson(response.data);
        // productController.getProductByCategoryData!.value.totalPage = response.headers['X-WP-TotalPages']![0];
        print("getProductByBrand Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getProductByFilter(
      {String? pageNumber,
      String? category,
      String? brand,
      String? minPrice,
      String? maxPrice,
      String? order,
      String? orderBy}) async {
    String? token = SPHelper.spHelper.getToken();

    productController.getFilteredProductData!.value =
        ListFilteredProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
                "endpoint": "products",
                "category": category,
          "brand": brand,
          "per_page": '8',
                "page": pageNumber,
                "min_price": minPrice,
                "max_price": maxPrice,
              }
            : {
                "endpoint": "products",
                "category": category,
          "brand": brand,

          "per_page": '8',
                "page": pageNumber,
                "min_price": minPrice,
                "max_price": maxPrice,
                "order": order,
                "orderby": orderBy,
              },

      );
      if (response.statusCode == 200) {
        productController.getFilteredProductData!.value =
            ListFilteredProductResponse.fromJson(response.data);
        // productController.getFilteredProductData!.value.totalPage = response.headers['X-WP-TotalPages']![0];
        print("getProductByCategory Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getLastViewProduct(
      {String? category,
      String? brand,
      String? maxPrice,
      bool? featured}) async {
    String? token = SPHelper.spHelper.getToken();

    productController.getLastViewedProduct!.value =
        ListLastViewedProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {
          "endpoint": "products",
          "category": category,
          "brand": brand,
          "per_page": '2',
          "page": '1',
          "order": 'asc',
          "orderby": 'date',
          "max_price": maxPrice,
          "featured": featured ?? false
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        productController.getLastViewedProduct!.value =
            ListLastViewedProductResponse.fromJson(response.data);

        print("getLastViewProduct Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  sendWholeSaleRequest(
      {String? clientName,
      String? companyName,
      String? companyAddress,
      String? email,
      String? phone,}) async {
    try {
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        'client-name': clientName,
        'company-name': companyName,
        'company-adress': companyAddress,
        'client-email': email,
        'phone-number': phone,
      });
      Response response = await Settingss.settings.dio!.post('api-request.php',
          data: data,
          queryParameters: {"endpoint": "forms", "whosale": "true"});
      if (response.statusCode! >= 200) {
        ProgressDialogUtils.hide();
        Helper.getSheetSucsses(response.data['message']);
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


  getAds(
      {String? category,
        String? brand,
        String? maxPrice,
        bool? featured}) async {

    productController.getAdsData!.value =
        ListAdsResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        'api-request.php',
        queryParameters: {
          "endpoint": "banners",
        },
      );
      if (response.statusCode == 200) {
        productController.getAdsData!.value =
            ListAdsResponse.fromJson(response.data);

        print("getAds Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getCareProductData({String? category,
    required String? pageNumber,
    String? order,
    String? orderBy}) async {

    productController.getCareProductDataData!.value = ListCareProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
          "endpoint": "products",
          "category": '25',
          "per_page": '8',
          "page": pageNumber,
        }
            : {
          "endpoint": "products",
          "category": '25',
          "per_page": '8',
          "page": pageNumber,
          "order": order,
          "orderby": orderBy,
        },

        );

      if (response.statusCode == 200) {
        productController.getCareProductDataData!.value =
        ListCareProductResponse.fromJson(response.data);
        print("getCareProductData Successful");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getRecentlyAddedProductData(
      {
        required String? pageNumber,
       }) async {

    productController.getRecentlyAddedProductDataData!.value =
        ListRecentlyAddedProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {
          "endpoint": "products",
          "per_page": '8',
          "page": pageNumber,
          "order": 'desc',
          "orderby": 'date',
        }

      );
      if (response.statusCode == 200) {
        productController.getRecentlyAddedProductDataData!.value =
            ListRecentlyAddedProductResponse.fromJson(response.data);
        print("getRecentlyAddedProductData Successful");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  searchProduct(
      {String? pageNumber,
        String? category,
        String? word,
        String? order,
        String? orderBy,
        String? onSale,
      }) async {
    String? token = SPHelper.spHelper.getToken();

    productController.getSearchProductDataData!.value =
        ListSearchProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
          "endpoint": "products",
          "search": word,
          "category": category,
          "per_page": '8',
          "page": pageNumber,
        }
            : {
          "endpoint": "products",
          "category": category,
          "per_page": '8',
          "page": pageNumber,
          "order": order,
          "orderby": orderBy,
        },

      );
      if (response.statusCode == 200) {
        productController.getSearchProductDataData!.value =
            ListSearchProductResponse.fromJson(response.data);
        print("searchProduct Successful }");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }


  getFamousBrandAds() async {
    productController.getFamousBrandAdsData!.value =
        ListFamousBrandResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        'api-request.php',
        queryParameters: {
          "endpoint": "brands-feature",
        },
      );
      if (response.statusCode == 200) {
        productController.getFamousBrandAdsData!.value =
            ListFamousBrandResponse.fromJson(response.data);
        print("getFamousBrandAds Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }
}
