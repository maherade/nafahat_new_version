import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:perfume_store_mobile_app/controller/product_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../../apies/category_apies.dart';
import '../../../apies/product_apies.dart';
import '../../../controller/category_controller.dart';
import '../../../services/app_imports.dart';
import '../../bottom_nav_screens/widget/brand_item.dart';
import '../../bottom_nav_screens/widget/category_item.dart';
import '../../bottom_nav_screens/widget/perfume_product_item.dart';
import '../../custom_widget/Skelton.dart';
import '../../custom_widget/custom_rate_write_bar.dart';
import '../../custom_widget/loading_efffect/loading_paggination.dart';
import '../../custom_widget/loading_efffect/loading_product.dart';
import '../../filter/screens/filter_screen.dart';
import '../../perfume_details/screens/perfume_details_screen.dart';

class ShowAllGiftPackageScreen extends StatefulWidget {
  @override
  State<ShowAllGiftPackageScreen> createState() => _ShowAllGiftPackageScreenState();
}

class _ShowAllGiftPackageScreenState extends State<ShowAllGiftPackageScreen> {
  ProductController productController = Get.find();

  String? selectedDropDown = 'order_by_popularity_value'.tr;
  int _currentPage = 1;

  String? order;
  String? orderBy;

  dropDown(String value) {
    if (value == 'order_by_popularity_value'.tr) {
      ProductApies.productApies.getGiftPackageProductData(
        pageNumber: '1',
        order: 'asc',
        orderBy: 'popularity',
      );
      setState(() {
        order = 'asc';
        orderBy = 'popularity';
      });
    } else if (value == 'order_by_rating_value'.tr) {
      ProductApies.productApies.getGiftPackageProductData(
        pageNumber: '1',
        order: 'asc',
        orderBy: 'rating',
      );
      setState(() {
        order = 'asc';
        orderBy = 'rating';
      });
    } else if (value == 'order_by_recent_value'.tr) {
      ProductApies.productApies.getGiftPackageProductData(
        pageNumber: '1',
        order: 'asc',
        orderBy: 'date',
      );
      setState(() {
        order = 'asc';
        orderBy = 'date';
      });
    } else if (value == 'order_by_min_to_height_price_value'.tr) {
      ProductApies.productApies.getGiftPackageProductData(
        pageNumber: '1',
        order: 'desc',
        orderBy: 'price',
      );
      setState(() {
        order = 'desc';
        orderBy = 'price';
      });
    } else if (value == 'order_by_height_to_min_price_value'.tr) {
      ProductApies.productApies.getGiftPackageProductData(
        pageNumber: '1',
        order: 'desc',
        orderBy: 'price',
      );
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
    ProductApies.productApies.getLastViewProduct(featured: true);
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
    return Scaffold(
      body: Obx(
        () {
          var product = productController.getGiftPackageProductData!.value.data;
          var lastViewedProduct = productController.getLastViewedProduct!.value.data;

          return LazyLoadScrollView(
            onEndOfPage: () {
              if (productController.getGiftPackageProductData?.value.headers?.xWPTotal != 0){
                setState(() {
                  _currentPage++;
                });
                ProductApies.productApies
                    .getGiftPackageProductData(order: order, orderBy: orderBy, pageNumber: _currentPage.toString())
                    .then((value) {
                  print('_currentPage ');
                });
              }
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                    child: const BackButton(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomText(
                              'discover_gift_package_value'.tr,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            const Spacer(),
                            DecoratedBox(
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
                            SizedBox(
                              width: 12.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => FilterScreen());
                              },
                              child: SvgPicture.asset(
                                'assets/svg/filter.svg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
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
                                itemCount: ProductApies.productApies.listGiftProduct?.length,
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
                                    imgUrl: ProductApies.productApies.listGiftProduct?[index].images?[0].src ?? '',
                                    // brandName: product[index]
                                    //         .brands!
                                    //         .isNotEmpty
                                    //     ? product[index].brands != null
                                    //         ? product[index].brands![0].name
                                    //         : ''
                                    //     : '',
                                    perfumeName: ProductApies.productApies.listGiftProduct?[index].title ?? '',
                                    perfumeRate:
                                        double.parse(ProductApies.productApies.listGiftProduct?[index].averageRating ?? '0.0'),
                                    rateCount: ProductApies.productApies.listGiftProduct?[index].ratingCount.toString() ?? '0',
                                    priceBeforeDiscount: ProductApies.productApies.listGiftProduct?[index].regularPrice ?? '',
                                    priceAfterDiscount: ProductApies.productApies.listGiftProduct?[index].salePrice ?? '',
                                    onTapBuy: () {
                                      print(ProductApies.productApies.listGiftProduct?[index].id.toString());
                                      Get.to(() => PerfumeDetailsScreen(
                                            productId: ProductApies.productApies.listGiftProduct?[index].id.toString(),
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
                        //       ProductApies.productApies
                        //           .getGiftPackageProductData(order: order, orderBy: orderBy, pageNumber: _currentPage.toString())
                        //           .then((value) {
                        //         print('_currentPage ');
                        //       });
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
                                  )
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
      ),
    );
  }
}
