import 'dart:convert';

import 'package:perfume_store_mobile_app/apies/auth_apies.dart';
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';
import 'package:perfume_store_mobile_app/controller/category_controller.dart';
import 'package:perfume_store_mobile_app/view/auth/screens/login_screen.dart';
import 'package:perfume_store_mobile_app/view/bottom_nav_screens/widget/category_item.dart';
import 'package:shimmer/shimmer.dart';
import '../../../apies/brand_apies.dart';
import '../../../apies/category_apies.dart';
import '../../../apies/product_apies.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../model/decode_token_response.dart';
import '../../../model/sub_category_product.dart';
import '../../../model/sub_category_response.dart';
import '../../../privacy_policy.dart';
import '../../../services/app_imports.dart';
import '../../../services/sp_helper.dart';
import '../../articles/screen/article_screen.dart';
import '../../custom_widget/Skelton.dart';
import '../../custom_widget/custom_rate_write_bar.dart';
import '../../custom_widget/loading_efffect/loading_brand.dart';
import '../../custom_widget/loading_efffect/loading_category.dart';
import '../../custom_widget/loading_efffect/loading_container_category.dart';
import '../../custom_widget/loading_efffect/loading_product.dart';
import '../../help_and_support/screen/help_and_support_screen.dart';
import '../../perfume_details/screens/perfume_details_screen.dart';
import '../../shop_by_brand/screen/shop_by_brand_screen.dart';
import '../../shop_by_category/screen/shop_by_category.dart';
import '../../show_all_famous_product/screen/show_all_famous_product_screen.dart';
import '../../show_all_gift_package/screen/show_all_gift_package_screen.dart';
import '../../show_all_product_less_than_100/screen/show_all_product_less_than_100_screen.dart';
import '../widget/brand_item.dart';
import '../widget/discount_perfeum_item.dart';
import '../widget/perfume_product_item.dart';
import '../widget/shopping_ad.dart';
import '../widget/shopping_ad2.dart';
import '../widget/shopping_ad3.dart';
import '../widget/slider_header_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryController categoryController = Get.find();
  BrandController brandController = Get.find();
  ProductController productController = Get.find();
  AuthController authController = Get.find();

  int _current = 0;
  int currentIndex = 0;

  bool popUpIsSelectedTextColor = false;

  String categoryName = 'الأجهزة';

 List<String> listAdImage = ['p1','p2','p3'];
 List<String> list2AdImage = ['m1','m2'];

  String decryptToken(token){
    final encodedPayload = token.split('.')[1];
    final payloadData =
    utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    print(payloadData);
    final payload = DecodeTokenResponse.fromJson(jsonDecode(payloadData));
    return payload.data!.user!.id!;
  }

 @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((_) {
    SPHelper.spHelper.getToken()!=null? AuthApis.authApis.getCustomerInformation(decryptToken(SPHelper.spHelper.getToken())) : print('null Token');
   CategoryApies.categoryApies.getCategoryData('0');
   BrandApies.brandApies.getBrandData();
   ProductApies.productApies.getFamousProductData(category: "27");
   ProductApies.productApies.getGiftPackageProductData(feature: true,pageNumber: '1');
   ProductApies.productApies.getWholeSaleProductData(onSale: true);
   ProductApies.productApies.getMakupProductData();
   ProductApies.productApies.getLessThanPriceProductResponseData(lessThan: '100',pageNumber: '1');
   });
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Obx(
            () {
              var auth = authController.getCustomerInformationData!.value;
              return auth.email == null ? const SizedBox() : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(50.w, 97.h, 10.w, 0),
                          items: [
                            PopupMenuItem(
                              value: 1,
                              child: CustomText(
                                "اتصل بنا",
                                fontSize: 14.sp,
                                color: popUpIsSelectedTextColor ? AppColors.primaryColor : AppColors.blackColor,
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: CustomText(
                                "المقالات",
                                fontSize: 14.sp,
                                color: popUpIsSelectedTextColor ? AppColors.primaryColor : AppColors.blackColor,
                              ),
                            ),
                            PopupMenuItem(
                              value: 3,
                              child: CustomText(
                                "سياسة الخصوصية",
                                fontSize: 14.sp,
                                color: popUpIsSelectedTextColor ? AppColors.primaryColor : AppColors.blackColor,
                              ),
                            ),
                            PopupMenuItem(
                              value: 4,
                              child: CustomText(
                                "تسجيل الخروج",
                                fontSize: 14.sp,
                                color: popUpIsSelectedTextColor ? AppColors.primaryColor : AppColors.blackColor,
                              ),
                            ),
                          ],
                          elevation: 0.0,
                        ).then((value) {
                          if (value != null) {
                            if (value == 1) {
                              Get.to(() => HelpAndSupportScreen());
                            } else if (value == 2) {
                              Get.to(() => const ArticlesScreen());
                            } else if (value == 3) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return dialoge(text: privacyPolicies,);
                                },
                              );
                            }else if (value == 4) {
                              SPHelper.spHelper.removeToken();
                              Get.offAll(() =>  LoginScreen());
                            }
                          }
                        });
                      },
                      child: CachedNetworkImageShare(
                        urlImage: auth.avatarUrl ?? '',
                        borderRadious: 0,
                        fit: BoxFit.cover,
                        heigthNumber: 39.h,
                        widthNumber: 39.w,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Column(
            children: [
              SizedBox(
                height: 44.h,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 250.h,
                    child: PageView.builder(
                      onPageChanged: (index) {
                        setState(() => _current = index);
                      },
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return SliderHeaderItem(
                          title: 'أفضل العروض والخصومات في متجر نفحات',
                          description:
                              'هذا النص هو مثال لنص يمكن أن يستبدل في  نفس  المساحة، لقد تم توليد هذا النص من  مولد النص العربى ',
                          imgUrl: 'https://pbs.twimg.com/media/D9dSwaVWsAADIY7.jpg',
                          onTapShopping: () {},
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [1, 2, 3].asMap().entries.map((entry) {
                      return Container(
                        width: 12.w,
                        height: 12.h,
                        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : AppColors.primaryColor)
                                .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Obx(
                () {
                  var brand = brandController.getBrandData!.value.listBrandResponse;
                  return brand == null
                      ? const LoadingBrand()
                      : SizedBox(
                          height: 50.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return BrandItem(
                                index: index,
                                imgUrl: brand[index].brandImage?[0] ?? '',
                                onTap: () {
                                  // Get.to(() => ShopByBrandScreen());
                                },
                              );
                            },
                          ),
                        );
                },
              ),
              SizedBox(
                height: 35.h,
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
                  Obx(
                    () {
                      var category = categoryController.getCategoryData!.value.listCategoryResponse;
                      return category == null
                          ? LoadingCategory()
                          : SizedBox(
                              height: 90.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: category.length -1,
                                itemBuilder: (context, index) {
                                  return CategoryItem(
                                    index: index,
                                    imgUrl: category[index].image?.src ?? '',
                                    title: category[index].name,
                                    onTap: () {
                                      productController.getListSubCategoryProductData?.value =
                                          ListSubCategoryProductResponse();
                                      Get.to(() => ShopByCategoryScreen(
                                            categoryId: category[index].id,
                                            categoryName: category[index].name,
                                          ));
                                    },
                                  );
                                },
                              ),
                            );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              ShoppingAd(
                adTitle: 'مهرجان الجمال خصومات تصل الى 50%',
                adImage: 'https://pngimg.com/uploads/perfume/perfume_PNG99988.png',
                onTapSopping: () {},
              ),
              SizedBox(
                height: 40.h,
              ),
              Obx(
                () {
                  var category = categoryController.getCategoryData!.value.listCategoryResponse;
                  var product = productController.getFamousProductData!.value.listFamousProductResponse;
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 21.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'أشهر المنتجات',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.to(()=>ShowAllFamousProductScreen());
                                },
                                child: CustomText(
                                  'عرض الكل',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      category == null
                          ? LoadingContainerCategory()
                          : SizedBox(
                              height: 50.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: category.length -1 ,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      index == 0
                                          ? SizedBox(
                                              width: 21.w,
                                            )
                                          : const SizedBox(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() => currentIndex = index);
                                          setState(() => categoryName = category[index].name!);
                                          ProductApies.productApies.getFamousProductData(
                                              category: category[index].id.toString(), onSale: true);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 38.h,
                                          width: 117.h,
                                          decoration: BoxDecoration(
                                              color:
                                                  currentIndex == index ? AppColors.primaryColor : AppColors.whiteColor,
                                              borderRadius: BorderRadius.circular(5.r),
                                              border: Border.all(color: AppColors.greyBorder)),
                                          child: CustomText(
                                            category[index].name,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                            color:  currentIndex == index ? AppColors.whiteColor : AppColors.greenText,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                      SizedBox(
                        height: 24.h,
                      ),
                      ShoppingAd2(
                        adTitle: 'أفضل العروض والخصومات في متجر نفحات',
                        adImage:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiZjqZiPHhz01pFiyTK5gymcx4bn7XilQgr4eu_cEhVrF7ZNKQIi0uSYytf1Vz940z0ZQ&usqp=CAU',
                        onTapShopping: () {},
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  'أشهر  منتجات $categoryName',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Get.to(()=>ShopByCategoryScreen(
                                        categoryName: categoryName,
                                        categoryId: 27,
                                      ));
                                    },
                                    child: CustomText(
                                      'عرض الكل',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            product == null
                                ?const LoadingProduct(2)
                                : SizedBox(
                              height: 430.h,
                                  child: ListView.separated(
                                      itemCount: product.length < 8 ? product.length : 8,
                                     scrollDirection: Axis.horizontal,

                                      itemBuilder: (_, index) {
                                        return PerfumeProductItem(
                                          imgUrl: product[index].images?[0].src ?? '',
                                          brandName: product[index].brands!.isNotEmpty
                                              ? product[index].brands != null
                                                  ? product[index].brands![0].name
                                                  : ''
                                              : '',
                                          perfumeName: product[index].name ?? '',
                                          perfumeRate: double.parse(product[index].averageRating ?? '0.0'),
                                          rateCount: product[index].ratingCount.toString() ?? '0',
                                          priceBeforeDiscount: product[index].regularPrice ?? '',
                                          priceAfterDiscount: product[index].salePrice ?? '',
                                          onTapBuy: () {
                                            print(product[index].id.toString());
                                            Get.to(() => PerfumeDetailsScreen(
                                                  productId: product[index].id.toString(),
                                                ));
                                          },
                                        );
                                      },
                                    separatorBuilder: (BuildContext context, int index) {return SizedBox(width: 10.w,); },
                                    ),
                                ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 40.h,
              ),
              ShoppingAd3(
                imgUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiZjqZiPHhz01pFiyTK5gymcx4bn7XilQgr4eu_cEhVrF7ZNKQIi0uSYytf1Vz940z0ZQ&usqp=CAU',
                adTitle: 'أفضل بكجات الهدايا في متجر نفحات',
                adDescription: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النص ',
                onTapSopping: () {},
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          'استكشف بكجات الهدايا',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.to(()=>ShowAllGiftPackageScreen());
                            },
                            child: CustomText(
                              'عرض الكل',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Obx(
                      () {
                        var product = productController.getGiftPackageProductData!.value.listGiftPackageProductResponse;
                        return product == null
                            ?const LoadingProduct(2): product.isEmpty ? CustomText('لا توجد منتجات تتوافق مع اختيارك.',fontSize: 15.sp,)
                            : GridView.builder(
                                itemCount: product.length < 2 ? product.length : 2,
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
                                    imgUrl: product[index].images?[0].src ?? '',
                                    brandName: product[index].brands!.isNotEmpty
                                        ? product[index].brands != null
                                            ? product[index].brands![0].name
                                            : ''
                                        : '',
                                    perfumeName: product[index].name ?? '',
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
                              );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 43.h,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Row(
                      children: [
                        CustomText(
                          'أشهر الماركات',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  height: 112.h,
                                  width: 203.w,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                  child: Image.asset('assets/images/brand1.png',fit: BoxFit.fill,)),
                            ),
                            SizedBox(width: 9.w,),
                            Container(
                                height: 118.h,
                                width: 123.w,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Image.asset('assets/images/brand2.png',fit: BoxFit.fill,)),

                          ],
                        ),
                        SizedBox(height: 27.h,),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  height: 134.h,
                                  width: 148.w,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                  child: Image.asset('assets/images/brand3.png',fit: BoxFit.fill,)),
                            ),
                            SizedBox(width: 9.w,),
                            Expanded(
                              child: Container(
                                  height: 134.h,
                                  width: 157.w,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Image.asset('assets/images/brand4.png',fit: BoxFit.fill,)),
                            ),

                          ],
                        ),
                        SizedBox(height: 27.h,),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  height: 104.h,
                                  width: 190.w,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Image.asset('assets/images/brand5.png',fit: BoxFit.fill,)),
                            ),
                            SizedBox(width: 9.w,),
                            Container(
                                height: 104.h,
                                width: 122.w,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Image.asset('assets/images/brand6.png',fit: BoxFit.fill,)),

                          ],
                        ),

                      ],
                    ),
                  )
                  // GridView.builder(
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     childAspectRatio: 2,
                  //     crossAxisCount: 2,
                  //     crossAxisSpacing: 11.w,
                  //     mainAxisSpacing: 16.h,
                  //   ),
                  //   itemBuilder: (_, index) {
                  //     return CachedNetworkImageShare(
                  //       urlImage: 'https://images.alwatanvoice.com/news/large/9999192429.jpg',
                  //       fit: BoxFit.cover,
                  //       heigthNumber: double.infinity,
                  //       widthNumber: double.infinity,
                  //       borderRadious: 8.r,
                  //     );
                  //   },
                  //   itemCount: 6,
                  // ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listAdImage.length,
                itemBuilder: (context, index) {
                  return DiscountPerfumeItem(
                    title: 'عطور رجالية',
                    discountPercent: '50%',
                    imgUrl: listAdImage[index],
                    onTapShoppingNow: () {},
                  );
                },
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          'أشهر منتجات البيع بالجملة',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: CustomText(
                              'عرض الكل',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            )),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Obx(
                      () {
                        var product = productController.getListWholeSaleResponseData!.value.listListWholeSaleResponse;
                        return product == null
                            ?const LoadingProduct(2)
                            : SizedBox(
                          height: 430.h,
                              child: ListView.separated(
                                  itemCount: product.length < 8 ? product.length : 8,
                                scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return PerfumeProductItem(
                                      imgUrl: product[index].images?[0].src ?? '',
                                      brandName: product[index].brands!.isNotEmpty
                                          ? product[index].brands != null
                                              ? product[index].brands![0].name
                                              : ''
                                          : '',
                                      perfumeName: product[index].name ?? '',
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
                                separatorBuilder: (BuildContext context, int index) {return SizedBox(width: 10.w,); },
                                ),
                            );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          'أكثر المنتجات مبيعاً في المكياج',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.to(()=>const ShopByCategoryScreen(
                                categoryId: 24,
                                categoryName: 'أكثر المنتجات مبيعا في المكياج',
                              ));
                            },
                            child: CustomText(
                              'عرض الكل',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            )),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Obx(
                      () {
                        var product = productController.getListMakupProductResponseData!.value.listMakupProductResponse;
                        return product == null
                            ?const LoadingProduct(2)
                            : SizedBox(
                          height: 430.h,
                              child: ListView.separated(
                                  itemCount: product.length < 8 ? product.length : 8,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return PerfumeProductItem(
                                      imgUrl: product[index].images?[0].src ?? '',
                                      brandName: product[index].brands!.isNotEmpty
                                          ? product[index].brands != null
                                              ? product[index].brands![0].name
                                              : ''
                                          : '',
                                      perfumeName: product[index].name ?? '',
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
                                separatorBuilder: (BuildContext context, int index) {return SizedBox(width: 10.w,); },
                                ),
                            );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list2AdImage.length,
                itemBuilder: (context, index) {
                  return ReverseDiscountPerfumeItem(
                    title: 'عطور رجالية',
                    discountPercent: '50%',
                    imgUrl: list2AdImage[index],
                    onTapShoppingNow: () {},
                  );
                },
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          'منتجات أٌقل من 100 ريال',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.to(()=>ShowAllProductLessThan100Screen());
                            },
                            child: CustomText(
                              'عرض الكل',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            )),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Obx(
                      () {
                        var product = productController.getListLessThanPriceProductResponseData!.value.listLessThanPriceProductResponse;
                        return product == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                               height: 430.h,
                              child: ListView.separated(
                                  itemCount: product.length < 8 ? product.length : 8,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return PerfumeProductItem(
                                      imgUrl: product[index].images?[0].src ?? '',
                                      brandName: product[index].brands!.isNotEmpty
                                          ? product[index].brands != null
                                              ? product[index].brands![0].name
                                              : ''
                                          : '',
                                      perfumeName: product[index].name ?? '',
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
                                  }, separatorBuilder: (BuildContext context, int index) {return SizedBox(width: 10.w,); },
                                ),
                            );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          )
        ],
      ),
    );
  }




}
