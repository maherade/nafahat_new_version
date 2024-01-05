import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:perfume_store_mobile_app/model/recently_added_product_response.dart';

import '../const_urls.dart';
import '../controller/product_controller.dart';
import '../model/ads_response.dart';
import '../model/care_product_response.dart' as care_product_response;
import '../model/famous_brand_response.dart';
import '../model/famous_product_response.dart';
import '../model/filtered_product_response.dart' as filtered_product_response;
import '../model/gift_package_product_response.dart' as gift_product_response;
import '../model/last_viewed_product_response.dart';
import '../model/lenses_response.dart';
import '../model/less_than_price_product_response.dart'
    as less_than_price_product_response;
import '../model/list_product_by_brand_response.dart'
    as product_by_brand_response;
import '../model/makup_product_response.dart';
import '../model/product_by_category_response.dart'
    as product_by_category_response;
import '../model/product_detail_response.dart';
import '../model/product_response.dart' as product_response;
import '../model/ramadan_offers_response.dart';
import '../model/ramadan_product_response.dart';
import '../model/related_product_model.dart';
import '../model/search_product_response.dart' as search_product_response;
import '../model/top_devices_product_response.dart';
import '../model/top_makup_product_response.dart';
import '../model/top_nails_product_response.dart';
import '../model/top_perfume_product_response.dart';
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
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'

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
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  List<product_response.Data>? listProduct;

  getProductData({
    String? pageNumber,
    String? category,
    String? order,
    String? orderBy,
  }) async {
    String? token = SPHelper.spHelper.getToken();

    productController.getProductData!.value =
        product_response.ListProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
                "endpoint": "products",
                "category": category,
                "per_page": '56',
                "page": pageNumber,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              }
            : {
                "endpoint": "products",
                "category": category,
                "per_page": '56',
                "page": pageNumber,
                "order": order,
                "orderby": orderBy,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        listProduct == null ? listProduct = [] : log('');
        productController.getProductData!.value =
            product_response.ListProductResponse.fromJson(response.data);

        for (var element in productController.getProductData!.value.data!) {
          listProduct?.add(element);
        }
        // productController.getProductData!.value.totalPage = response.headers['X-WP-TotalPages']![0];
        log("getProductData Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  List<gift_product_response.Data>? listGiftProduct;

  getGiftPackageProductData({
    required String? pageNumber,
    String? order,
    String? orderBy,
  }) async {
    // String? token = SPHelper.spHelper.getToken();

    productController.getGiftPackageProductData!.value =
        gift_product_response.ListGiftPackageProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
                "endpoint": "products",
                "category": '2467',
                "per_page": '56',
                "page": pageNumber,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              }
            : {
                "endpoint": "products",
                "category": '2467',
                "per_page": '56',
                "page": pageNumber,
                "order": order,
                "orderby": orderBy,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              },
      );
      if (response.statusCode == 200) {
        listGiftProduct == null ? listGiftProduct = [] : log('');
        productController.getGiftPackageProductData!.value =
            gift_product_response.ListGiftPackageProductResponse.fromJson(
          response.data,
        );

        for (var element
            in productController.getGiftPackageProductData!.value.data!) {
          listGiftProduct?.add(element);
        }
        // productController.getGiftPackageProductData!.value.totalPage = response.headers['X-WP-TotalPages']![0];
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getWholeSaleProductData({bool? onSale}) async {
    String? token = SPHelper.spHelper.getToken();
    productController.getListWholeSaleResponseData!.value =
        ListWholeSaleResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {
          "endpoint": "products",
          "category": '2467',
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        productController.getListWholeSaleResponseData!.value =
            ListWholeSaleResponse.fromJson(response.data);
        log("getWholeSaleProductData Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
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
          "per_page": '56',
          "page": '1',
          "on_sale": true,
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        productController.getListOffersProductResponseData!.value =
            ListOffersProductResponse.fromJson(response.data);
        log("getOffersProductData Successful  ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  List<less_than_price_product_response.Data>? listLessThanPriceProduct;

  getLessThanPriceProductResponseData({
    required String? lessThan,
    required String? pageNumber,
    String? order,
    String? orderBy,
  }) async {
    String? token = SPHelper.spHelper.getToken();

    productController.getListLessThanPriceProductResponseData!.value =
        less_than_price_product_response.ListLessThanPriceProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
                "endpoint": "products",
                "max_price": lessThan,
                "per_page": '56',
                "page": pageNumber,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              }
            : {
                "endpoint": "products",
                "max_price": lessThan,
                "per_page": '56',
                "page": pageNumber,
                "order": order,
                "orderby": orderBy,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        listLessThanPriceProduct == null
            ? listLessThanPriceProduct = []
            : log('');
        productController.getListLessThanPriceProductResponseData!.value =
            less_than_price_product_response.ListLessThanPriceProductResponse
                .fromJson(response.data);
        for (var element in productController
            .getListLessThanPriceProductResponseData!.value.data!) {
          listLessThanPriceProduct?.add(element);
        }
        log("getLessThanPriceProductResponseData Successful");
      } else {}
    } catch (e) {
      log(e.toString());
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
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },

        // options: Options(validateStatus: (status) {
        //   return status! < 500;
        // },)
      );
      if (response.statusCode == 200) {
        productController.getProductDetailResponseData!.value =
            ProductDetailResponse.fromJson(response.data);
        getRelatedProduct(
          related_ids: productController
              .getProductDetailResponseData!.value.data?[0].relatedAds
              .toString(),
        );
        log(
          "getProductDetailData Successful ${response.data['data'][0]['variations'][0]['attributes']['attribute_pa_%d8%a7%d9%84%d9%84%d9%88%d9%86']}",
        );
      } else {}
    } on DioError catch (e) {
      log(e.response.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  List<product_by_category_response.Data>? listProductByCategory;

  getProductByCategory({
    String? pageNumber,
    String? category,
    String? order,
    String? orderBy,
    String? onSale,
  }) async {
    String? token = SPHelper.spHelper.getToken();

    productController.getProductByCategoryData!.value =
        product_by_category_response.ListProductByCategoryResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
                "endpoint": "products",
                "category": category,
                "per_page": '56',
                "page": pageNumber,
                "on_sale": onSale ?? false,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              }
            : {
                "endpoint": "products",
                "category": category,
                "per_page": '56',
                "page": pageNumber,
                "order": order,
                "orderby": orderBy,
                "on_sale": onSale ?? false,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        listProductByCategory == null ? listProductByCategory = [] : log('');
        productController.getProductByCategoryData!.value =
            product_by_category_response.ListProductByCategoryResponse.fromJson(
          response.data,
        );
        for (var element
            in productController.getProductByCategoryData!.value.data!) {
          listProductByCategory?.add(element);
        }
        log("getProductByCategory Successful }");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  List<product_by_brand_response.Data>? listProductByBrand;

  getProductByBrand({
    String? pageNumber,
    String? brand,
    String? order,
    String? orderBy,
  }) async {
    String? token = SPHelper.spHelper.getToken();

    productController.getProductByBrandData!.value =
        product_by_brand_response.ListProductByBrandResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
                "endpoint": "products",
                "brand": brand,
                "per_page": '56',
                "page": pageNumber,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              }
            : {
                "endpoint": "products",
                "brand": brand,
                "per_page": '56',
                "page": pageNumber,
                "order": order,
                "orderby": orderBy,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        listProductByBrand == null ? listProductByBrand = [] : log('');
        productController.getProductByBrandData!.value =
            product_by_brand_response.ListProductByBrandResponse.fromJson(
          response.data,
        );
        for (var element
            in productController.getProductByBrandData!.value.data!) {
          listProductByBrand?.add(element);
        }
        log("getProductByBrand Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  List<filtered_product_response.Data>? listProductByFilter;

  getProductByFilter({
    String? pageNumber,
    String? category,
    String? brand,
    String? minPrice,
    String? maxPrice,
    String? order,
    String? orderBy,
  }) async {
    // String? token = SPHelper.spHelper.getToken();

    productController.getFilteredProductData!.value =
        filtered_product_response.ListFilteredProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
                "endpoint": "products",
                "category": category,
                "brand": brand,
                "per_page": '56',
                "page": pageNumber,
                "min_price": minPrice,
                "max_price": maxPrice,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              }
            : {
                "endpoint": "products",
                "category": category,
                "brand": brand,
                "per_page": '56',
                "page": pageNumber,
                "min_price": minPrice,
                "max_price": maxPrice,
                "order": order,
                "orderby": orderBy,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              },
      );
      if (response.statusCode == 200) {
        listProductByFilter == null ? listProductByFilter = [] : log('');

        productController.getFilteredProductData!.value =
            filtered_product_response.ListFilteredProductResponse.fromJson(
          response.data,
        );
        for (var element
            in productController.getFilteredProductData!.value.data!) {
          listProductByFilter?.add(element);
        }
        log("getProductByFilter Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getLastViewProduct({
    String? category,
    String? brand,
    String? maxPrice,
    bool? featured,
  }) async {
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
          "featured": featured ?? false,
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
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

        log("getLastViewProduct Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getRelatedProduct({String? related_ids}) async {
    log(related_ids.toString());
    productController.getRelatedProductData!.value = ListRelatedProductModel();
    try {
      Response response = await Dio().get(
        'https://nafahat.com/wp-json/wc/v3/products',
        queryParameters: {
          "include": related_ids,
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        productController.getRelatedProductData!.value =
            ListRelatedProductModel.fromJson(response.data);

        log("getRelatedProduct Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  sendWholeSaleRequest({
    String? clientName,
    String? companyName,
    String? companyAddress,
    String? email,
    String? phone,
  }) async {
    try {
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        'client-name': clientName,
        'company-name': companyName,
        'company-adress': companyAddress,
        'client-email': email,
        'phone-number': phone,
      });
      Response response = await Settingss.settings.dio!.post(
        'api-request.php',
        data: data,
        queryParameters: {"endpoint": "forms", "whosale": "true"},
      );
      if (response.statusCode! >= 200) {
        ProgressDialogUtils.hide();
        Helper.getSheetSucsses(response.data['message']);
        log("postComment Successful ");
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError('check_entered_data_value'.tr);
      }
    } catch (e) {
      ProgressDialogUtils.hide();
      Helper.getSheetError('check_entered_data_value'.tr);
      log(e.toString());
    }
  }

  getAds({
    String? category,
    String? brand,
    String? maxPrice,
    bool? featured,
  }) async {
    productController.getAdsData!.value = ListAdsResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        'api-request.php',
        queryParameters: {
          "endpoint": "banners",
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        productController.getAdsData!.value =
            ListAdsResponse.fromJson(response.data);

        log("getAds Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  List<care_product_response.Data>? listCareProduct;

  getCareProductData({
    required String? pageNumber,
    String? order,
    String? orderBy,
  }) async {
    productController.getCareProductDataData!.value =
        care_product_response.ListCareProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
                "endpoint": "products",
                "category": '2445',
                "per_page": '56',
                "page": pageNumber,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              }
            : {
                "endpoint": "products",
                "category": '2445',
                "per_page": '56',
                "page": pageNumber,
                "order": order,
                "orderby": orderBy,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              },
      );

      if (response.statusCode == 200) {
        listCareProduct == null ? listCareProduct = [] : log('');
        productController.getCareProductDataData!.value =
            care_product_response.ListCareProductResponse.fromJson(
          response.data,
        );
        for (var element
            in productController.getCareProductDataData!.value.data!) {
          listCareProduct?.add(element);
        }
        log("getCareProductData Successful");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getRecentlyAddedProductData({
    required String? pageNumber,
  }) async {
    productController.getRecentlyAddedProductDataData!.value =
        ListRecentlyAddedProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {
          "endpoint": "products",
          "per_page": '56',
          "page": pageNumber,
          "order": 'desc',
          "orderby": 'date',
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        productController.getRecentlyAddedProductDataData!.value =
            ListRecentlyAddedProductResponse.fromJson(response.data);
        log("getRecentlyAddedProductData Successful");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  List<search_product_response.Data>? listSearchProduct;

  searchProduct({
    String? pageNumber,
    String? word,
    String? order,
    String? orderBy,
  }) async {
    // String? token = SPHelper.spHelper.getToken();
    productController.getSearchProductDataData!.value =
        search_product_response.ListSearchProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: order == null || orderBy == null
            ? {
                "endpoint": "products",
                "search": word,
                // "category": category,
                "per_page": '56',
                "page": pageNumber,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              }
            : {
                "endpoint": "products",
                // "category": category,
                "per_page": '56',
                "page": pageNumber,
                "order": order,
                "orderby": orderBy,
                'lang':
                    SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
              },
      );
      if (response.statusCode == 200) {
        listSearchProduct == null ? listSearchProduct = [] : log('');
        productController.getSearchProductDataData!.value =
            search_product_response.ListSearchProductResponse.fromJson(
          response.data,
        );
        for (var element
            in productController.getSearchProductDataData!.value.data!) {
          listSearchProduct?.add(element);
        }
        log("searchProduct Successful }");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getFamousBrandAds() async {
    productController.getFamousBrandAdsData!.value = ListFamousBrandResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        'api-request.php',
        queryParameters: {
          "endpoint": "brands-feature",
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        productController.getFamousBrandAdsData!.value =
            ListFamousBrandResponse.fromJson(response.data);
        log("getFamousBrandAds Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

//
  getRamadanProductData() async {
    productController.getRamadanProductData!.value =
        ListRamadanProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {
          "endpoint": "products",
          "per_page": '8',
          "page": 1,
          "category": '2481',
          "order": 'desc',
          "orderby": 'date',
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        productController.getRamadanProductData!.value =
            ListRamadanProductResponse.fromJson(response.data);
        log("getRamadanProductData Successful");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getLensesProductData() async {
    productController.getLensesProductData!.value = ListLensesProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {
          "endpoint": "products",
          "per_page": '8',
          "page": 1,
          "category": '2443',
          "featured": true,

          // "order": 'desc',
          // "orderby": 'date',
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        productController.getLensesProductData!.value =
            ListLensesProductResponse.fromJson(response.data);
        log("getLensesProductData Successful");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getRamadanOffersProductData() async {
    productController.getRamadanOffersProductData!.value =
        ListRamadanOffersProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {
          "endpoint": "products",
          "per_page": '8',
          "page": 1,
          "category": '2482',
          // "featured": true,
          "order": 'desc',
          "orderby": 'date',
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        productController.getRamadanOffersProductData!.value =
            ListRamadanOffersProductResponse.fromJson(response.data);
        log("getRamadanOffersProductData Successful");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getTopMakeupProductData() async {
    productController.getTopMakeupProductData!.value =
        ListTopMakeupProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {
          "endpoint": "products",
          "per_page": '8',
          "page": 1,
          "category": '2444',
          "featured": true,

          // "order": 'desc',
          // "orderby": 'date',
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        productController.getTopMakeupProductData!.value =
            ListTopMakeupProductResponse.fromJson(response.data);
        log("getTopMakeupProductData Successful");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getTopDevicesProductData() async {
    productController.getTopDevicesProductData!.value =
        ListTopDevicesProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {
          "endpoint": "products",
          "per_page": '8',
          "page": 1,
          "category": '2482',
          "featured": true,

          // "order": 'desc',
          // "orderby": 'date',
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        productController.getTopDevicesProductData!.value =
            ListTopDevicesProductResponse.fromJson(response.data);
        log("getTopDevicesProductData Successful");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getTopNailsProductData() async {
    productController.getTopNailsProductData!.value =
        ListTopNailsProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {
          "endpoint": "products",
          "per_page": '8',
          "page": 1,
          "category": '2448',
          "featured": true,

          // "order": 'desc',
          // "orderby": 'date',
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        productController.getTopNailsProductData!.value =
            ListTopNailsProductResponse.fromJson(response.data);
        log("getTopNailsProductData Successful");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getTopPerfumeProductData() async {
    productController.getTopPerfumeProductData!.value =
        ListTopPerfumeProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        famousProductURL,
        queryParameters: {
          "endpoint": "products",
          "per_page": '8',
          "page": 1,
          "category": '2446',
          "featured": true,
          // "order": 'desc',
          // "orderby": 'date',
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        productController.getTopPerfumeProductData!.value =
            ListTopPerfumeProductResponse.fromJson(response.data);
        log("getTopPerfumeProductData Successful");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }
}
