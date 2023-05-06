import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:perfume_store_mobile_app/view/search/screen/search_screen.dart';

import '../../../apies/product_apies.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/category_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../services/app_imports.dart';
import '../../cart/screen/cart_screen.dart';
import '../../custom_widget/loading_efffect/loading_paggination.dart';
import '../../custom_widget/loading_efffect/loading_product.dart';
import '../../filter/screens/filter_screen.dart';
import '../../perfume_details/screens/perfume_details_screen.dart';
import '../../shop_by_category/screen/shop_by_category.dart';
import '../widget/perfume_product_item.dart';
import 'package:badges/badges.dart' as badges;

class GiftScreen extends StatefulWidget {
  @override
  State<GiftScreen> createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> {
  @override
  ProductController productController = Get.find();

  String? selectedDropDown = 'order_by_popularity_value'.tr;
  int _currentPage = 1;

  String? order;
  String? orderBy;

  void dropDown(String value) {
    if (value == 'order_by_popularity_value'.tr) {
      ProductApies.productApies.getGiftPackageProductData(pageNumber: '1', order: 'asc', orderBy: 'popularity');
      setState(() {
        order = 'asc';
        orderBy = 'popularity';
      });
    } else if (value == 'order_by_rating_value'.tr) {
      ProductApies.productApies.getGiftPackageProductData(pageNumber: '1', order: 'asc', orderBy: 'rating');
      setState(() {
        order = 'asc';
        orderBy = 'rating';
      });
    } else if (value == 'order_by_recent_value'.tr) {
      ProductApies.productApies.getGiftPackageProductData(pageNumber: '1', order: 'asc', orderBy: 'date');
      setState(() {
        order = 'asc';
        orderBy = 'date';
      });
    } else if (value == 'order_by_min_to_height_price_value'.tr) {
      ProductApies.productApies.getGiftPackageProductData(pageNumber: '1', order: 'desc', orderBy: 'price');
      setState(() {
        order = 'desc';
        orderBy = 'price';
      });
    } else if (value == 'order_by_height_to_min_price_value'.tr) {
      ProductApies.productApies.getGiftPackageProductData(pageNumber: '1', order: 'asc', orderBy: 'price');
      setState(() {
        order = 'asc';
        orderBy = 'price';
      });
    }
  }


  getData() async {
    ProductApies.productApies.getGiftPackageProductData(
      pageNumber: '1',
    );
    ProductApies.productApies.getLastViewProduct();
  }

  @override
  void initState() {
    ProductApies.productApies.listGiftProduct = null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var product = productController.getGiftPackageProductData!.value.data;
        var lastViewedProduct = productController.getLastViewedProduct!.value.data;
        return LazyLoadScrollView(
          onEndOfPage: (){
            if (productController.getGiftPackageProductData?.value.headers?.xWPTotal != 0){
              setState(() {
                _currentPage++;
              });
              if (productController.getGiftPackageProductData?.value.headers?.xWPTotal != 0) {
                ProductApies.productApies
                    .getGiftPackageProductData(order: order, orderBy: orderBy, pageNumber: _currentPage.toString())
                    .then((value) {
                  print('_currentPage ');
                });
              }
            }
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>CartScreen());
                        },
                        child: GetBuilder<CartController>(
                          init: CartController(),
                          builder: (controller) {
                            return badges.Badge(
                              showBadge: controller.items.isNotEmpty ? true :false,
                              position: badges.BadgePosition.topEnd(),
                              badgeStyle: badges.BadgeStyle(
                                shape: badges.BadgeShape.circle,
                                borderRadius: BorderRadius.circular(12.r),
                                badgeColor: AppColors.primaryColor,
                              ),

                              badgeContent: CustomText(
                                controller.items.length.toString(),
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 11.sp,
                                textAlign: TextAlign.center,
                              ),
                              child: SvgPicture.asset(
                                'assets/svg/cart.svg',
                                color: AppColors.greenText,
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                        ),
                      ),
                    SizedBox(width: 3.w,),
                            IconButton(onPressed: () {
                            Get.to(()=>SearchScreen());
                            }, icon: Icon(Icons.search))
                    ],
                  ),
                ),
                Obx(
                  () {
                    var ads = productController.getAdsData?.value.listAdsResponse;
                    return SizedBox(
                      height: 160.h,
                      child: PageView.builder(
                        onPageChanged: (index) {},
                        itemCount: ads?.length,
                        itemBuilder: (context, index) {
                          return ads == null
                              ? SizedBox(
                                  height: 200.h,
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Get.to(() =>  ShopByCategoryScreen(
                                          categoryId: 183,
                                          categoryName: 'gift_package_value'.tr,
                                        ));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                                    child: SizedBox(
                                      height: 200.h,
                                      child: ClipRRect(
                                        // borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImageShare(
                                          urlImage: ads[1].image ?? '',
                                          widthNumber: double.infinity,
                                          heigthNumber: double.infinity,
                                          fit: BoxFit.fill,
                                          borderRadious: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: CustomText(
                              'discover_gift_package_value'.tr,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),

                          Expanded(
                            flex: 8,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xffF5E7EA), width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 7.0.w),
                                child: DropdownButton<String>(
                                  underline: SizedBox(),
                                  focusColor: Colors.white,
                                  value: selectedDropDown,
                                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                                  iconEnabledColor: Colors.black,
                                  items: <String>[
                                    'order_by_popularity_value'.tr,
                                    'order_by_rating_value'.tr,
                                    'order_by_recent_value'.tr,
                                    'order_by_min_to_height_price_value'.tr,
                                    'order_by_height_to_min_price_value'.tr,
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: CustomText(
                                        value,
                                        fontSize: 10.sp,
                                      ),
                                    );
                                  }).toList(),
                                  hint: CustomText(
                                    "order_default_value".tr,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  onChanged: (String? value) {
                                    ProductApies.productApies.listGiftProduct = null;
                                    dropDown(value!);
                                    setState(() {
                                      selectedDropDown = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => FilterScreen());
                              },
                              child: SvgPicture.asset(
                                'assets/svg/filter.svg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // loadingProduct(),
                      ProductApies.productApies.listGiftProduct == null
                          ? const LoadingProduct(8)
                          : ProductApies.productApies.listGiftProduct!.isEmpty
                          ? Container(
                        margin: EdgeInsets.only(top: 50.h),
                        child: CustomText(
                          'no_item_found_value'.tr,
                          fontSize: 18.sp,
                        ),
                      )
                          : GridView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount:  ProductApies.productApies.listGiftProduct?.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.45.h,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 11.w,
                                    mainAxisSpacing: 16.h,
                                  ),
                                  itemBuilder: (_, index) {
                                    return PerfumeProductItem(
                                      id: ProductApies.productApies.listGiftProduct?[index].id.toString(),
                                      imgUrl:  ProductApies.productApies.listGiftProduct?[index].images?[0].src ?? '',
                                      brandName:  ProductApies.productApies.listGiftProduct![index].brands!.isNotEmpty
                                          ?  ProductApies.productApies.listGiftProduct![index].brands != null
                                              ?  ProductApies.productApies.listGiftProduct![index].brands![0].name
                                              : ''
                                          : '',
                                      perfumeName:  ProductApies.productApies.listGiftProduct?[index].title ?? '',
                                      perfumeRate: double.parse( ProductApies.productApies.listGiftProduct?[index].averageRating ?? '0.0'),
                                      rateCount:  ProductApies.productApies.listGiftProduct?[index].ratingCount.toString() ?? '0',
                                      priceBeforeDiscount:  ProductApies.productApies.listGiftProduct?[index].regularPrice ?? '',
                                      priceAfterDiscount:  ProductApies.productApies.listGiftProduct?[index].salePrice ?? '',
                                      onTapBuy: () {
                                        print( ProductApies.productApies.listGiftProduct?[index].id.toString());
                                        Get.to(() => PerfumeDetailsScreen(
                                              productId:  ProductApies.productApies.listGiftProduct?[index].id.toString(),
                                            ));
                                      },
                                    );
                                  },
                                ),
                      SizedBox(
                        height: 40.h,
                      ),
                      if (product == null) ...{
                        CupertinoActivityIndicator()
                      }
                      // else if (productController.getGiftPackageProductData?.value.headers?.xWPTotal != 0) ...{
                      //   GestureDetector(
                      //     onTap: () {
                      //       setState(() {
                      //         _currentPage++;
                      //       });
                      //       if (productController.getGiftPackageProductData?.value.headers?.xWPTotal != 0) {
                      //         ProductApies.productApies
                      //             .getGiftPackageProductData(order: order, orderBy: orderBy, pageNumber: _currentPage.toString())
                      //             .then((value) {
                      //           print('_currentPage ');
                      //         });
                      //       }
                      //     },
                      //     child: Container(
                      //         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      //         decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10.r)),
                      //         child: CustomText(
                      //           'عرض المزيد',
                      //           fontSize: 13.sp,
                      //           fontWeight: FontWeight.normal,
                      //         )),
                      //   )
                      // }
                      else ...{
                        SizedBox()
                      },
                      SizedBox(
                        height: 40.h,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              CustomText(
                                'last_seen_value'.tr,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                          lastViewedProduct == null
                              ? LoadingProduct(2)
                              : GridView.builder(
                                  itemCount: lastViewedProduct.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.45.h,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 11.w,
                                    mainAxisSpacing: 16.h,
                                  ),
                                  itemBuilder: (_, index) {
                                    return PerfumeProductItem(
                                      id: lastViewedProduct[index].id.toString(),
                                      imgUrl: lastViewedProduct[index].images?[0].src ?? '',
                                      brandName: lastViewedProduct[index].brands!.isNotEmpty
                                          ? lastViewedProduct[index].brands != null
                                              ? lastViewedProduct[index].brands![0].name
                                              : ''
                                          : '',
                                      perfumeName: lastViewedProduct[index].title ?? '',
                                      perfumeRate: double.parse(lastViewedProduct[index].averageRating ?? '0.0'),
                                      rateCount: lastViewedProduct[index].ratingCount.toString() ?? '0',
                                      priceBeforeDiscount: lastViewedProduct[index].regularPrice ?? '',
                                      priceAfterDiscount: lastViewedProduct[index].salePrice ?? '',
                                      onTapBuy: () {
                                        print(lastViewedProduct[index].id.toString());
                                        Get.to(() => PerfumeDetailsScreen(
                                              productId: lastViewedProduct[index].id.toString(),
                                            ));
                                      },
                                    );
                                  },
                                ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
