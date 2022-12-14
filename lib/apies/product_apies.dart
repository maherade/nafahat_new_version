import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';

import '../const_urls.dart';
import '../controller/product_controller.dart';
import '../model/famous_product_response.dart';
import '../model/filtered_product_response.dart';
import '../model/gift_package_product_response.dart';
import '../model/last_viewed_product_response.dart';
import '../model/less_than_price_product_response.dart';
import '../model/makup_product_response.dart';
import '../model/product_by_category_response.dart';
import '../model/product_detail_response.dart';
import '../model/product_response.dart';
import '../model/sub_category_product.dart';
import '../model/whole_sale_response.dart';
import '../services/Settingss.dart';



class ProductApies {
  ProductApies._();

  static ProductApies productApies = ProductApies._();
  ProductController productController = myGet.Get.find();

  getFamousProductData({String? category, bool? onSale}) async {
    productController.getFamousProductData!.value = ListFamousProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          famousProductURL,
        queryParameters: {
          "category" : category,
          // "on_sale" : onSale
        }
      );
      if (response.statusCode == 200) {
        productController.getFamousProductData!.value = ListFamousProductResponse.fromJson(response.data);
        print("getFamousProductData Successful ${response.headers}" );
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getProductData({String? pageNumber , String? category, String? order, String? orderBy}) async {
    productController.getProductData!.value = ListProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          famousProductURL,
        queryParameters:order==null || orderBy==null? {
          "category" : category,
          "per_page" : '8',
          "page" : pageNumber,
        }:{
          "category" : category,
          "per_page" : '8',
          "page" : pageNumber,
          "order" : order,
          "orderby" : orderBy,
        }
      );
      if (response.statusCode == 200) {
         productController.getProductData!.value = ListProductResponse.fromJson(response.data);
        productController.getProductData!.value.totalPage = response.headers['X-WP-TotalPages']![0];
        print("getProductData Successful ${ productController.getProductData!.value.totalPage}" );
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getGiftPackageProductData({required bool? feature ,required String? pageNumber , String? order, String? orderBy}) async {
    productController.getGiftPackageProductData!.value = ListGiftPackageProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          famousProductURL,
          queryParameters: order==null || orderBy==null? {
            "featured" : feature,
            "per_page" : '8',
            "page" : pageNumber,
          } : {
            "per_page" : '8',
            "feature" : feature,
            "page" : pageNumber,
            "order" : order,
            "orderby" : orderBy,
          }

      );
      if (response.statusCode == 200) {
        productController.getGiftPackageProductData!.value  = ListGiftPackageProductResponse.fromJson(response.data);
        productController.getGiftPackageProductData!.value.totalPage = response.headers['X-WP-TotalPages']![0];
        print("getGiftPackageProductData Successful ${ productController.getGiftPackageProductData!.value.totalPage}" );
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getWholeSaleProductData({bool? onSale}) async {
    productController.getListWholeSaleResponseData!.value = ListWholeSaleResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          famousProductURL,
        queryParameters: {
           "on_sale" : onSale
        }
      );
      if (response.statusCode == 200) {
        productController.getListWholeSaleResponseData!.value  = ListWholeSaleResponse.fromJson(response.data);
        print("getWholeSaleProductData Successful ${productController.getListWholeSaleResponseData!.value.listListWholeSaleResponse![0]} " );
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getMakupProductData() async {
    productController.getListMakupProductResponseData!.value = ListMakupProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          famousProductURL,
        queryParameters: {
           "category" : '24'
        }
      );
      if (response.statusCode == 200) {
        productController.getListMakupProductResponseData!.value  = ListMakupProductResponse.fromJson(response.data);
        print("getMakupProductData Successful ${productController.getListMakupProductResponseData!.value.listMakupProductResponse![0]} " );
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getLessThanPriceProductResponseData({required String? lessThan,required String? pageNumber , String? order, String? orderBy}) async {
    productController.getListLessThanPriceProductResponseData!.value = ListLessThanPriceProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          famousProductURL,
          queryParameters: order==null || orderBy==null? {
            "max_price" : lessThan,
            "per_page" : '8',
            "page" : pageNumber,
           }
              :{
            "max_price" : lessThan,
            "per_page" : '8',
            "page" : pageNumber,
            "order" : order,
            "orderby" : orderBy,
          }


      );
      if (response.statusCode == 200) {
        productController.getListLessThanPriceProductResponseData!.value  = ListLessThanPriceProductResponse.fromJson(response.data);
        productController.getListLessThanPriceProductResponseData!.value.totalPage = response.headers['X-WP-TotalPages']![0];
        print("getLessThanPriceProductResponseData Successful ${ productController.getListLessThanPriceProductResponseData!.value.totalPage}" );
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getListSubCategoryProduct({String? category,String? page}) async {
    productController.getListSubCategoryProductData!.value = ListSubCategoryProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          famousProductURL,
        queryParameters: {
           "category" : category,
           "page" : page??'1',
           "per_page" : '4'
        }
      );
      if (response.statusCode == 200) {
        productController.getListSubCategoryProductData!.value  = ListSubCategoryProductResponse.fromJson(response.data);
        print("getListSubCategoryProduct Successful ${productController.getListSubCategoryProductData!.value.listSubCategoryProductResponse![0]} " );
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getProductDetailData(String id) async {
    productController.getProductDetailResponseData!.value = ProductDetailResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          '/wc/v3/products/$id',
        // options: Options(validateStatus: (status) {
        //   return status! < 500;
        // },)
      );
      if (response.statusCode == 200) {
        productController.getProductDetailResponseData!.value  = ProductDetailResponse.fromJson(response.data);
        print("getProductDetailData Successful " );
      } else {}
    }on DioError catch (e) {
      print(e.response.toString());
    }catch (e) {
      print(e.toString());
    }
  }

  getProductByCategory({String? pageNumber , String? category ,String? order, String? orderBy}) async {
    productController.getProductByCategoryData!.value = ListProductByCategoryResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          famousProductURL,
          queryParameters: order==null || orderBy==null? {
            "category" : category,
            "per_page" : '8',
            "page" : pageNumber,
          } : {
            "category" : category,
            "per_page" : '8',
            "page" : pageNumber,
            "order" : order,
            "orderby" : orderBy,
          }
      );
      if (response.statusCode == 200) {
        productController.getProductByCategoryData!.value = ListProductByCategoryResponse.fromJson(response.data);
        productController.getProductByCategoryData!.value.totalPage = response.headers['X-WP-TotalPages']![0];
        print("getProductByCategory Successful ${ productController.getProductByCategoryData!.value.totalPage}" );
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getProductByFilter({
    String? pageNumber , String? category ,String? minPrice ,String? maxPrice, String? order, String? orderBy
  }) async {
    productController.getFilteredProductData!.value = ListFilteredProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          famousProductURL,
          queryParameters: order==null || orderBy==null? {
            "category" : category,
            "per_page" : '8',
            "page" : pageNumber,
            "min_price" : minPrice,
            "max_price" : maxPrice,}
              :{
            "category" : category,
            "per_page" : '8',
            "page" : pageNumber,
            "min_price" : minPrice,
            "max_price" : maxPrice,
            "order" : order,
            "orderby" : orderBy,
          }
      );
      if (response.statusCode == 200) {
        productController.getFilteredProductData!.value = ListFilteredProductResponse.fromJson(response.data);
        productController.getFilteredProductData!.value.totalPage = response.headers['X-WP-TotalPages']![0];
        print("getProductByCategory Successful ${ productController.getFilteredProductData!.value.totalPage}" );
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getLastViewProduct({
  String? category,String? maxPrice,bool? featured
  }) async {
    productController.getLastViewedProduct!.value = ListLastViewedProductResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
          famousProductURL,
          queryParameters: {
            "category" : category,
            "per_page" : '2',
            "page" : '1',
            "order" : 'asc',
            "orderby" : 'date',
            "max_price" : maxPrice,
            "featured" : featured?? false
          }
      );
      if (response.statusCode == 200) {
        productController.getLastViewedProduct!.value = ListLastViewedProductResponse.fromJson(response.data);
        productController.getLastViewedProduct!.value.totalPage = response.headers['X-WP-TotalPages']![0];
        print("getLastViewProduct Successful ${ productController.getLastViewedProduct!.value.totalPage}" );
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }




}
