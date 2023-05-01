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
import '../../custom_widget/custom_search_bar.dart';
import '../../custom_widget/loading_efffect/loading_paggination.dart';
import '../../custom_widget/loading_efffect/loading_product.dart';
import '../../filter/screens/filter_screen.dart';
import '../../perfume_details/screens/perfume_details_screen.dart';

class SearchScreen extends StatefulWidget {
  final String? word;

  const SearchScreen({super.key, this.word});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  CategoryController categoryController = Get.find();
  ProductController productController = Get.find();

  int _currentPage = 1;


  TextEditingController searchController = TextEditingController();


  getData() async {
    ProductApies.productApies.searchProduct(pageNumber: '1', word: widget.word ?? '');
    ProductApies.productApies.getLastViewProduct();
    searchController.text = widget.word ?? '';
  }

  @override
  void initState() {
    ProductApies.productApies.listSearchProduct = null;
    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          var product = productController.getSearchProductDataData!.value.data;
          var lastViewedProduct = productController.getLastViewedProduct!.value.data;

          return LazyLoadScrollView(
            onEndOfPage: (){
              if (productController.getSearchProductDataData?.value.headers?.xWPTotal != 0){
                setState(() {
                  _currentPage++;
                });
                ProductApies.productApies
                    .searchProduct(word: widget.word, pageNumber: _currentPage.toString())
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
                        CustomSearchBar(
                          hintText: 'search_by_product_value'.tr,
                          controller: searchController,
                          onTapSearch: () {
                            ProductApies.productApies.listSearchProduct = null;
                            ProductApies.productApies.searchProduct(pageNumber: '1', word: searchController.text);
                          },
                        ),
                        SizedBox(height: 25.h,),
                        // loadingProduct(),
                        ProductApies.productApies.listSearchProduct == null
                            ? const LoadingProduct(8)
                            : ProductApies.productApies.listSearchProduct!.isEmpty
                                ? Container(
                                    margin: EdgeInsets.only(top: 50.h),
                                    child: CustomText(
                                      'no_item_found_value'.tr,
                                      fontSize: 18.sp,
                                    ),
                                  )
                                : GridView.builder(
                          padding: EdgeInsets.zero,
                                    itemCount: ProductApies.productApies.listSearchProduct?.length,
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
                                        id: ProductApies.productApies.listSearchProduct?[index].id.toString(),
                                        imgUrl: ProductApies.productApies.listSearchProduct?[index].images?[0].src ?? '',
                                        brandName: ProductApies.productApies.listSearchProduct![index].brands!.isNotEmpty
                                            ? ProductApies.productApies.listSearchProduct![index].brands != null
                                                ? ProductApies.productApies.listSearchProduct![index].brands![0].name
                                                : ''
                                            : '',
                                        perfumeName: ProductApies.productApies.listSearchProduct?[index].title ?? '',
                                        perfumeRate: double.parse(
                                            ProductApies.productApies.listSearchProduct?[index].averageRating ?? '0.0'),
                                        rateCount:
                                            ProductApies.productApies.listSearchProduct?[index].ratingCount.toString() ?? '0',
                                        priceBeforeDiscount: ProductApies.productApies.listSearchProduct?[index].regularPrice ?? '',
                                        priceAfterDiscount: ProductApies.productApies.listSearchProduct?[index].salePrice ?? '',
                                        onTapBuy: () {
                                          print(ProductApies.productApies.listSearchProduct?[index].id.toString());
                                          Get.to(() => PerfumeDetailsScreen(
                                                productId: ProductApies.productApies.listSearchProduct?[index].id.toString(),
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
                        // else if (productController.getSearchProductDataData?.value.headers?.xWPTotal != 0) ...{
                        //   GestureDetector(
                        //     onTap: () {
                        //       setState(() {
                        //         _currentPage++;
                        //       });
                        //       ProductApies.productApies
                        //           .searchProduct(word: widget.word, pageNumber: _currentPage.toString())
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
      ),
    );
  }
}
