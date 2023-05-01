

import 'package:get/get.dart';
import 'package:perfume_store_mobile_app/model/related_product_model.dart';

import '../model/ads_response.dart';
import '../model/care_product_response.dart';
import '../model/famous_brand_response.dart';
import '../model/famous_product_response.dart';
import '../model/filtered_product_response.dart';
import '../model/gift_package_product_response.dart';
import '../model/last_viewed_product_response.dart';
import '../model/lenses_response.dart';
import '../model/less_than_price_product_response.dart';
import '../model/list_product_by_brand_response.dart';
import '../model/makup_product_response.dart';
import '../model/product_by_category_response.dart';
import '../model/product_detail_response.dart';
import '../model/product_response.dart';
import '../model/ramadan_offers_response.dart';
import '../model/ramadan_product_response.dart';
import '../model/recently_added_product_response.dart';
import '../model/search_product_response.dart';
import '../model/sub_category_product.dart';
import '../model/top_devices_product_response.dart';
import '../model/top_makup_product_response.dart';
import '../model/top_nails_product_response.dart';
import '../model/top_perfume_product_response.dart';
import '../model/whole_sale_response.dart';



class ProductController extends GetxController{
  Rx<ListFamousProductResponse>? getFamousProductData = ListFamousProductResponse().obs;
  Rx<ListProductResponse>? getProductData = ListProductResponse().obs;
  Rx<ListProductByCategoryResponse>? getProductByCategoryData = ListProductByCategoryResponse().obs;
  Rx<ListProductByBrandResponse>? getProductByBrandData = ListProductByBrandResponse().obs;
  Rx<ListFilteredProductResponse>? getFilteredProductData = ListFilteredProductResponse().obs;
  Rx<ListGiftPackageProductResponse>? getGiftPackageProductData = ListGiftPackageProductResponse().obs;
  Rx<ListWholeSaleResponse>? getListWholeSaleResponseData = ListWholeSaleResponse().obs;
  Rx<ListOffersProductResponse>? getListOffersProductResponseData = ListOffersProductResponse().obs;
  Rx<ListLessThanPriceProductResponse>? getListLessThanPriceProductResponseData = ListLessThanPriceProductResponse().obs;
  Rx<ListSubCategoryProductResponse>? getListSubCategoryProductData = ListSubCategoryProductResponse().obs;
  Rx<ProductDetailResponse>? getProductDetailResponseData = ProductDetailResponse().obs;
  Rx<ListLastViewedProductResponse>? getLastViewedProduct = ListLastViewedProductResponse().obs;
  Rx<ListAdsResponse>? getAdsData = ListAdsResponse().obs;
  Rx<ListCareProductResponse>? getCareProductDataData = ListCareProductResponse().obs;
  Rx<ListRecentlyAddedProductResponse>? getRecentlyAddedProductDataData = ListRecentlyAddedProductResponse().obs;
  Rx<ListSearchProductResponse>? getSearchProductDataData = ListSearchProductResponse().obs;
  Rx<ListFamousBrandResponse>? getFamousBrandAdsData = ListFamousBrandResponse().obs;
  Rx<ListRelatedProductModel>? getRelatedProductData = ListRelatedProductModel().obs;

  Rx<ListRamadanProductResponse>? getRamadanProductData = ListRamadanProductResponse().obs;
  Rx<ListLensesProductResponse>? getLensesProductData = ListLensesProductResponse().obs;
  Rx<ListRamadanOffersProductResponse>? getRamadanOffersProductData = ListRamadanOffersProductResponse().obs;
  Rx<ListTopMakeupProductResponse>? getTopMakeupProductData = ListTopMakeupProductResponse().obs;
  Rx<ListTopDevicesProductResponse>? getTopDevicesProductData = ListTopDevicesProductResponse().obs;
  Rx<ListTopNailsProductResponse>? getTopNailsProductData = ListTopNailsProductResponse().obs;
  Rx<ListTopPerfumeProductResponse>? getTopPerfumeProductData = ListTopPerfumeProductResponse().obs;

}