import 'package:flutter_svg/svg.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../apies/product_apies.dart';
import '../../../controller/category_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/loading_efffect/loading_paggination.dart';
import '../../custom_widget/loading_efffect/loading_product.dart';
import '../../filter/screens/filter_screen.dart';
import '../../perfume_details/screens/perfume_details_screen.dart';
import '../widget/perfume_product_item.dart';
import '../widget/shopping_ad3.dart';
class GiftScreen extends StatefulWidget {
  @override
  State<GiftScreen> createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> {
  @override
  ProductController productController = Get.find();

  String? selectedDropDown= 'ترتيب حسب الشهرة';
  int? currentPage;


  String? order;
  String? orderBy;

  dropDown(String value) {
    switch (value) {
      case 'ترتيب حسب الشهرة':
        ProductApies.productApies.getGiftPackageProductData(
            pageNumber: '1',
            order: 'asc',
            orderBy: 'popularity',
            feature: true
        );
        setState(() {
          order = 'asc';
          orderBy = 'popularity';
          currentPage = 0;
        });
        break;
      case 'ترتيب حسب معدل التقييم':
        ProductApies.productApies.getGiftPackageProductData(
            pageNumber: '1',
            feature: true,
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
        ProductApies.productApies.getGiftPackageProductData(
            pageNumber: '1',
            order: 'asc',
            feature: true,
            orderBy: 'date'
        );
        setState(() {
          order = 'asc';
          orderBy = 'date';
          currentPage = 0;
        });
        break;
      case 'ترتيب حسب الأدنى سعرا للأعلى':
        ProductApies.productApies.getGiftPackageProductData(
            pageNumber: '1',
            feature: true,
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
        ProductApies.productApies.getGiftPackageProductData(
            pageNumber: '1',
            feature: true,
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

  getData() async {
    ProductApies.productApies.getGiftPackageProductData(feature: true,pageNumber: '1',);
    ProductApies.productApies.getLastViewProduct();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var product = productController.getGiftPackageProductData!.value.listGiftPackageProductResponse;
        var lastViewedProduct = productController.getLastViewedProduct!.value.listLastViewedProductResponse;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              ShoppingAd3(
                imgUrl:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiZjqZiPHhz01pFiyTK5gymcx4bn7XilQgr4eu_cEhVrF7ZNKQIi0uSYytf1Vz940z0ZQ&usqp=CAU',
                adTitle: 'أفضل بكجات الهدايا في متجر نفحات',
                adDescription: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النص ',
                onTapSopping: () {},
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomText(
                          'استكشاف بكجات الهدايا',
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
                    // loadingProduct(),
                    product == null ?const LoadingProduct(8) : product.isEmpty ? Column(
                      children: [
                        SizedBox(height: 20.h,),
                        Center(child: CustomText('لا توجد منتجات تتوافق مع اختيارك.',fontSize: 15.sp,)),
                      ],
                    ): GridView.builder(
                      itemCount: product.length < 8 ? product.length : 8,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.52.h,
                        crossAxisCount: 2,
                        crossAxisSpacing: 11.w,
                        mainAxisSpacing: 16.h,
                      ),
                      itemBuilder: (_, index) {
                        return PerfumeProductItem(
                          imgUrl: product[index].images?[0].src??'',
                          brandName: product[index].brands!.isNotEmpty ? product[index].brands != null ? product[index].brands![0].name : '' : '',
                          perfumeName: product[index].name??'',
                          perfumeRate:  double.parse(product[index].averageRating??'0.0'),
                          rateCount: product[index].ratingCount.toString()?? '0',
                          priceBeforeDiscount: product[index].regularPrice??'',
                          priceAfterDiscount:  product[index].salePrice??'',
                          onTapBuy: (){
                            print(product[index].id.toString());
                            Get.to(()=>PerfumeDetailsScreen(productId: product[index].id.toString(),));
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    productController.getGiftPackageProductData!.value.totalPage == null ? LoadingPaggination() : product!.isEmpty ? SizedBox() : NumberPaginator(
                      // controller: _controller, cause exception
                      initialPage: currentPage??0,
                      numberPages: int.parse(productController.getGiftPackageProductData!.value.totalPage!),
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
                        ProductApies.productApies.getGiftPackageProductData(
                            feature: true , pageNumber: (index+1).toString(),
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
                            childAspectRatio: 0.52.h,
                            crossAxisCount: 2,
                            crossAxisSpacing: 11.w,
                            mainAxisSpacing: 16.h,
                          ),
                          itemBuilder: (_, index) {
                            return PerfumeProductItem(
                              imgUrl: lastViewedProduct[index].images?[0].src??'',
                              brandName: lastViewedProduct[index].brands!.isNotEmpty ? lastViewedProduct[index].brands != null ? lastViewedProduct[index].brands![0].name : '' : '',
                              perfumeName: lastViewedProduct[index].name??'',
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
    );
  }
}
