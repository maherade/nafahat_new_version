import 'dart:convert';
import 'dart:math';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:perfume_store_mobile_app/apies/auth_apies.dart';
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';
import 'package:perfume_store_mobile_app/controller/category_controller.dart';
import 'package:perfume_store_mobile_app/view/auth/screens/login_screen.dart';
import 'package:perfume_store_mobile_app/view/bottom_nav_screens/widget/category_item.dart';
import 'package:perfume_store_mobile_app/view/search/screen/search_screen.dart';
import '../../../apies/brand_apies.dart';
import '../../../apies/category_apies.dart';
import '../../../apies/product_apies.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../model/decode_token_response.dart';
import '../../../model/sub_category_product.dart';
import '../../../services/app_imports.dart';
import '../../../services/sp_helper.dart';
import '../../articles/screen/article_screen.dart';
import '../../custom_widget/custom_search_bar.dart';
import '../../custom_widget/loading_efffect/loading_brand.dart';
import '../../custom_widget/loading_efffect/loading_category.dart';
import '../../custom_widget/loading_efffect/loading_container_category.dart';
import '../../custom_widget/loading_efffect/loading_product.dart';
import '../../help_and_support/screen/help_and_support_screen.dart';
import '../../perfume_details/screens/perfume_details_screen.dart';
import '../../privacy_policy_screen.dart';
import '../../shop_by_brand/screen/shop_by_brand_screen.dart';
import '../../shop_by_category/screen/shop_by_category.dart';
import '../../show_all_care_product/screen/show_all_care_product_screen.dart';
import '../../show_all_famous_product/screen/show_all_famous_product_screen.dart';
import '../../show_all_gift_package/screen/show_all_gift_package_screen.dart';
import '../../show_all_product_less_than_100/screen/show_all_product_less_than_100_screen.dart';
import '../../who_us/who_us_screen.dart';
import '../widget/brand_item.dart';
import '../widget/perfume_product_item.dart';

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

  List<String> listAdImage = ['p1', 'p2', 'p3'];
  List<String> list2AdImage = ['m1', 'm2'];

  String decryptToken(token) {
    final encodedPayload = token.split('.')[1];
    final payloadData =
        utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    print(payloadData);
    final payload = DecodeTokenResponse.fromJson(jsonDecode(payloadData));
    return payload.data!.user!.id!;
  }

  @override
  void initState() {

    super.initState();
  }

  TextEditingController searchController = TextEditingController();

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
          Padding(
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
                            color: popUpIsSelectedTextColor
                                ? AppColors.primaryColor
                                : AppColors.blackColor,
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: CustomText(
                            "المقالات",
                            fontSize: 14.sp,
                            color: popUpIsSelectedTextColor
                                ? AppColors.primaryColor
                                : AppColors.blackColor,
                          ),
                        ),
                        PopupMenuItem(
                          value: 3,
                          child: CustomText(
                            "سياسة الخصوصية",
                            fontSize: 14.sp,
                            color: popUpIsSelectedTextColor
                                ? AppColors.primaryColor
                                : AppColors.blackColor,
                          ),
                        ),
                        PopupMenuItem(
                          value: 4,
                          child: CustomText(
                            "من نحن",
                            fontSize: 14.sp,
                            color: popUpIsSelectedTextColor
                                ? AppColors.primaryColor
                                : AppColors.blackColor,
                          ),
                        ),
                        PopupMenuItem(
                          value: 5,
                          child: CustomText(
                            SPHelper.spHelper.getToken() != null
                                ? "تسجيل الخروج"
                                : 'تسجيل الدخول',
                            fontSize: 14.sp,
                            color: popUpIsSelectedTextColor
                                ? AppColors.primaryColor
                                : AppColors.blackColor,
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
                          Get.to(PrivacyPolicyScreen());
                        } else if (value == 4) {
                          Get.to(() => WhoUsScreen());
                        } else if (value == 5) {
                          SPHelper.spHelper.removeToken();
                          Get.offAll(() => LoginScreen());
                        }
                      }
                    });
                  },
                  child: Container(
                      height: 45.h,
                      width: 45.w,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      )),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              CustomSearchBar(
                hintText: 'ابحث عن منتج..',
                controller: searchController,
                onTapSearch: () {
                  Get.to(() => SearchScreen(
                        word: searchController.text,
                      ));
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () {
                  var ads = productController.getAdsData?.value.listAdsResponse;
                  return Column(
                    children: [
                      SizedBox(
                        height: 180.h,
                        child: PageView.builder(
                          onPageChanged: (index) {
                            setState(() => _current = index);
                          },
                          itemCount: ads?.length,
                          itemBuilder: (context, index) {
                            return  GestureDetector(
                              onTap: (){
                                Get.to(()=>ShopByBrandScreen(
                                  brandId: ads?[index].brand?[0].termId,
                                  brandName: ads?[index].brand?[0].name,
                                ),
                                );
                              },
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20.w),
                                      child: SizedBox(
                                        height: 200.h,
                                        child: ClipRRect(
                                          // borderRadius: BorderRadius.circular(15),
                                          child: FancyShimmerImage(
                                            imageUrl: ads?[index].image ?? '',
                                            width: double.infinity,
                                            height: 50,
                                            shimmerBaseColor: Color(
                                                    (Random().nextDouble() *
                                                            0xFFFFFF)
                                                        .toInt())
                                                .withOpacity(1.0),
                                            shimmerHighlightColor: Color(
                                                    (Random().nextDouble() *
                                                            0xFFFFFF)
                                                        .toInt())
                                                .withOpacity(1.0),
                                            shimmerBackColor: Color(
                                                    (Random().nextDouble() *
                                                            0xFFFFFF)
                                                        .toInt())
                                                .withOpacity(1.0),

                                            errorWidget: SizedBox(),
                                          ),
                                        ),
                                      ),
                                    ),
                                );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                     ads==null ? SizedBox(): Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: ads.asMap().entries.map((entry) {
                          return Container(
                            width: 12.w,
                            height: 12.h,
                            padding: EdgeInsets.symmetric(
                                vertical: 6.h, horizontal: 6.w),
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : AppColors.primaryColor)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 40.h,
              ),
              Obx(
                () {
                  var brand =
                      brandController.getBrandData!.value.listBrandResponse;
                  return brand == null
                      ? const LoadingBrand()
                      : SizedBox(
                          height: 50.h,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return BrandItem(
                                index: index,
                                imgUrl: brand[index].brandImage?[0] ?? '',
                                onTap: () {
                                  Get.to(() => ShopByBrandScreen(
                                        brandId: brand[index].termId,
                                        brandName: brand[index].name,
                                      ));
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Obx(
                    () {
                      var category = categoryController
                          .getCategoryData!.value.listCategoryResponse;
                      return category == null
                          ? LoadingCategory()
                          : SizedBox(
                              height: 120.h,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    category.length < 6 ? category.length : 6,
                                itemBuilder: (context, index) {
                                  return CategoryItem(
                                    index: index,
                                    imgUrl: category[index].image?.src ?? '',
                                    title: category[index].name,
                                    onTap: () {
                                      productController
                                              .getListSubCategoryProductData
                                              ?.value =
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
                height: 10.h,
              ),
              Obx(
                () {
                  var ads = productController.getAdsData?.value.listAdsResponse;

                  return SizedBox(
                    height: 150.h,
                    child: GestureDetector(
                      onTap: (){
                        Get.to(()=>const ShopByCategoryScreen(
                          categoryId: 183,
                          categoryName: 'بكجات الهدايا',
                        ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          height: 200.h,
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(15),
                            child: FancyShimmerImage(
                              imageUrl: ads?[1].image ?? '',
                              width: double.infinity,
                              height: 50,
                              shimmerBaseColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              shimmerHighlightColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              shimmerBackColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              errorWidget: SizedBox(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () {
                  var ads = productController.getAdsData?.value.listAdsResponse;
                  return SizedBox(
                    height: 150.h,
                    child: GestureDetector(
                      onTap: (){
                        Get.to(()=>ShopByBrandScreen(
                          brandId: ads?[2].brand?[0].termId,
                          brandName: ads?[2].brand?[0].name,
                        ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          height: 200.h,
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(15),
                            child: FancyShimmerImage(
                              imageUrl: ads?[2].image ?? '',
                              width: double.infinity,
                              height: 50,
                              shimmerBaseColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              shimmerHighlightColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              shimmerBackColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              errorWidget: SizedBox(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(
                () {
                  var category = categoryController
                      .getCategoryData!.value.listCategoryResponse;
                  var product =
                      productController.getFamousProductData!.value.data;
                  var ads = productController.getAdsData?.value.listAdsResponse;

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 21.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'الأفضل مبيعا',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => ShowAllFamousProductScreen());
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
                      SizedBox(
                        height: 150.h,
                        child:  GestureDetector(
                          onTap: (){
                            Get.to(()=>ShopByBrandScreen(
                              brandId: ads?[2].brand?[0].termId,
                              brandName: ads?[2].brand?[0].name,
                            ),
                            );
                          },
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 20.w),
                            child: SizedBox(
                              height: 200.h,
                              child: ClipRRect(
                                // borderRadius: BorderRadius.circular(15),
                                child: FancyShimmerImage(
                                  imageUrl: ads?[3].image ?? '',
                                  width: double.infinity,
                                  height: 50,
                                  shimmerBaseColor: Color(
                                      (Random().nextDouble() *
                                          0xFFFFFF)
                                          .toInt())
                                      .withOpacity(1.0),
                                  shimmerHighlightColor: Color(
                                      (Random().nextDouble() *
                                          0xFFFFFF)
                                          .toInt())
                                      .withOpacity(1.0),
                                  shimmerBackColor: Color(
                                      (Random().nextDouble() *
                                          0xFFFFFF)
                                          .toInt())
                                      .withOpacity(1.0),
                                  errorWidget: SizedBox(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      category == null
                          ? LoadingContainerCategory()
                          : SizedBox(
                              height: 70.h,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    category.length < 6 ? category.length : 6,
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
                                          setState(() => categoryName =
                                              category[index].name!);
                                          ProductApies.productApies
                                              .getFamousProductData(
                                                  category: category[index]
                                                      .id
                                                      .toString(),
                                                  onSale: true);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 70.h,
                                          width: 80.h,
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                              color: currentIndex == index
                                                  ? AppColors.primaryColor
                                                  : AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              border: Border.all(
                                                  color: AppColors.greyBorder)),
                                          child: CustomText(
                                            category[index].name,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            textAlign: TextAlign.center,
                                            color: currentIndex == index
                                                ? AppColors.whiteColor
                                                : AppColors.greenText,
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  'الأفضل مبيعا في $categoryName',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Get.to(() => ShopByCategoryScreen(
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
                                ? const LoadingProduct(2)
                                : SizedBox(
                                    height: 430.h,
                                    child: ListView.separated(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: product.length < 8
                                          ? product.length
                                          : 8,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (_, index) {
                                        return PerfumeProductItem(
                                          imgUrl:
                                              product[index].images?[0].src ??
                                                  '',
                                          brandName: product[index]
                                                  .brands!
                                                  .isNotEmpty
                                              ? product[index].brands != null
                                                  ? product[index]
                                                      .brands![0]
                                                      .name
                                                  : ''
                                              : '',
                                          perfumeName:
                                              product[index].title ?? '',
                                          perfumeRate: double.parse(
                                              product[index].averageRating ??
                                                  '0.0'),
                                          rateCount: product[index]
                                                  .ratingCount
                                                  .toString() ??
                                              '0',
                                          priceBeforeDiscount:
                                              product[index].regularPrice ?? '',
                                          priceAfterDiscount:
                                              product[index].salePrice ?? '',
                                          onTapBuy: () {
                                            print(product[index].id.toString());
                                            Get.to(() => PerfumeDetailsScreen(
                                                  productId: product[index]
                                                      .id
                                                      .toString(),
                                                ));
                                          },
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          width: 10.w,
                                        );
                                      },
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
              Obx(
                () {
                  var ads = productController.getAdsData?.value.listAdsResponse;
                  return SizedBox(
                    height: 140.h,
                    child:GestureDetector(
                      onTap: (){
                        Get.to(()=>ShopByBrandScreen(
                          brandId: ads?[0].brand?[0].termId,
                          brandName: ads?[0].brand?[0].name,
                        ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          height: 200.h,
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(15),
                            child: FancyShimmerImage(
                              imageUrl: ads?[0].image ?? '',
                              width: double.infinity,
                              height: 50,
                              shimmerBaseColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              shimmerHighlightColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              shimmerBackColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              errorWidget: SizedBox(),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                          'استكشف بكجات الهدايا',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.to(() => ShowAllGiftPackageScreen());
                            },
                            child: CustomText(
                              'عرض الكل',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Obx(
                      () {
                        var product = productController
                            .getGiftPackageProductData!.value.data;
                        return product == null
                            ? const LoadingProduct(2)
                            : product.isEmpty
                                ? CustomText(
                                    'لا توجد منتجات تتوافق مع اختيارك.',
                                    fontSize: 15.sp,
                                  )
                                : GridView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        product.length < 2 ? product.length : 2,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.45.h,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 11.w,
                                      mainAxisSpacing: 16.h,
                                    ),
                                    itemBuilder: (_, index) {
                                      return PerfumeProductItem(
                                        imgUrl:
                                            product[index].images?[0].src ?? '',
                                        brandName: product[index]
                                                .brands!
                                                .isNotEmpty
                                            ? product[index].brands != null
                                                ? product[index].brands![0].name
                                                : ''
                                            : '',
                                        perfumeName: product[index].title ?? '',
                                        perfumeRate: double.parse(
                                            product[index].averageRating ??
                                                '0.0'),
                                        rateCount: product[index]
                                                .ratingCount
                                                .toString() ??
                                            '0',
                                        priceBeforeDiscount:
                                            product[index].regularPrice ?? '',
                                        priceAfterDiscount:
                                            product[index].salePrice ?? '',
                                        onTapBuy: () {
                                          Get.to(() => PerfumeDetailsScreen(
                                                productId: product[index]
                                                    .id
                                                    .toString(),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Obx(
                    () {
                      var famousBrandAds = productController
                          .getFamousBrandAdsData?.value.listFamousBrandResponse;
                      return famousBrandAds == null
                          ? SizedBox(
                              height: 100.h,
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                              child: Column(
                                children: [
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: famousBrandAds
                                        .map(
                                          (e) => GestureDetector(
                                            onTap: (){
                                              print(e.brand?[0].name);
                                              print(e.brand?[0].termId);
                                              Get.to(()=>ShopByBrandScreen(
                                                brandName: e.brand?[0].name,
                                                brandId: e.brand?[0].termId,
                                              ));
                                            },
                                            child: Container(
                                                height: 112.h,
                                                width:
                                                    famousBrandAds.indexOf(e) == 0
                                                        ? 156.w
                                                        : famousBrandAds
                                                                    .indexOf(e) ==
                                                                4
                                                            ? 156.w
                                                            : 78.w,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8.r),
                                                ),
                                                child: FancyShimmerImage(
                                                  imageUrl: e.image ?? '',
                                                  width: double.infinity,
                                                  boxFit: BoxFit.fill,
                                                  height: 50,
                                                  shimmerBaseColor: Color(
                                                          (Random().nextDouble() *
                                                                  0xFFFFFF)
                                                              .toInt())
                                                      .withOpacity(1.0),
                                                  shimmerHighlightColor: Color(
                                                          (Random().nextDouble() *
                                                                  0xFFFFFF)
                                                              .toInt())
                                                      .withOpacity(1.0),
                                                  shimmerBackColor: Color(
                                                          (Random().nextDouble() *
                                                                  0xFFFFFF)
                                                              .toInt())
                                                      .withOpacity(1.0),
                                                  errorWidget: SizedBox(),
                                                )),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ],
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
                          'أشهر منتجات العناية',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.to(() => ShowAllCareProductScreen());
                            },
                            child: CustomText(
                              'عرض الكل',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(
                      () {
                        var product = productController
                            .getCareProductDataData!.value.data;
                        return product == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                                height: 430.h,
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      product.length < 8 ? product.length : 8,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return PerfumeProductItem(
                                      imgUrl:
                                          product[index].images?[0].src ?? '',
                                      brandName:
                                          product[index].brands!.isNotEmpty
                                              ? product[index].brands != null
                                                  ? product[index]
                                                      .brands![0]
                                                      .name
                                                      .toString()
                                                  : ''
                                              : '',
                                      perfumeName: product[index].title ?? '',
                                      perfumeRate: double.parse(
                                          product[index].averageRating ??
                                              '0.0'),
                                      rateCount: product[index]
                                              .ratingCount
                                              .toString() ??
                                          '0',
                                      priceBeforeDiscount:
                                          product[index].regularPrice ?? '',
                                      priceAfterDiscount:
                                          product[index].salePrice ?? '',
                                      onTapBuy: () {
                                        Get.to(() => PerfumeDetailsScreen(
                                              productId:
                                                  product[index].id.toString(),
                                            ));
                                      },
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 10.w,
                                    );
                                  },
                                ),
                              );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () {
                  var ads = productController.getAdsData?.value.listAdsResponse;

                  return SizedBox(
                    height: 150.h,
                    child: GestureDetector(
                      onTap: (){
                        Get.to(()=>const ShopByCategoryScreen(
                          categoryId: 183,
                          categoryName: 'بكجات الهدايا',
                        ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          height: 200.h,
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(15),
                            child: FancyShimmerImage(
                              imageUrl: ads?[1].image ?? '',
                              width: double.infinity,
                              height: 50,
                              shimmerBaseColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              shimmerHighlightColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              shimmerBackColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              errorWidget: SizedBox(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          'أفضل العروض',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.to(() => const ShopByCategoryScreen(
                                    categoryId: 24,
                                    categoryName: 'أفضل العروض',
                                    onSale: true,
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
                      height: 20.h,
                    ),
                    Obx(
                      () {
                        var product = productController
                            .getListOffersProductResponseData!.value.data;
                        return product == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                                height: 430.h,
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      product.length < 8 ? product.length : 8,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return PerfumeProductItem(
                                      imgUrl:
                                          product[index + 7].images?[0].src ??
                                              '',
                                      brandName: product[index + 7]
                                              .brands!
                                              .isNotEmpty
                                          ? product[index + 7].brands != null
                                              ? product[index + 7]
                                                  .brands![0]
                                                  .name
                                              : ''
                                          : '',
                                      perfumeName:
                                          product[index + 7].title ?? '',
                                      perfumeRate: double.parse(
                                          product[index + 7].averageRating ??
                                              '0.0'),
                                      rateCount: product[index + 7]
                                              .ratingCount
                                              .toString() ??
                                          '0',
                                      priceBeforeDiscount:
                                          product[index + 7].regularPrice ?? '',
                                      priceAfterDiscount:
                                          product[index + 7].salePrice ?? '',
                                      onTapBuy: () {
                                        Get.to(() => PerfumeDetailsScreen(
                                              productId: product[index + 7]
                                                  .id
                                                  .toString(),
                                            ));
                                      },
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 10.w,
                                    );
                                  },
                                ),
                              );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () {
                  var ads = productController.getAdsData?.value.listAdsResponse;

                  return SizedBox(
                    height: 180.h,
                    child:GestureDetector(
                      onTap: (){
                        Get.to(()=>ShopByBrandScreen(
                          brandId: ads?[2].brand?[0].termId,
                          brandName: ads?[2].brand?[0].name,
                        ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          height: 200.h,
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(15),
                            child: FancyShimmerImage(
                              imageUrl: ads?[2].image ?? '',
                              width: double.infinity,
                              height: 50,
                              shimmerBaseColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              shimmerHighlightColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              shimmerBackColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              errorWidget: SizedBox(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () {
                  var ads = productController.getAdsData?.value.listAdsResponse;
                  return SizedBox(
                    height: 180.h,
                    child:  GestureDetector(
                      onTap: (){
                        Get.to(()=>ShopByBrandScreen(
                          brandId: ads?[1].brand?[0].termId,
                          brandName: ads?[1].brand?[0].name,
                        ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          height: 200.h,
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(15),
                            child: FancyShimmerImage(
                              imageUrl: ads?[3].image ?? '',
                              width: double.infinity,
                              height: 50,
                              shimmerBaseColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              shimmerHighlightColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              shimmerBackColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              errorWidget: SizedBox(),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                          'منتجات تحت 20 ريال',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.to(() => ShowAllProductLessThan100Screen());
                            },
                            child: CustomText(
                              'عرض الكل',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(
                      () {
                        var product = productController
                            .getListLessThanPriceProductResponseData!
                            .value
                            .data;
                        return product == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                                height: 430.h,
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      product.length < 8 ? product.length : 8,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return PerfumeProductItem(
                                      imgUrl:
                                          product[index].images?[0].src ?? '',
                                      brandName: product[index]
                                              .brands!
                                              .isNotEmpty
                                          ? product[index].brands != null
                                              ? product[index].brands![0].name
                                              : ''
                                          : '',
                                      perfumeName: product[index].title ?? '',
                                      perfumeRate: double.parse(
                                          product[index].averageRating ??
                                              '0.0'),
                                      rateCount: product[index]
                                              .ratingCount
                                              .toString() ??
                                          '0',
                                      priceBeforeDiscount:
                                          product[index].regularPrice ?? '',
                                      priceAfterDiscount:
                                          product[index].salePrice ?? '',
                                      onTapBuy: () {
                                        Get.to(() => PerfumeDetailsScreen(
                                              productId:
                                                  product[index].id.toString(),
                                            ));
                                      },
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 10.w,
                                    );
                                  },
                                ),
                              );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () {
                  var ads = productController.getAdsData?.value.listAdsResponse;
                  return SizedBox(
                    height: 160.h,
                    child:  GestureDetector(
                      onTap: (){
                        Get.to(()=>ShopByBrandScreen(
                          brandId: ads?[0].brand?[0].termId,
                          brandName: ads?[0].brand?[0].name,
                        ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          height: 200.h,
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(15),
                            child: FancyShimmerImage(
                              imageUrl: ads?[0].image ?? '',
                              width: double.infinity,
                              height: 50,
                              shimmerBaseColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              shimmerHighlightColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              shimmerBackColor: Color(
                                  (Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              errorWidget: SizedBox(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          'وصل حديثا',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(
                      () {
                        var product = productController
                            .getRecentlyAddedProductDataData!.value.data;
                        return product == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                                height: 430.h,
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      product.length < 8 ? product.length : 8,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return PerfumeProductItem(
                                      imgUrl:
                                          product[index].images?[0].src ?? '',
                                      brandName: product[index]
                                              .brands!
                                              .isNotEmpty
                                          ? product[index].brands != null
                                              ? product[index].brands![0].name
                                              : ''
                                          : '',
                                      perfumeName: product[index].title ?? '',
                                      perfumeRate: double.parse(
                                          product[index].averageRating ??
                                              '0.0'),
                                      rateCount: product[index]
                                              .ratingCount
                                              .toString() ??
                                          '0',
                                      priceBeforeDiscount:
                                          product[index].regularPrice ?? '',
                                      priceAfterDiscount:
                                          product[index].salePrice ?? '',
                                      onTapBuy: () {
                                        Get.to(() => PerfumeDetailsScreen(
                                              productId:
                                                  product[index].id.toString(),
                                            ));
                                      },
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 10.w,
                                    );
                                  },
                                ),
                              );
                      },
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
