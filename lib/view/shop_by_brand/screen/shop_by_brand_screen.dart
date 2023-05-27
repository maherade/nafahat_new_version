import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:perfume_store_mobile_app/apies/brand_apies.dart';
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';
import 'package:perfume_store_mobile_app/controller/product_controller.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/Skelton.dart';
import 'package:perfume_store_mobile_app/view/bottom_nav_screens/screens/show_all_brand_screen.dart';

import '../../../apies/product_apies.dart';
import '../../../services/app_imports.dart';

import '../../bottom_nav_screens/widget/perfume_product_item.dart';

import '../../custom_widget/loading_efffect/loading_product.dart';
import '../../custom_widget/loading_efffect/sliver_loading_product.dart';
import '../../filter/screens/filter_screen.dart';
import '../../perfume_details/screens/perfume_details_screen.dart';
import '../../search/screen/search_screen.dart';

class ShopByBrandScreen extends StatefulWidget {
  final dynamic brandId;
  final String? brandName;

  const ShopByBrandScreen({super.key, this.brandId, this.brandName});

  @override
  State<ShopByBrandScreen> createState() => _ShopByBrandScreenState();
}

class _ShopByBrandScreenState extends State<ShopByBrandScreen> {
  ProductController productController = Get.find();
  BrandController brandController = Get.find();

  String? selectedDropDown = 'order_by_popularity_value'.tr;
  int _currentPage = 1;

  String? order;
  String? orderBy;

  void dropDown(String value) {
    if (value == 'order_by_popularity_value'.tr) {
      ProductApies.productApies
          .getProductByBrand(pageNumber: '1', brand: widget.brandId.toString(), order: 'asc', orderBy: 'popularity');
      setState(() {
        order = 'asc';
        orderBy = 'popularity';
      });
    } else if (value == 'order_by_rating_value'.tr) {
      ProductApies.productApies
          .getProductByBrand(pageNumber: '1', brand: widget.brandId.toString(), order: 'asc', orderBy: 'rating');
      setState(() {
        order = 'asc';
        orderBy = 'rating';
      });
    } else if (value == 'order_by_recent_value'.tr) {
      ProductApies.productApies
          .getProductByBrand(pageNumber: '1', order: 'asc', brand: widget.brandId.toString(), orderBy: 'date');
      setState(() {
        order = 'asc';
        orderBy = 'date';
      });
    } else if (value == 'order_by_min_to_height_price_value'.tr) {
      ProductApies.productApies
          .getProductByBrand(pageNumber: '1', brand: widget.brandId.toString(), order: 'desc', orderBy: 'price');
      setState(() {
        order = 'desc';
        orderBy = 'price';
      });
    } else if (value == 'order_by_height_to_min_price_value'.tr) {
      ProductApies.productApies
          .getProductByBrand(pageNumber: '1', brand: widget.brandId.toString(), order: 'desc', orderBy: 'price');
      setState(() {
        order = 'asc';
        orderBy = 'price';
      });
    }
  }

  getData() async {
    ProductApies.productApies.getProductByBrand(pageNumber: '1', brand: widget.brandId.toString());
    ProductApies.productApies.getLastViewProduct(brand: widget.brandId.toString());
    BrandApies.brandApies.getBrandById(brandID: widget.brandId.toString());
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    ProductApies.productApies.listProductByBrand = null;

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
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
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
          var product = productController.getProductByBrandData!.value.data;
          var lastViewedProduct = productController.getLastViewedProduct!.value.data;
          var brand = brandController.getBrandByIdData!.value;

          return LazyLoadScrollView(
            onEndOfPage: () {
              if (productController.getProductByBrandData?.value.headers?.xWPTotal != 0) {
                setState(() {
                  _currentPage++;
                });
                ProductApies.productApies
                    .getProductByBrand(
                        order: order, brand: widget.brandId.toString(), orderBy: orderBy, pageNumber: _currentPage.toString())
                    .then((value) {
                  print('_currentPage ');
                });
              }
            },
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(top: 40.h, right: 5.w, left: 5.w),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        const BackButton(),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Get.to(() => SearchScreen());
                          },
                          icon: Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  sliver: SliverToBoxAdapter(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [ SizedBox(
                        height: 15.h,
                      ),
                        CustomText(
                          'shop_by_brand_value'.tr,
                          fontSize: 15.sp,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        brand.termId != null
                            ? GestureDetector(
                          onTap: () {
                            Get.off(() => ShowAllBrandScreen());
                          },
                          child: CachedNetworkImageShare(
                            urlImage: brand.brandImage?[0] ?? '',
                            fit: BoxFit.cover,
                            heigthNumber: 50.h,
                            widthNumber: 60.w,
                          ),
                        )
                            : Skelton(
                          height: 50.h,
                          width: 60.w,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            brand.name != null
                                ? SizedBox(
                              width: 140.w,
                              child: CustomText(
                                'shop_from_brand_value'.tr + '${brand.name}',
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                textAlign: TextAlign.start,
                              ),
                            )
                                : Skelton(height: 10.h, width: 100.w, radious: 5.r),
                            const Spacer(),
                            SizedBox(
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
                                      ProductApies.productApies.listProductByBrand = null;
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
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  sliver: ProductApies.productApies.listProductByBrand == null
                      ? SliverLoadingProduct(8)
                      : ProductApies.productApies.listProductByBrand!.isEmpty
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
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.45.h,
                                crossAxisCount: 2,
                                crossAxisSpacing: 11.w,
                                mainAxisSpacing: 16.h,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                childCount: ProductApies.productApies.listProductByBrand?.length,
                                (_, index) {
                                  print(index);
                                  return PerfumeProductItem(
                                    id: ProductApies.productApies.listProductByBrand?[index].id.toString(),
                                    imgUrl: ProductApies.productApies.listProductByBrand?[index].images?[0].src ?? '',
                                    brandName: ProductApies.productApies.listProductByBrand![index].brands!.isNotEmpty
                                        ? ProductApies.productApies.listProductByBrand![index].brands != null
                                            ? ProductApies.productApies.listProductByBrand![index].brands![0].name
                                            : ''
                                        : '',
                                    perfumeName: ProductApies.productApies.listProductByBrand?[index].title ?? '',
                                    perfumeRate:
                                        double.parse(ProductApies.productApies.listProductByBrand?[index].averageRating ?? '0.0'),
                                    rateCount: ProductApies.productApies.listProductByBrand?[index].ratingCount.toString() ?? '0',
                                    priceBeforeDiscount: ProductApies.productApies.listProductByBrand?[index].regularPrice ?? '',
                                    priceAfterDiscount: ProductApies.productApies.listProductByBrand?[index].salePrice ?? '',
                                    onTapBuy: () {
                                      print(ProductApies.productApies.listProductByBrand?[index].id.toString());
                                      Get.to(() => PerfumeDetailsScreen(
                                            productId: ProductApies.productApies.listProductByBrand?[index].id.toString(),
                                          ));
                                    },
                                  );
                                },
                              ),
                            ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        if (product == null) ...{CupertinoActivityIndicator()} else ...{SizedBox()},
                        SizedBox(
                          height: 40.h,
                        ),
                        Row(
                          children: [
                            CustomText(
                              'last_seen_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  sliver: lastViewedProduct == null
                      ? SliverLoadingProduct(8)
                      : lastViewedProduct.isEmpty
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.45.h,
                      crossAxisCount: 2,
                      crossAxisSpacing: 11.w,
                      mainAxisSpacing: 16.h,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: lastViewedProduct.length,
                          (_, index) {
                        print(index);
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
