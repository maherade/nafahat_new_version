import 'dart:convert';
import 'dart:math';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:perfume_store_mobile_app/apies/auth_apies.dart';
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';
import 'package:perfume_store_mobile_app/controller/category_controller.dart';
import 'package:perfume_store_mobile_app/view/auth/screens/login_screen.dart';
import 'package:perfume_store_mobile_app/view/bottom_nav_screens/widget/ad_item.dart';
import 'package:perfume_store_mobile_app/view/cart/screen/cart_screen.dart';
import 'package:perfume_store_mobile_app/view/bottom_nav_screens/widget/category_item.dart';
import 'package:perfume_store_mobile_app/view/search/screen/search_screen.dart';
import '../../../apies/brand_apies.dart';
import '../../../apies/category_apies.dart';
import '../../../apies/posts_apies.dart';
import '../../../apies/product_apies.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/posts_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../model/decode_token_response.dart';
import '../../../model/sub_category_product.dart';
import '../../../services/app_imports.dart';
import '../../../services/sp_helper.dart';
import '../../articles/screen/article_detail_screen.dart';
import '../../articles/screen/article_screen.dart';
import '../../articles/widget/article_item.dart';
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
import '../widget/article_home_item.dart';
import '../widget/brand_item.dart';
import '../../custom_widget/custom_dialog.dart';
import '../widget/perfume_product_item.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryController categoryController = Get.find();
  BrandController brandController = Get.find();
  ProductController productController = Get.find();
  AuthController authController = Get.find();
  PostsController postsController = Get.find();

  int _current = 0;
  int currentIndex = 0;

  bool popUpIsSelectedTextColor = false;

  String categoryName = 'الأجهزة';
  int categoryId = 27;

  @override
  void initState() {
    BrandApies.brandApies.getBrandData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CategoryApies.categoryApies.getCategoryData('0');
      PostsApies.postsApies.getPostsData();

      ProductApies.productApies.getGiftPackageProductData(pageNumber: '1');
      ProductApies.productApies.getFamousProductData(category: "27");
      ProductApies.productApies.getWholeSaleProductData(onSale: true);
      ProductApies.productApies.getOffersProductData();
      ProductApies.productApies.getLessThanPriceProductResponseData(order: 'asc', orderBy: 'price', lessThan: '20', pageNumber: '1');
      ProductApies.productApies.getCareProductData( pageNumber: '1');
      ProductApies.productApies.getRecentlyAddedProductData(pageNumber: '1');
      //
      ProductApies.productApies.getRamadanProductData();
      ProductApies.productApies.getLensesProductData();
      ProductApies.productApies.getRamadanOffersProductData();
      ProductApies.productApies.getTopMakeupProductData();
      ProductApies.productApies.getTopDevicesProductData();
      ProductApies.productApies.getTopNailsProductData();
      ProductApies.productApies.getTopPerfumeProductData();
    });
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var ads = productController.getAdsData?.value.listAdsResponse;
        var brand = brandController.getBrandData!.value.listBrandResponse;
        var category = categoryController.getCategoryData!.value.listCategoryResponse;
        var famousProduct = productController.getFamousProductData!.value.data;
        var giftProduct = productController.getGiftPackageProductData!.value.data;
        var famousBrandAds = productController.getFamousBrandAdsData?.value.listFamousBrandResponse;
        var careProduct = productController.getCareProductDataData!.value.data;
        var listOffersProduct = productController.getListOffersProductResponseData!.value.data;
        var lessThanProduct = productController.getListLessThanPriceProductResponseData!.value.data;
        var recentlyAddedProduct = productController.getRecentlyAddedProductDataData!.value.data;
        var post = postsController.getPostsData!.value.listPostsResponse;
        //
        var ramadanCare = productController.getRamadanProductData?.value.data;
        var lensesProduct = productController.getLensesProductData?.value.data;
        var ramadanOffers = productController.getRamadanOffersProductData?.value.data;
        var topMakeup = productController.getTopMakeupProductData?.value.data;
        var topDevices = productController.getTopDevicesProductData?.value.data;
        var topNails = productController.getTopNailsProductData?.value.data;
        var topPerfume = productController.getTopPerfumeProductData?.value.data;
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
                    Container(
                        height: 45.h,
                        width: 45.w,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        )),
                    Spacer(),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => CartScreen());
                          },
                          child: GetBuilder<CartController>(
                            init: CartController(),
                            builder: (controller) {
                              return badges.Badge(
                                showBadge: cartController.items.isNotEmpty ? true : false,
                                position: badges.BadgePosition.topEnd(),
                                badgeStyle: badges.BadgeStyle(
                                  shape: badges.BadgeShape.circle,
                                  borderRadius: BorderRadius.circular(12.r),
                                  badgeColor: AppColors.primaryColor,
                                ),
                                badgeContent: CustomText(
                                  controller.items.length.toString(),
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11.sp,
                                  textAlign: TextAlign.center,
                                ),
                                child: SvgPicture.asset(
                                  'assets/svg/cart.svg',
                                  color: AppColors.greenText,
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        IconButton(
                          onPressed: () {
                            Get.to(() => SearchScreen());
                          },
                          icon: Icon(Icons.search),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  ads != null
                      ? Column(
                    children: [
                      SizedBox(
                        height: 180.h,
                        child: PageView.builder(
                          onPageChanged: (index) {
                            setState(() => _current = index);
                          },
                          itemCount: ads.length <= 3 ? ads.length : 3,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(
                                      () =>  ShopByBrandScreen(
                                    brandId: ads[index].brand?[0].termId??1781,
                                    brandName: ads[index].brand?[0].name??'Acure'.tr,
                                  ),
                                );

                              },
                              child: AdItem(imgUrl: ads[index].image),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [0, 1, 2].asMap().entries.map((entry) {
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
                  )
                      : SizedBox(
                    height: 150.h,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  brand == null
                      ? const LoadingBrand()
                      : SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: brand.length > 6 ? 6 : brand.length,
                      itemBuilder: (context, index) {
                        return BrandItem(
                          index: index,
                          imgUrl: brand[index].logo ?? '',
                          onTap: () {
                            Get.to(
                                  () =>  ShopByBrandScreen(
                                brandId: ads?[index].brand?[0].termId??1781,
                                brandName: ads?[index].brand?[0].name??'Acure'.tr,
                              ),
                            );
                          },
                        );
                      },
                    ),
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
                          'shop_by_category_value'.tr,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      category == null
                          ? LoadingCategory()
                          : SizedBox(
                        height: 120.h,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: category.length < 7 ? category.length : 7,
                          itemBuilder: (context, index) {
                            return CategoryItem(
                              index: index,
                              imgUrl: category[index].image?.src ?? '',
                              title: category[index].name,
                              onTap: () {
                                // productController.getListSubCategoryProductData?.value = ListSubCategoryProductResponse();
                                Get.to(() => ShopByCategoryScreen(
                                  categoryId: category[index].id,
                                  categoryName: category[index].name,
                                ));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 150.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[24].brand?[0].termId??1781,
                            brandName: ads?[24].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[24].image),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 150.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[25].brand?[0].termId??1781,
                            brandName: ads?[25].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[25].image),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 21.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'top_sale_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ShowAllFamousProductScreen());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 13.w),
                                  child: CustomText(
                                    'view_all_value'.tr,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      SizedBox(
                        height: 150.h,
                        child: InkWell(
                          onTap: () {
                            Get.to(
                                  () =>  ShopByBrandScreen(
                                brandId: ads?[20].brand?[0].termId??1781,
                                brandName: ads?[20].brand?[0].name??'Acure'.tr,
                              ),
                            );
                          },
                          child: AdItem(imgUrl: ads?[20].image),
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
                          itemCount: category.length < 6 ? category.length : 6,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                index == 0
                                    ? SizedBox(
                                  width: 21.w,
                                )
                                    : const SizedBox(),
                                InkWell(
                                  onTap: () {
                                    setState(() => currentIndex = index);
                                    setState(() => categoryName = category[index].name!);
                                    setState(() => categoryId = category[index].id!);
                                    ProductApies.productApies
                                        .getFamousProductData(category: category[index].id.toString(), onSale: true);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 70.h,
                                    width: 80.h,
                                    padding: EdgeInsets.all(5.w),
                                    decoration: BoxDecoration(
                                        color: currentIndex == index ? AppColors.primaryColor : AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(5.r),
                                        border: Border.all(color: AppColors.greyBorder)),
                                    child: CustomText(
                                      category[index].name,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center,
                                      color: currentIndex == index ? AppColors.whiteColor : AppColors.greenText,
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
                                  'top_sale_in_value'.tr +categoryName,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                InkWell(
                                    onTap: () {
                                      Get.to(() => ShopByCategoryScreen(
                                        categoryName: categoryName,
                                        categoryId: categoryId,
                                      ));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 13.w),
                                      child: CustomText(
                                        'view_all_value'.tr,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            famousProduct == null
                                ? const LoadingProduct(2)
                                : SizedBox(
                              height: 430.h,
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemCount: famousProduct.length < 8 ? famousProduct.length : 8,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) {
                                  return PerfumeProductItem(
                                    id: famousProduct[index].id.toString(),
                                    imgUrl: famousProduct[index].images?[0].src ?? '',
                                    brandName: famousProduct[index].brands!.isNotEmpty
                                        ? famousProduct[index].brands != null
                                        ? famousProduct[index].brands![0].name
                                        : ''
                                        : '',
                                    perfumeName: famousProduct[index].title ?? '',
                                    perfumeRate: double.parse(famousProduct[index].averageRating ?? '0.0'),
                                    rateCount: famousProduct[index].ratingCount.toString() ?? '0',
                                    priceBeforeDiscount: famousProduct[index].regularPrice ?? '',
                                    priceAfterDiscount: famousProduct[index].salePrice ?? '',
                                    onTapBuy: () {
                                      print(famousProduct[index].id.toString());
                                      Get.to(() => PerfumeDetailsScreen(
                                        productId: famousProduct[index].id.toString(),
                                      ));
                                    },
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
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
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  SizedBox(
                    height: 140.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[3].brand?[0].termId??1781,
                            brandName: ads?[3].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[3].image),
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
                              'discover_gift_package_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ShowAllGiftPackageScreen());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 13.w),
                                  child: CustomText(
                                    'view_all_value'.tr,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        giftProduct == null
                            ? const LoadingProduct(2)
                            : giftProduct.isEmpty
                            ? CustomText(
                          'no_item_found_with_you_choice_value'.tr,
                          fontSize: 15.sp,
                        )
                            : SizedBox(
                          height: 430.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: giftProduct.length < 8 ? giftProduct.length : 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return PerfumeProductItem(
                                id: giftProduct[index].id.toString(),
                                imgUrl: giftProduct[index].images?[0].src ?? '',
                                brandName: giftProduct[index].brands!.isNotEmpty
                                    ? giftProduct[index].brands != null
                                    ? giftProduct[index].brands![0].name
                                    : ''
                                    : '',
                                perfumeName: giftProduct[index].title ?? '',
                                perfumeRate: double.parse(giftProduct[index].averageRating ?? '0.0'),
                                rateCount: giftProduct[index].ratingCount.toString() ?? '0',
                                priceBeforeDiscount: giftProduct[index].regularPrice ?? '',
                                priceAfterDiscount: giftProduct[index].salePrice ?? '',
                                onTapBuy: () {
                                  Get.to(() => PerfumeDetailsScreen(
                                    productId: giftProduct[index].id.toString(),
                                  ));
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
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
                              'famous_brand_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      famousBrandAds == null
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
                                    (e) => InkWell(
                                  onTap: () {

                                    Get.to(() => ShopByBrandScreen(
                                      brandName: e.brand?[0].name,
                                      brandId: e.brand?[0].termId,
                                    ));
                                  },
                                  child: Container(
                                      height: 112.h,
                                      width: famousBrandAds.indexOf(e) == 0
                                          ? 156.w
                                          : famousBrandAds.indexOf(e) == 4
                                          ? 156.w
                                          : 78.w,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      child: CachedNetworkImageShare(
                                        urlImage:  e.image ?? '',
                                        widthNumber: double.infinity,
                                        fit: BoxFit.fill,
                                        heigthNumber: double.infinity,
                                      )),
                                ),
                              )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        height: 150.h,
                        child: InkWell(
                          onTap: () {
                            Get.to(
                                  () =>  ShopByBrandScreen(
                                brandId: ads?[16].brand?[0].termId??1781,
                                brandName: ads?[16].brand?[0].name??'Acure'.tr,
                              ),
                            );
                          },
                          child: AdItem(imgUrl: ads?[16].image),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  //CareInRamadan
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'care_in_ramadan_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ShopByCategoryScreen(categoryName: "care_in_ramadan_value".tr,categoryId: 1975,fullCategoryName: true,));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 13.w),
                                  child: CustomText(
                                    'view_all_value'.tr,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ramadanCare == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                          height: 430.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: ramadanCare.length < 8 ? ramadanCare.length : 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return PerfumeProductItem(
                                id: ramadanCare[index].id.toString(),
                                imgUrl: ramadanCare[index].images?[0].src ?? '',
                                brandName: ramadanCare[index].brands!.isNotEmpty
                                    ? ramadanCare[index].brands != null
                                    ? ramadanCare[index].brands![0].name
                                    : ''
                                    : '',
                                perfumeName: ramadanCare[index].title ?? '',
                                perfumeRate: double.parse(ramadanCare[index].averageRating ?? '0.0'),
                                rateCount: ramadanCare[index].ratingCount.toString() ?? '0',
                                priceBeforeDiscount: ramadanCare[index].regularPrice ?? '',
                                priceAfterDiscount: ramadanCare[index].salePrice ?? '',
                                onTapBuy: () {
                                  Get.to(() => PerfumeDetailsScreen(
                                    productId: ramadanCare[index].id.toString(),
                                  ));
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 150.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[7].brand?[0].termId??1781,
                            brandName: ads?[7].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[7].image),
                    ),
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
                              'famous_care_product_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ShowAllCareProductScreen());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 13.w),
                                  child: CustomText(
                                    'view_all_value'.tr,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        careProduct == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                          height: 430.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: careProduct.length < 8 ? careProduct.length : 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return PerfumeProductItem(
                                id: careProduct[index].id.toString(),
                                imgUrl: careProduct[index].images?[0].src ?? '',
                                brandName: careProduct[index].brands!.isNotEmpty
                                    ? careProduct[index].brands != null
                                    ? careProduct[index].brands![0].name.toString()
                                    : ''
                                    : '',
                                perfumeName: careProduct[index].title ?? '',
                                perfumeRate: double.parse(careProduct[index].averageRating ?? '0.0'),
                                rateCount: careProduct[index].ratingCount.toString() ?? '0',
                                priceBeforeDiscount: careProduct[index].regularPrice ?? '',
                                priceAfterDiscount: careProduct[index].salePrice ?? '',
                                onTapBuy: () {
                                  Get.to(() => PerfumeDetailsScreen(
                                    productId: careProduct[index].id.toString(),
                                  ));
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 200.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[13].brand?[0].termId??1781,
                            brandName: ads?[13].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[13].image),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 200.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[14].brand?[0].termId??1781,
                            brandName: ads?[14].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[14].image),
                    ),
                  ),

                  SizedBox(
                    height: 40.h,
                  ),
                  //topLenses
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'top_lenses_product_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ShopByCategoryScreen(categoryName: "top_lenses_product_value".tr,categoryId: 18,fullCategoryName: true,));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 13.w),
                                  child: CustomText(
                                    'view_all_value'.tr,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        lensesProduct == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                          height: 430.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: lensesProduct.length < 8 ? lensesProduct.length : 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return PerfumeProductItem(
                                id: lensesProduct[index].id.toString(),
                                imgUrl: lensesProduct[index].images?[0].src ?? '',
                                brandName: lensesProduct[index].brands!.isNotEmpty
                                    ? lensesProduct[index].brands != null
                                    ? lensesProduct[index].brands![0].name
                                    : ''
                                    : '',
                                perfumeName: lensesProduct[index].title ?? '',
                                perfumeRate: double.parse(lensesProduct[index].averageRating ?? '0.0'),
                                rateCount: lensesProduct[index].ratingCount.toString() ?? '0',
                                priceBeforeDiscount: lensesProduct[index].regularPrice ?? '',
                                priceAfterDiscount: lensesProduct[index].salePrice ?? '',
                                onTapBuy: () {
                                  Get.to(() => PerfumeDetailsScreen(
                                    productId: lensesProduct[index].id.toString(),
                                  ));
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 150.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[22].brand?[0].termId??1781,
                            brandName: ads?[22].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[22].image),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),

                  //ramadanOffers
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'top_ramadan_offer_product_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ShopByCategoryScreen(categoryName: "top_ramadan_offer_product_value".tr,categoryId: 1980,fullCategoryName: true,));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 13.w),
                                  child: CustomText(
                                    'view_all_value'.tr,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ramadanOffers == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                          height: 430.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: ramadanOffers.length < 8 ? ramadanOffers.length : 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return PerfumeProductItem(
                                id: ramadanOffers[index].id.toString(),
                                imgUrl: ramadanOffers[index].images?[0].src ?? '',
                                brandName: ramadanOffers[index].brands!.isNotEmpty
                                    ? ramadanOffers[index].brands != null
                                    ? ramadanOffers[index].brands![0].name
                                    : ''
                                    : '',
                                perfumeName: ramadanOffers[index].title ?? '',
                                perfumeRate: double.parse(ramadanOffers[index].averageRating ?? '0.0'),
                                rateCount: ramadanOffers[index].ratingCount.toString() ?? '0',
                                priceBeforeDiscount: ramadanOffers[index].regularPrice ?? '',
                                priceAfterDiscount: ramadanOffers[index].salePrice ?? '',
                                onTapBuy: () {
                                  Get.to(() => PerfumeDetailsScreen(
                                    productId: ramadanOffers[index].id.toString(),
                                  ));
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 150.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[6].brand?[0].termId??1781,
                            brandName: ads?[6].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[6].image),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  //topMakeup
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'top_makeup_product_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ShopByCategoryScreen(categoryName: "top_makeup_product_value".tr,categoryId: 24,fullCategoryName: true,));
                                },
                                child:Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 13.w),
                                  child: CustomText(
                                    'view_all_value'.tr,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        topMakeup == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                          height: 430.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: topMakeup.length < 8 ? topMakeup.length : 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return PerfumeProductItem(
                                id: topMakeup[index].id.toString(),
                                imgUrl: topMakeup[index].images?[0].src ?? '',
                                brandName: topMakeup[index].brands!.isNotEmpty
                                    ? topMakeup[index].brands != null
                                    ? topMakeup[index].brands![0].name
                                    : ''
                                    : '',
                                perfumeName: topMakeup[index].title ?? '',
                                perfumeRate: double.parse(topMakeup[index].averageRating ?? '0.0'),
                                rateCount: topMakeup[index].ratingCount.toString() ?? '0',
                                priceBeforeDiscount: topMakeup[index].regularPrice ?? '',
                                priceAfterDiscount: topMakeup[index].salePrice ?? '',
                                onTapBuy: () {
                                  Get.to(() => PerfumeDetailsScreen(
                                    productId: topMakeup[index].id.toString(),
                                  ));
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 200.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[8].brand?[0].termId??1781,
                            brandName: ads?[8].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[8].image),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 200.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[15].brand?[0].termId??1781,
                            brandName: ads?[15].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[15].image),
                    ),
                  ),


                  SizedBox(
                    height: 40.h,
                  ),

                  //topDevices
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'top_devices_product_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ShopByCategoryScreen(categoryName: "top_devices_product_value".tr,categoryId: 27,fullCategoryName: true,));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 13.w),
                                  child: CustomText(
                                    'view_all_value'.tr,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        topDevices == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                          height: 430.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: topDevices.length < 8 ? topDevices.length : 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return PerfumeProductItem(
                                id: topDevices[index].id.toString(),
                                imgUrl: topDevices[index].images?[0].src ?? '',
                                brandName: topDevices[index].brands!.isNotEmpty
                                    ? topDevices[index].brands != null
                                    ? topDevices[index].brands![0].name
                                    : ''
                                    : '',
                                perfumeName: topDevices[index].title ?? '',
                                perfumeRate: double.parse(topDevices[index].averageRating ?? '0.0'),
                                rateCount: topDevices[index].ratingCount.toString() ?? '0',
                                priceBeforeDiscount: topDevices[index].regularPrice ?? '',
                                priceAfterDiscount: topDevices[index].salePrice ?? '',
                                onTapBuy: () {
                                  Get.to(() => PerfumeDetailsScreen(
                                    productId: topDevices[index].id.toString(),
                                  ));
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 150.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[5].brand?[0].termId??1781,
                            brandName: ads?[5].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[5].image),
                    ),
                  ),

                  SizedBox(
                    height: 40.h,
                  ),

                  //topAzafer
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'top_azafer_product_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ShopByCategoryScreen(categoryName: "top_azafer_product_value".tr,categoryId: 28,fullCategoryName: true,));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 13.w),
                                  child: CustomText(
                                    'view_all_value'.tr,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        topNails == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                          height: 430.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: topNails.length < 8 ? topNails.length : 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return PerfumeProductItem(
                                id: topNails[index].id.toString(),
                                imgUrl: topNails[index].images?[0].src ?? '',
                                brandName: topNails[index].brands!.isNotEmpty
                                    ? topNails[index].brands != null
                                    ? topNails[index].brands![0].name
                                    : ''
                                    : '',
                                perfumeName: topNails[index].title ?? '',
                                perfumeRate: double.parse(topNails[index].averageRating ?? '0.0'),
                                rateCount: topNails[index].ratingCount.toString() ?? '0',
                                priceBeforeDiscount: topNails[index].regularPrice ?? '',
                                priceAfterDiscount: topNails[index].salePrice ?? '',
                                onTapBuy: () {
                                  Get.to(() => PerfumeDetailsScreen(
                                    productId: topNails[index].id.toString(),
                                  ));
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 150.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[9].brand?[0].termId??1781,
                            brandName: ads?[9].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[9].image),
                    ),
                  ),

                  SizedBox(
                    height: 40.h,
                  ),

                  //topPerfume
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'top_perfume_product_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ShopByCategoryScreen(categoryName: "top_perfume_product_value".tr,categoryId: 26,fullCategoryName: true,));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 13.w),
                                  child: CustomText(
                                    'view_all_value'.tr,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        topPerfume == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                          height: 430.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: topPerfume.length < 8 ? topPerfume.length : 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return PerfumeProductItem(
                                id: topPerfume[index].id.toString(),
                                imgUrl: topPerfume[index].images?[0].src ?? '',
                                brandName: topPerfume[index].brands!.isNotEmpty
                                    ? topPerfume[index].brands != null
                                    ? topPerfume[index].brands![0].name
                                    : ''
                                    : '',
                                perfumeName: topPerfume[index].title ?? '',
                                perfumeRate: double.parse(topPerfume[index].averageRating ?? '0.0'),
                                rateCount: topPerfume[index].ratingCount.toString() ?? '0',
                                priceBeforeDiscount: topPerfume[index].regularPrice ?? '',
                                priceAfterDiscount: topPerfume[index].salePrice ?? '',
                                onTapBuy: () {
                                  Get.to(() => PerfumeDetailsScreen(
                                    productId: topPerfume[index].id.toString(),
                                  ));
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 150.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[4].brand?[0].termId??1781,
                            brandName: ads?[4].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[4].image),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  //under20
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'product_under_20_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ShowAllProductLessThan100Screen());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 13.w),
                                  child: CustomText(
                                    'view_all_value'.tr,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        lessThanProduct == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                          height: 430.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: lessThanProduct.length < 8 ? lessThanProduct.length : 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return PerfumeProductItem(
                                id: lessThanProduct[index].id.toString(),
                                imgUrl: lessThanProduct[index].images?[0].src ?? '',
                                brandName: lessThanProduct[index].brands!.isNotEmpty
                                    ? lessThanProduct[index].brands != null
                                    ? lessThanProduct[index].brands![0].name
                                    : ''
                                    : '',
                                perfumeName: lessThanProduct[index].title ?? '',
                                perfumeRate: double.parse(lessThanProduct[index].averageRating ?? '0.0'),
                                rateCount: lessThanProduct[index].ratingCount.toString() ?? '0',
                                priceBeforeDiscount: lessThanProduct[index].regularPrice ?? '',
                                priceAfterDiscount: lessThanProduct[index].salePrice ?? '',
                                onTapBuy: () {
                                  Get.to(() => PerfumeDetailsScreen(
                                    productId: lessThanProduct[index].id.toString(),
                                  ));
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 150.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[23].brand?[0].termId??1781,
                            brandName: ads?[23].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[23].image),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  //topOffer
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'top_offers_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() =>  ShopByCategoryScreen(
                                    categoryId: 24,
                                    categoryName: 'top_offers_value'.tr,
                                  ));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 13.w),
                                  child: CustomText(
                                    'view_all_value'.tr,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        listOffersProduct == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                          height: 430.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: listOffersProduct.length < 8 ? listOffersProduct.length : 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return PerfumeProductItem(
                                id: listOffersProduct[index + 7].id.toString(),
                                imgUrl: listOffersProduct[index + 7].images?[0].src ?? '',
                                brandName: listOffersProduct[index + 7].brands!.isNotEmpty
                                    ? listOffersProduct[index + 7].brands != null
                                    ? listOffersProduct[index + 7].brands![0].name
                                    : ''
                                    : '',
                                perfumeName: listOffersProduct[index + 7].title ?? '',
                                perfumeRate: double.parse(listOffersProduct[index + 7].averageRating ?? '0.0'),
                                rateCount: listOffersProduct[index + 7].ratingCount.toString() ?? '0',
                                priceBeforeDiscount: listOffersProduct[index + 7].regularPrice ?? '',
                                priceAfterDiscount: listOffersProduct[index + 7].salePrice ?? '',
                                onTapBuy: () {
                                  Get.to(() => PerfumeDetailsScreen(
                                    productId: listOffersProduct[index + 7].id.toString(),
                                  ));
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 200.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[11].brand?[0].termId??1781,
                            brandName: ads?[11].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[11].image),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 200.h,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                              () =>  ShopByBrandScreen(
                            brandId: ads?[19].brand?[0].termId??1781,
                            brandName: ads?[19].brand?[0].name??'Acure'.tr,
                          ),
                        );
                      },
                      child: AdItem(imgUrl: ads?[19].image),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
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
                              'recently_arrive_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        recentlyAddedProduct == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                          height: 430.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: recentlyAddedProduct.length < 8 ? recentlyAddedProduct.length : 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return PerfumeProductItem(
                                id: recentlyAddedProduct[index].id.toString(),
                                imgUrl: recentlyAddedProduct[index].images?[0].src ?? '',
                                brandName: recentlyAddedProduct[index].brands!.isNotEmpty
                                    ? recentlyAddedProduct[index].brands != null
                                    ? recentlyAddedProduct[index].brands![0].name
                                    : ''
                                    : '',
                                perfumeName: recentlyAddedProduct[index].title ?? '',
                                perfumeRate: double.parse(recentlyAddedProduct[index].averageRating ?? '0.0'),
                                rateCount: recentlyAddedProduct[index].ratingCount.toString() ?? '0',
                                priceBeforeDiscount: recentlyAddedProduct[index].regularPrice ?? '',
                                priceAfterDiscount: recentlyAddedProduct[index].salePrice ?? '',
                                onTapBuy: () {
                                  Get.to(() => PerfumeDetailsScreen(
                                    productId: recentlyAddedProduct[index].id.toString(),
                                  ));
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
                        )
                      ],
                    ),
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
                              'article_value'.tr,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ArticlesScreen());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 13.w),
                                  child: CustomText(
                                    'view_all_value'.tr,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        post == null
                            ? const LoadingProduct(2)
                            : SizedBox(
                          height: 350.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: post.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return ArticleHomeItem(
                                imgUrl: post[index].eEmbedded?.wpFeaturedmedia?[0].sourceUrl ?? '',
                                category: 'makeup_category_value'.tr,
                                date: DateFormat('dd-MM-yyyy').format(DateFormat('yyyy-MM-dd').parse(post[index].date!)),
                                title: post[index].title?.rendered ?? '',
                                description: parse(post[index].excerpt?.rendered).documentElement!.text,
                                onTapReadMore: () {
                                  Get.to(() => ArticleDetailScreen(
                                    id: post[index].id.toString(),
                                  ));
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
