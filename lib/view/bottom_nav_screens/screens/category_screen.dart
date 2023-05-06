import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:perfume_store_mobile_app/apies/brand_apies.dart';
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';
import 'package:perfume_store_mobile_app/view/perfume_details/screens/perfume_details_screen.dart';
import 'package:perfume_store_mobile_app/view/shop_by_brand/screen/shop_by_brand_screen.dart';
import 'package:perfume_store_mobile_app/view/shop_by_category/screen/shop_by_category.dart';

import '../../../apies/category_apies.dart';
import '../../../apies/product_apies.dart';
import '../../../controller/category_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/custom_search_bar.dart';

import '../../search/screen/search_screen.dart';
import '../widget/category_item.dart';
import '../widget/perfume_product_item.dart';
import '../widget/vertical_category_item.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController categoryController = Get.find();
  ProductController productController = Get.find();
  BrandController brandController = Get.find();


  ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  int expandedIndex = -1;
  int lastOne = -1;


 int? selectedSubCategoryId = 1877;
 String? selectedSubCategoryName = '';

  @override
  void initState() {
    ProductApies.productApies.listProduct = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CategoryApies.categoryApies.getCategoryData('0');
      CategoryApies.categoryApies.getSubCategoryData('24');
      ProductApies.productApies.getProductData(pageNumber: '1', category: '27');
      BrandApies.brandApies.getBrandData(categoryID: '24');
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int selectAdNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var product = productController.getProductData!.value.data;
        var category = categoryController.getCategoryData!.value.listCategoryResponse;
        var subCategory = categoryController.getSubCategoryData!.value.listSubCategoryResponse;
        var brand = brandController.getBrandData!.value.listBrandResponse;
        var ads = productController.getAdsData?.value.listAdsResponse;

        return SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearchBar(
                    hintText: 'search_by_product_value'.tr,
                    controller: searchController,
                    onTapSearch: () {
                      Get.to(() => SearchScreen(
                        word: searchController.text,
                      ));
                    },
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                 Padding(
                   padding:  EdgeInsets.symmetric(horizontal: 18.0.w),
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Expanded(child: category == null
                           ? CupertinoActivityIndicator()
                           : SizedBox(
                         child: ListView.builder(
                           padding: EdgeInsets.zero,
                           shrinkWrap: true,
                           physics: NeverScrollableScrollPhysics(),
                           itemCount: category.length < 6 ? category.length : 6,
                           itemBuilder: (context, index) {
                             return VerticalCategoryItem(
                               index: index,
                               imgUrl: category[index].image?.src ?? '',
                               title: category[index].name,
                               onTap: () {
                                 print(index);
                                 setState(() {
                                   switch(index){
                                     case 0:
                                       selectAdNumber = 1;
                                       break;
                                     case 1:
                                       selectAdNumber = 6;
                                       break;
                                     case 2:
                                       selectAdNumber = 5;
                                       break;
                                     case 3:
                                       selectAdNumber = 6;
                                       break;
                                     case 4:
                                       selectAdNumber = 7;
                                       break;
                                     case 5:
                                       selectAdNumber = 2;
                                       break;
                                   }

                                 });
                                 BrandApies.brandApies.getBrandData(categoryID: category[index].id.toString());
                                 CategoryApies.categoryApies.getSubCategoryData(category[index].id.toString());
                               },
                             );
                           },
                         ),
                       )),
                       SizedBox(width: 15.w,),
                       Expanded(flex: 2,child: Column(
                         children: [
                           SizedBox(
                             height: 120.h,
                             child: SizedBox(
                               height: 200.h,
                               child: ClipRRect(
                                 // borderRadius: BorderRadius.circular(15),
                                 child: CachedNetworkImageShare(
                                   urlImage:  ads?[selectAdNumber].image ?? '',
                                   widthNumber: double.infinity,
                                   heigthNumber: 50,
                                  borderRadious: 3,
                                   fit: BoxFit.fill,
                                 ),
                               ),
                             ),
                           ),
                           SizedBox(height: 10.h,),
                           subCategory == null ? CupertinoActivityIndicator() : subCategory.isEmpty ? CustomText('select_from_category_value'.tr):Container(
                             padding: EdgeInsets.all(5.w),
                             decoration: BoxDecoration(
                               border: Border.all( color: AppColors.greyBorder),
                             ),
                             child: ListView.builder(
                               padding: EdgeInsets.zero,
                               itemCount: subCategory.length,
                               shrinkWrap: true,
                               physics: const NeverScrollableScrollPhysics(),
                               itemBuilder: (context, index) {

                               return ExpansionTile(
                                 key: index == lastOne ? const Key("selected") : Key(index.toString()),
                                 initiallyExpanded: index == expandedIndex,
                                 onExpansionChanged: (value) {
                                   setState(() {
                                     lastOne = expandedIndex;
                                     selectedSubCategoryId = subCategory[index].id;
                                     selectedSubCategoryName = subCategory[index].name;
                                   });
                                   print(index);
                                   print(lastOne);
                                   if(value){
                                     expandedIndex = index;
                                   }else {
                                     expandedIndex = -1;
                                   }

                                   ProductApies.productApies.getProductData(pageNumber: '1', category: subCategory[index].id.toString());

                                 },
                                 title: CustomText(subCategory[index].name,fontSize: 12.sp,),children: [
                                 SizedBox(height: 10.h,),

                                   product == null ? CupertinoActivityIndicator() : GridView.builder(
                                     padding: EdgeInsets.zero,
                                     itemCount: product.length > 4 ? 4 : product.length,
                                     shrinkWrap: true,
                                     physics: const NeverScrollableScrollPhysics(),
                                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                       childAspectRatio: 0.58.h,
                                       crossAxisCount: 2,
                                       crossAxisSpacing: 11.w,
                                       mainAxisSpacing: 16.h,
                                     ),
                                     itemBuilder: (_, index) {
                                       return GestureDetector(
                                         onTap: (){
                                           Get.to(()=>ShopByCategoryScreen(
                                             categoryId:  selectedSubCategoryId,
                                             categoryName: selectedSubCategoryName,
                                           ));
                                         },
                                         child: Column(
                                           children: [
                                             Container(
                                               padding: EdgeInsets.all(10.w),
                                               decoration: BoxDecoration(
                                                 border: Border.all( color: AppColors.greyBorder),
                                               ),
                                               child: CachedNetworkImageShare(urlImage: product[index].images?[0].src.toString(),fit: BoxFit.fill,
                                                 heigthNumber: 100.h,widthNumber: double.infinity,borderRadious: 5,),
                                             ),
                                             SizedBox(height: 5.h,),
                                             CustomText( product[index].title,fontSize: 11.sp,maxLines: 1,)
                                           ],
                                         ),
                                       );
                                     },
                                   )

                               ],);
                             },),
                           ),
                           SizedBox(height: 20.h,),
                           brand == null ? CupertinoActivityIndicator() :     Container(
                             padding: EdgeInsets.all(5.w),
                             decoration: BoxDecoration(
                               border: Border.all( color: AppColors.greyBorder),
                             ),
                             child: ExpansionTile(
                               onExpansionChanged: (value) {
                               },
                               title: CustomText('famous_brand_value'.tr,fontSize: 12.sp,),children: [
                               SizedBox(height: 10.h,),

                                GridView.builder(
                                 padding: EdgeInsets.zero,
                                 itemCount: brand.length > 100 ? 100 : brand.length,
                                 shrinkWrap: true,
                                 physics: const NeverScrollableScrollPhysics(),
                                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                   childAspectRatio: 0.80.h,
                                   crossAxisCount: 3,
                                   crossAxisSpacing: 11.w,
                                   mainAxisSpacing: 16.h,
                                 ),
                                 itemBuilder: (_, index) {
                                   return Column(
                                     children: [
                                       GestureDetector(
                                         onTap: (){
                                           Get.to(ShopByBrandScreen(
                                             brandId: int.parse(brand[index].data!.termId!),
                                             brandName: brand[index].data?.name,
                                           ));
                                         },
                                         child: Container(
                                           padding: EdgeInsets.all(10.w),
                                           decoration: BoxDecoration(
                                             border: Border.all( color: AppColors.greyBorder),
                                           ),
                                           child: CachedNetworkImageShare(urlImage: brand[index].logo,fit: BoxFit.fill,
                                             heigthNumber: 50.h,widthNumber: 50.w,borderRadious: 5,),
                                         ),
                                       ),
                                     ],
                                   );
                                 },
                               )

                             ],),
                           )
                         ],
                       ))
                     ],
                   ),
                 )
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 18.0.w),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           CustomText(
              //             'تسوق من قسم $categoryName',
              //             fontWeight: FontWeight.bold,
              //             fontSize: 13.sp,
              //           ),
              //           const Spacer(),
              //           DecoratedBox(
              //             decoration: BoxDecoration(
              //               border: Border.all(color: const Color(0xffF5E7EA), width: 1),
              //               borderRadius: BorderRadius.circular(5),
              //             ),
              //             child: Padding(
              //               padding: EdgeInsets.symmetric(horizontal: 7.0.w),
              //               child: DropdownButton<String>(
              //                 underline: SizedBox(),
              //                 focusColor: Colors.white,
              //                 value: selectedDropDown,
              //                 style: TextStyle(color: Colors.white, fontSize: 10.sp),
              //                 iconEnabledColor: Colors.black,
              //                 items: <String>[
              //                   'ترتيب حسب الشهرة',
              //                   'ترتيب حسب معدل التقييم',
              //                   'ترتيب حسب الأحدث',
              //                   'ترتيب حسب الأدنى سعرا للأعلى',
              //                   'ترتيب حسب الأعلى سعرا للأدنى',
              //                 ].map<DropdownMenuItem<String>>((String value) {
              //                   return DropdownMenuItem<String>(
              //                     value: value,
              //                     child: CustomText(
              //                       value,
              //                       fontSize: 10.sp,
              //                     ),
              //                   );
              //                 }).toList(),
              //                 hint: CustomText(
              //                   "الترتيب الإفتراضي",
              //                   fontSize: 12.sp,
              //                   fontWeight: FontWeight.normal,
              //                 ),
              //                 onChanged: (String? value) {
              //                   ProductApies.productApies.listProduct = null;
              //                   dropDown(value!);
              //                   setState(() {
              //                     selectedDropDown = value;
              //                   });
              //                 },
              //               ),
              //             ),
              //           ),
              //           SizedBox(
              //             width: 12.w,
              //           ),
              //           GestureDetector(
              //             onTap: () {
              //               Get.to(() => FilterScreen());
              //             },
              //             child: SvgPicture.asset(
              //               'assets/svg/filter.svg',
              //               fit: BoxFit.contain,
              //             ),
              //           ),
              //         ],
              //       ),
              //       ProductApies.productApies.listProduct == null
              //           ? const LoadingProduct(8)
              //           : ProductApies.productApies.listProduct!.isEmpty
              //           ? Container(
              //         margin: EdgeInsets.only(top: 50.h),
              //         child: CustomText(
              //           'لا توجد عناصر',
              //           fontSize: 18.sp,
              //         ),
              //       )
              //           : GridView.builder(
              //               itemCount: ProductApies.productApies.listProduct?.length,
              //               shrinkWrap: true,
              //               physics: const BouncingScrollPhysics(),
              //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //                 childAspectRatio: 0.45.h,
              //                 crossAxisCount: 2,
              //                 crossAxisSpacing: 11.w,
              //                 mainAxisSpacing: 16.h,
              //               ),
              //               itemBuilder: (_, index) {
              //                 return PerfumeProductItem(
              //                   imgUrl: ProductApies.productApies.listProduct?[index].images?[0].src ?? '',
              //                   brandName: ProductApies.productApies.listProduct![index].brands!.isNotEmpty
              //                       ? ProductApies.productApies.listProduct![index].brands != null
              //                           ? ProductApies.productApies.listProduct![index].brands![0].name
              //                           : ''
              //                       : '',
              //                   perfumeName: ProductApies.productApies.listProduct?[index].title ?? '',
              //                   perfumeRate: double.parse(ProductApies.productApies.listProduct?[index].averageRating ?? '0.0'),
              //                   rateCount: ProductApies.productApies.listProduct?[index].ratingCount.toString() ?? '0',
              //                   priceBeforeDiscount: ProductApies.productApies.listProduct?[index].regularPrice ?? '',
              //                   priceAfterDiscount: ProductApies.productApies.listProduct?[index].salePrice ?? '',
              //                   onTapBuy: () {
              //                     Get.to(() => PerfumeDetailsScreen(
              //                           productId: ProductApies.productApies.listProduct?[index].id.toString(),
              //                         ));
              //                   },
              //                 );
              //               },
              //             ),
              //       SizedBox(
              //         height: 40.h,
              //       ),
              //       if (product == null) ...{
              //         CupertinoActivityIndicator()
              //       } else if (productController.getProductData?.value.headers?.xWPTotal != 0) ...{
              //         GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               _currentPage++;
              //             });
              //             if (productController.getProductData?.value.headers?.xWPTotal != 0) {
              //               ProductApies.productApies
              //                   .getProductData(
              //                       order: order, category: categoryId, orderBy: orderBy, pageNumber: _currentPage.toString())
              //                   .then((value) {
              //                 print('_currentPage ');
              //               });
              //             }
              //           },
              //           child: Container(
              //               padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              //               decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10.r)),
              //               child: CustomText(
              //                 'عرض المزيد',
              //                 fontSize: 13.sp,
              //                 fontWeight: FontWeight.normal,
              //               )),
              //         )
              //       } else ...{
              //         SizedBox()
              //       },
              //       SizedBox(
              //         height: 40.h,
              //       ),
              //       Column(
              //         children: [
              //           Row(
              //             children: [
              //               CustomText(
              //                 'أخر المشاهدات',
              //                 fontSize: 16.sp,
              //                 fontWeight: FontWeight.normal,
              //               ),
              //             ],
              //           ),
              //           lastViewedProduct == null
              //               ? LoadingProduct(2)
              //               : GridView.builder(
              //                   itemCount: lastViewedProduct.length,
              //                   shrinkWrap: true,
              //                   physics: const NeverScrollableScrollPhysics(),
              //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //                     childAspectRatio: 0.45.h,
              //                     crossAxisCount: 2,
              //                     crossAxisSpacing: 11.w,
              //                     mainAxisSpacing: 16.h,
              //                   ),
              //                   itemBuilder: (_, index) {
              //                     return PerfumeProductItem(
              //                       imgUrl: lastViewedProduct[index].images?[0].src ?? '',
              //                       brandName: lastViewedProduct[index].brands!.isNotEmpty
              //                           ? lastViewedProduct[index].brands != null
              //                               ? lastViewedProduct[index].brands![0].name
              //                               : ''
              //                           : '',
              //                       perfumeName: lastViewedProduct[index].title ?? '',
              //                       perfumeRate: double.parse(lastViewedProduct[index].averageRating ?? '0.0'),
              //                       rateCount: lastViewedProduct[index].ratingCount.toString() ?? '0',
              //                       priceBeforeDiscount: lastViewedProduct[index].regularPrice ?? '',
              //                       priceAfterDiscount: lastViewedProduct[index].salePrice ?? '',
              //                       onTapBuy: () {
              //                         print(lastViewedProduct[index].id.toString());
              //                         Get.to(() => PerfumeDetailsScreen(
              //                               productId: lastViewedProduct[index].id.toString(),
              //                             ));
              //                       },
              //                     );
              //                   },
              //                 ),
              //         ],
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        );
      },
    );
  }
}
