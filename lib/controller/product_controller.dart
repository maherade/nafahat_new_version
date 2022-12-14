

import 'package:get/get.dart';

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



class ProductController extends GetxController{
  Rx<ListFamousProductResponse>? getFamousProductData = ListFamousProductResponse().obs;
  Rx<ListProductResponse>? getProductData = ListProductResponse().obs;
  Rx<ListProductByCategoryResponse>? getProductByCategoryData = ListProductByCategoryResponse().obs;
  Rx<ListFilteredProductResponse>? getFilteredProductData = ListFilteredProductResponse().obs;
  Rx<ListGiftPackageProductResponse>? getGiftPackageProductData = ListGiftPackageProductResponse().obs;
  Rx<ListWholeSaleResponse>? getListWholeSaleResponseData = ListWholeSaleResponse().obs;
  Rx<ListMakupProductResponse>? getListMakupProductResponseData = ListMakupProductResponse().obs;
  Rx<ListLessThanPriceProductResponse>? getListLessThanPriceProductResponseData = ListLessThanPriceProductResponse().obs;
  Rx<ListSubCategoryProductResponse>? getListSubCategoryProductData = ListSubCategoryProductResponse().obs;
  Rx<ProductDetailResponse>? getProductDetailResponseData = ProductDetailResponse().obs;
  Rx<ListLastViewedProductResponse>? getLastViewedProduct = ListLastViewedProductResponse().obs;
}