import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../apies/category_apies.dart';
import '../../../apies/product_apies.dart';
import '../../../controller/category_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../services/app_imports.dart';
import '../../bottom_nav_screens/widget/category_item.dart';
import '../../bottom_nav_screens/widget/perfume_product_item.dart';
import '../../custom_widget/loading_efffect/loading_category.dart';
import '../../custom_widget/loading_efffect/loading_paggination.dart';
import '../../custom_widget/loading_efffect/loading_product.dart';
import '../../filter/screens/filter_screen.dart';
import '../../perfume_details/screens/perfume_details_screen.dart';


class ShowAllFamousProductScreen extends StatefulWidget {
  @override
  State<ShowAllFamousProductScreen> createState() => _ShowAllFamousProductScreenState();
}

class _ShowAllFamousProductScreenState extends State<ShowAllFamousProductScreen> {
  CategoryController categoryController = Get.find();
  ProductController productController = Get.find();

  String? selectedDropDown= 'order_by_popularity_value'.tr;
  int _currentPage = 1;

  String categoryName = 'hardware_value'.tr;
  String categoryId = '';

  String? order;
  String? orderBy;

  void dropDown(String value) {
    if (value == 'order_by_popularity_value'.tr) {
      ProductApies.productApies.getProductData(
          pageNumber: '1', category: categoryId, order: 'asc', orderBy: 'popularity');
      setState(() {
        order = 'asc';
        orderBy = 'popularity';
      });
    } else if (value == 'order_by_rating_value'.tr) {
      ProductApies.productApies.getProductData(
          pageNumber: '1', category: categoryId, order: 'asc', orderBy: 'rating');
      setState(() {
        order = 'asc';
        orderBy = 'rating';
      });
    } else if (value == 'order_by_recent_value'.tr) {
      ProductApies.productApies.getProductData(
          pageNumber: '1', order: 'asc', category: categoryId, orderBy: 'date');
      setState(() {
        order = 'asc';
        orderBy = 'date';
      });
    } else if (value == 'order_by_min_to_height_price_value'.tr) {
      ProductApies.productApies.getProductData(
          pageNumber: '1', category: categoryId, order: 'desc', orderBy: 'price');
      setState(() {
        order = 'desc';
        orderBy = 'price';
      });
    } else if (value == 'order_by_height_to_min_price_value'.tr) {
      ProductApies.productApies.getProductData(
          pageNumber: '1', category: categoryId, order: 'desc', orderBy: 'price');
      setState(() {
        order = 'asc';
        orderBy = 'price';
      });
    }
  }


  @override
  void initState() {
    ProductApies.productApies.listProduct = null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      CategoryApies.categoryApies.getCategoryData('0');
      ProductApies.productApies.getProductData(pageNumber: '1',category: '27');
      ProductApies.productApies.getLastViewProduct();

    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () {
          var product = productController.getProductData!.value.data;
          var category = categoryController.getCategoryData!.value.listCategoryResponse;
          var lastViewedProduct = productController.getLastViewedProduct!.value.data;

          return LazyLoadScrollView(
            onEndOfPage: (){
              if (productController.getProductData?.value.headers?.xWPTotal != 0){
                setState(() {
                  _currentPage++;
                });
                ProductApies.productApies
                    .getProductData(
                  order: order,category: categoryId, orderBy: orderBy, pageNumber: _currentPage.toString(),)
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 21.0.w),
                        child: CustomText(
                          'shop_by_category_value'.tr,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      category == null
                          ? LoadingCategory()
                          : SizedBox(
                        height: 110.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: category.length -1,
                          itemBuilder: (context, index) {
                            return CategoryItem(
                              index: index,
                              imgUrl: category[index].image?.src ?? '',
                              title: category[index].name,
                              onTap: () {
                                ProductApies.productApies.listProduct = null;
                                setState(() => categoryName = category[index].name!);
                                setState(() => categoryId = category[index].id.toString());
                                setState(() => selectedDropDown= 'order_by_popularity_value'.tr);
                                ProductApies.productApies.getProductData(
                                    category: category[index].id.toString(),pageNumber: '1');
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomText(
                              'shop_from_category_value'.tr +'$categoryName',
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
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
                                    ProductApies.productApies.listProduct = null;
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
                        ProductApies.productApies.listProduct == null
                            ? const LoadingProduct(8)
                            : ProductApies.productApies.listProduct!.isEmpty
                            ? Container(
                          margin: EdgeInsets.only(top: 50.h),
                          child: CustomText(
                            'no_item_found_value'.tr,
                            fontSize: 18.sp,
                          ),
                        )
                            : GridView.builder(
                          itemCount: ProductApies.productApies.listProduct?.length ,
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
                              id: ProductApies.productApies.listProduct?[index].id.toString(),
                              imgUrl: ProductApies.productApies.listProduct?[index].images?[0].src ?? '',
                              // brandName: 'brand',
                              brandName: ProductApies.productApies.listProduct![index].brands!.isNotEmpty
                                  ? ProductApies.productApies.listProduct![index].brands != null
                                  ? ProductApies.productApies.listProduct![index].brands![0].name
                                  : ''
                                  : '',
                              perfumeName: ProductApies.productApies.listProduct?[index].title ?? '',
                              perfumeRate: double.parse(ProductApies.productApies.listProduct?[index].averageRating ?? '0.0'),
                              rateCount: ProductApies.productApies.listProduct?[index].ratingCount.toString() ?? '0',
                              priceBeforeDiscount: ProductApies.productApies.listProduct?[index].regularPrice ?? '',
                              priceAfterDiscount: ProductApies.productApies.listProduct?[index].salePrice ?? '',
                              onTapBuy: () {
                                Get.to(() => PerfumeDetailsScreen(
                                  productId: ProductApies.productApies.listProduct?[index].id.toString(),
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
                        // else if (productController.getProductData?.value.headers?.xWPTotal != 0) ...{
                        //   GestureDetector(
                        //     onTap: () {
                        //       setState(() {
                        //         _currentPage++;
                        //       });
                        //       ProductApies.productApies
                        //           .getProductData(
                        //         order: order,category: categoryId, orderBy: orderBy, pageNumber: _currentPage.toString(),)
                        //           .then((value) {
                        //         print('_currentPage ');
                        //       });
                        //
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
                            lastViewedProduct == null ? LoadingProduct(2) :  GridView.builder(
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
                                  id:  lastViewedProduct[index].id.toString(),
                                  imgUrl: lastViewedProduct[index].images?[0].src??'',
                                  brandName: lastViewedProduct[index].brands!.isNotEmpty ? lastViewedProduct[index].brands != null ? lastViewedProduct[index].brands![0].name : '' : '',
                                  perfumeName: lastViewedProduct[index].title??'',
                                  perfumeRate:  double.parse(lastViewedProduct[index].averageRating??'0.0'),
                                  rateCount: lastViewedProduct[index].ratingCount.toString()?? '0',
                                  priceBeforeDiscount: lastViewedProduct[index].regularPrice??'',
                                  priceAfterDiscount:  lastViewedProduct[index].salePrice??'',
                                  onTapBuy: (){
                                    print(lastViewedProduct[index].id.toString());
                                    Get.to(()=>PerfumeDetailsScreen(productId: lastViewedProduct[index].id.toString(),));
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

