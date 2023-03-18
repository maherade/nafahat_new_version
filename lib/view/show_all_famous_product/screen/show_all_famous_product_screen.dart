import 'package:flutter_svg/svg.dart';
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

  String? selectedDropDown= 'ترتيب حسب الشهرة';
  int? currentPage;

  String categoryName = 'الأجهزة';
  String categoryId = '';

  String? order;
  String? orderBy;

  dropDown(String value) {
    switch (value) {
      case 'ترتيب حسب الشهرة':
        ProductApies.productApies.getProductData(
            pageNumber: '1',
            category: categoryId,
            order: 'asc',
            orderBy: 'popularity'
        );
        setState(() {
          order = 'asc';
          orderBy = 'popularity';
          currentPage = 0;
        });
        break;
      case 'ترتيب حسب معدل التقييم':
        ProductApies.productApies.getProductData(
            pageNumber: '1',
            category: categoryId,
            order: 'asc',
            orderBy: 'rating'
        );
        setState(() {
          order = 'asc';
          orderBy = 'rating';
          currentPage = 0;
        });
        break;
      case 'ترتيب حسب الأحدث':
        ProductApies.productApies.getProductData(
            pageNumber: '1',
            order: 'asc',
            category: categoryId,
            orderBy: 'date'
        );
        setState(() {
          order = 'asc';
          orderBy = 'date';
          currentPage = 0;
        });
        break;
      case 'ترتيب حسب الأدنى سعرا للأعلى':
        ProductApies.productApies.getProductData(
            pageNumber: '1',
            category: categoryId,
            order: 'desc',
            orderBy: 'price'
        );
        setState(() {
          order = 'desc';
          orderBy = 'price';
          currentPage = 0;
        });
        break;
      case 'ترتيب حسب الأعلى سعرا للأدنى':
        ProductApies.productApies.getProductData(
            pageNumber: '1',
            category: categoryId,
            order: 'desc',
            orderBy: 'price'
        );
        setState(() {
          order = 'asc';
          orderBy = 'price';
          currentPage = 0;
        });
        break;
    }
  }

  @override
  void initState() {
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

          return SingleChildScrollView(
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
                        'تسوق حسب الأقسام',
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
                              setState(() => categoryName = category[index].name!);
                              setState(() => categoryId = category[index].id.toString());
                              setState(() => selectedDropDown= 'ترتيب حسب الشهرة');
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
                            'تسوق من قسم $categoryName',
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
                                  'ترتيب حسب الشهرة',
                                  'ترتيب حسب معدل التقييم',
                                  'ترتيب حسب الأحدث',
                                  'ترتيب حسب الأدنى سعرا للأعلى',
                                  'ترتيب حسب الأعلى سعرا للأدنى',
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
                                  "الترتيب الإفتراضي",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                                onChanged: (String? value) {
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
                      product == null
                          ? const LoadingProduct(8)
                          : GridView.builder(
                        itemCount: product.length < 8 ? product.length : 8,
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
                            imgUrl: product[index].images?[0].src ?? '',
                            // brandName: 'brand',
                            brandName: product[index].brands!.isNotEmpty
                                ? product[index].brands != null
                                ? product[index].brands![0].name
                                : ''
                                : '',
                            perfumeName: product[index].title ?? '',
                            perfumeRate: double.parse(product[index].averageRating ?? '0.0'),
                            rateCount: product[index].ratingCount.toString() ?? '0',
                            priceBeforeDiscount: product[index].regularPrice ?? '',
                            priceAfterDiscount: product[index].salePrice ?? '',
                            onTapBuy: () {
                              Get.to(() => PerfumeDetailsScreen(
                                productId: product[index].id.toString(),
                              ));
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      productController.getProductData!.value.headers?.xWPTotalPages == null ? LoadingPaggination() : NumberPaginator(
                        // controller: _controller, cause exception
                        initialPage: currentPage??0,
                        numberPages: productController.getProductData!.value.headers!.xWPTotalPages!,
                        config: NumberPaginatorUIConfig(
                            contentPadding: EdgeInsets.zero,
                            buttonSelectedBackgroundColor: AppColors.primaryColor,
                            buttonUnselectedForegroundColor: AppColors.blackColor,
                            buttonShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r), side:const BorderSide(color: AppColors.greyBorder))),
                        onPageChange: (int index) {
                          setState(() {
                            currentPage = index;
                          });
                          ProductApies.productApies.getProductData(
                              category: categoryId ,pageNumber: (index+1).toString(),
                              order: order,
                              orderBy: orderBy
                          );
                        },
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              CustomText(
                                'أخر المشاهدات',
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
          );
        },
      ),
    );
  }
}
