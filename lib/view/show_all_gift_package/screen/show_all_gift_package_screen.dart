import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:perfume_store_mobile_app/controller/product_controller.dart';

import '../../../apies/product_apies.dart';
import '../../../services/app_imports.dart';
import '../../bottom_nav_screens/widget/perfume_product_item.dart';
import '../../custom_widget/loading_efffect/sliver_loading_product.dart';
import '../../filter/screens/filter_screen.dart';
import '../../perfume_details/screens/perfume_details_screen.dart';

class ShowAllGiftPackageScreen extends StatefulWidget {
  const ShowAllGiftPackageScreen({super.key});

  @override
  State<ShowAllGiftPackageScreen> createState() =>
      _ShowAllGiftPackageScreenState();
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
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    ProductApies.productApies.listGiftProduct = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
    super.initState();
  }

  late ScrollController _scrollController;
  bool _showBackToTopButton = false;

  void _scrollListener() {
    if (_scrollController.offset >= 400 && !_showBackToTopButton) {
      setState(() {
        _showBackToTopButton = true;
      });
    } else if (_scrollController.offset < 400 && _showBackToTopButton) {
      setState(() {
        _showBackToTopButton = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size dSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.arrow_upward),
            ),
      body: Obx(
        () {
          var product = productController.getGiftPackageProductData!.value.data;
          var lastViewedProduct =
              productController.getLastViewedProduct!.value.data;

          return LazyLoadScrollView(
            onEndOfPage: () {
              if (productController
                      .getGiftPackageProductData?.value.headers?.xWPTotal !=
                  0) {
                setState(() {
                  _currentPage++;
                });
                ProductApies.productApies
                    .getGiftPackageProductData(
                  order: order,
                  orderBy: orderBy,
                  pageNumber: _currentPage.toString(),
                )
                    .then((value) {
                  debugPrint('_currentPage ');
                });
              }
            },
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [

                SliverPadding(
                  padding: EdgeInsets.only(
                    left: 20.h,
                    right: 20.h,
                    top: 50.h,
                    bottom: 20.h,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [

                        BackButton(),


                        Spacer(),

                        CustomText('discover_gift_package_value'.tr.tr,
                          fontSize: 17.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.normal,
                        ),

                        Spacer(),

                        Container(
                          height: 45.h,
                          width: 45.w,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                // SliverPadding(
                //   padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                //   sliver: SliverToBoxAdapter(
                //     child: Column(
                //       children: [
                //         Row(
                //           children: [
                //             CustomText(
                //               'discover_gift_package_value'.tr,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 14.sp,
                //             ),
                //             const Spacer(),
                //             DecoratedBox(
                //               decoration: BoxDecoration(
                //                 border: Border.all(
                //                   color: const Color(0xffF5E7EA),
                //                   width: 1,
                //                 ),
                //                 borderRadius: BorderRadius.circular(5),
                //               ),
                //               child: Padding(
                //                 padding:
                //                     EdgeInsets.symmetric(horizontal: 7.0.w),
                //                 child: DropdownButton<String>(
                //                   underline: const SizedBox(),
                //                   focusColor: Colors.white,
                //                   value: selectedDropDown,
                //                   style: TextStyle(
                //                     color: Colors.white,
                //                     fontSize: 10.sp,
                //                   ),
                //                   iconEnabledColor: Colors.black,
                //                   items: <String>[
                //                     'order_by_popularity_value'.tr,
                //                     'order_by_rating_value'.tr,
                //                     'order_by_recent_value'.tr,
                //                     'order_by_min_to_height_price_value'.tr,
                //                     'order_by_height_to_min_price_value'.tr,
                //                   ].map<DropdownMenuItem<String>>(
                //                       (String value) {
                //                     return DropdownMenuItem<String>(
                //                       value: value,
                //                       child: CustomText(
                //                         value,
                //                         fontSize: 10.sp,
                //                       ),
                //                     );
                //                   }).toList(),
                //                   hint: CustomText(
                //                     "order_default_value".tr,
                //                     fontSize: 12.sp,
                //                     fontWeight: FontWeight.normal,
                //                   ),
                //                   onChanged: (String? value) {
                //                     ProductApies.productApies.listGiftProduct =
                //                         null;
                //                     dropDown(value!);
                //                     setState(() {
                //                       selectedDropDown = value;
                //                     });
                //                   },
                //                 ),
                //               ),
                //             ),
                //             SizedBox(
                //               width: 12.w,
                //             ),
                //             GestureDetector(
                //               onTap: () {
                //                 Get.to(() => const FilterScreen());
                //               },
                //               child: SvgPicture.asset(
                //                 'assets/svg/filter.svg',
                //                 fit: BoxFit.contain,
                //               ),
                //             ),
                //           ],
                //         ),
                //         SizedBox(
                //           height: 20.h,
                //         )
                //       ],
                //     ),
                //   ),
                // ),

                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffF5E7EA),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 7.0.w),
                            child: DropdownButton<String>(
                              underline: const SizedBox(),
                              focusColor: Colors.white,
                              value: selectedDropDown,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                              ),
                              iconEnabledColor: Colors.grey,
                              items: <String>[
                                'order_by_popularity_value'.tr,
                                'order_by_rating_value'.tr,
                                'order_by_recent_value'.tr,
                                'order_by_min_to_height_price_value'.tr,
                                'order_by_height_to_min_price_value'.tr,
                              ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: CustomText(
                                    value,
                                    fontSize: 10.sp,
                                    color: AppColors.grey,
                                  ),
                                );
                              }).toList(),
                              hint: CustomText(
                                "order_default_value".tr,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              onChanged: (String? value) {
                                ProductApies.productApies.listGiftProduct =
                                    null;
                                dropDown(value!);
                                setState(() {
                                  selectedDropDown = value;
                                });
                              },
                            ),
                          ),
                        ),

                        Spacer(),

                        GestureDetector(
                          onTap: () {
                            Get.to(() => const FilterScreen());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 40.h,
                            width: 40.w,
                            child: SvgPicture.asset(
                              'assets/svg/filter.svg',
                              height: 30.h,
                              width: 30.h,
                              color: Colors.white,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 20.h),
                  sliver: ProductApies.productApies.listGiftProduct == null
                      ? const SliverLoadingProduct(8)
                      : ProductApies.productApies.listGiftProduct!.isEmpty
                          ? SliverToBoxAdapter(
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 50.h),
                                  child: CustomText(
                                    'no_item_found_value'.tr,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            )
                          : SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: dSize.width > 400 &&
                                        dSize.width <= 500
                                    ? 0.6
                                    : dSize.width > 500 && dSize.width <= 600
                                        ? 0.7.h
                                        : dSize.width > 600 &&
                                                dSize.width <= 700
                                            ? 0.8.h
                                            : dSize.width > 700 &&
                                                    dSize.width <= 800
                                                ? 0.9.h
                                                : dSize.width > 800 &&
                                                        dSize.width <= 900
                                                    ? 1
                                                    : 1/1.9,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 15,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                childCount: ProductApies
                                    .productApies.listGiftProduct?.length,
                                (_, index) {
                                  var product =
                                      ProductApies.productApies.listGiftProduct;
                                  debugPrint(index.toString());
                                  return PerfumeProductItem(
                                    variations: ProductApies.productApies
                                        .listGiftProduct?[index].variations,

                                    id: ProductApies
                                        .productApies.listGiftProduct?[index].id
                                        .toString(),
                                    imgUrl: ProductApies
                                            .productApies
                                            .listGiftProduct?[index]
                                            .images?[0]
                                            .src ??
                                        '',
                                    // brandName: product[index]
                                    //         .brands!
                                    //         .isNotEmpty
                                    //     ? product[index].brands != null
                                    //         ? product[index].brands![0].name
                                    //         : ''
                                    //     : '',
                                    perfumeName: ProductApies.productApies
                                            .listGiftProduct?[index].title ??
                                        '',
                                    perfumeRate: double.parse(
                                      ProductApies
                                              .productApies
                                              .listGiftProduct?[index]
                                              .averageRating ??
                                          '0.0',
                                    ),
                                    rateCount: ProductApies.productApies
                                            .listGiftProduct?[index].ratingCount
                                            .toString() ??
                                        '0',
                                    priceBeforeDiscount:
                                        (product?[index].regularPrice ==
                                                    null) ||
                                                (product?[index].regularPrice ==
                                                    '0.00')
                                            ? (product?[index].price).toString()
                                            : product?[index].regularPrice,
                                    priceAfterDiscount:
                                        (product?[index].salePrice == null) ||
                                                (product?[index].salePrice ==
                                                    '0.00')
                                            ? (product?[index].price).toString()
                                            : product?[index].salePrice,
                                    onTapBuy: () {
                                      debugPrint(
                                        ProductApies.productApies
                                            .listGiftProduct?[index].id
                                            .toString(),
                                      );
                                      Get.to(
                                        () => PerfumeDetailsScreen(
                                          productId: ProductApies.productApies
                                              .listGiftProduct?[index].id
                                              .toString(),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  sliver: SliverToBoxAdapter(
                    child: product == null
                        ? const CupertinoActivityIndicator()
                        : const SizedBox(),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        CustomText(
                          'last_seen_value'.tr,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
                  sliver: lastViewedProduct == null
                      ? const SliverLoadingProduct(2)
                      : SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: dSize.width > 400 &&
                                    dSize.width <= 500
                                ? 0.6
                                : dSize.width > 500 && dSize.width <= 600
                                    ? 0.7.h
                                    : dSize.width > 600 && dSize.width <= 700
                                        ? 0.8.h
                                        : dSize.width > 700 &&
                                                dSize.width <= 800
                                            ? 0.9.h
                                            : dSize.width > 800 &&
                                                    dSize.width <= 900
                                                ? 1
                                                : 1.1,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 15,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (_, index) {
                              return PerfumeProductItem(
                                variations: lastViewedProduct[index].variations,
                                id: lastViewedProduct[index]
                                    .images?[0]
                                    .id
                                    .toString(),
                                imgUrl:
                                    lastViewedProduct[index].images?[0].src ??
                                        '',
                                brandName: lastViewedProduct[index]
                                        .brands!
                                        .isNotEmpty
                                    ? lastViewedProduct[index].brands != null
                                        ? lastViewedProduct[index]
                                            .brands![0]
                                            .name
                                        : ''
                                    : '',
                                perfumeName:
                                    lastViewedProduct[index].title ?? '',
                                perfumeRate: double.parse(
                                  lastViewedProduct[index].averageRating ??
                                      '0.0',
                                ),
                                rateCount: lastViewedProduct[index]
                                    .ratingCount
                                    .toString(),
                                priceBeforeDiscount:
                                    (lastViewedProduct[index].regularPrice ==
                                                null) ||
                                            (lastViewedProduct[
                                                        index]
                                                    .regularPrice ==
                                                '0.00')
                                        ? (lastViewedProduct[index].price)
                                            .toString()
                                        : lastViewedProduct[index].regularPrice,
                                priceAfterDiscount: (lastViewedProduct[index]
                                                .salePrice ==
                                            null) ||
                                        (lastViewedProduct[index].salePrice ==
                                            '0.00')
                                    ? (lastViewedProduct[index].price)
                                        .toString()
                                    : lastViewedProduct[index].salePrice,
                                onTapBuy: () {
                                  debugPrint(
                                    lastViewedProduct[index].id.toString(),
                                  );
                                  Get.to(
                                    () => PerfumeDetailsScreen(
                                      productId: lastViewedProduct[index]
                                          .id
                                          .toString(),
                                    ),
                                  );
                                },
                              );
                            },
                            childCount: lastViewedProduct.length,
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
