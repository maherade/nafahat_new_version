import 'dart:developer';

import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/svg.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';
import 'package:perfume_store_mobile_app/controller/category_controller.dart';
import 'package:perfume_store_mobile_app/view/bottom_nav_screens/tabs/ads_screen.dart';
import 'package:perfume_store_mobile_app/view/bottom_nav_screens/tabs/home_screen_item.dart';
import 'package:perfume_store_mobile_app/view/bottom_nav_screens/widget/ad_item.dart';
import 'package:perfume_store_mobile_app/view/bottom_nav_screens/widget/category_item.dart';
import 'package:perfume_store_mobile_app/view/cart/screen/cart_screen.dart';
import 'package:perfume_store_mobile_app/view/search/screen/search_screen.dart';

import '../../../apies/brand_apies.dart';
import '../../../apies/category_apies.dart';
import '../../../apies/posts_apies.dart';
import '../../../apies/product_apies.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/posts_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../model/ads_response.dart';
import '../../../services/app_imports.dart';
import '../../../services/sp_helper.dart';
import '../../articles/screen/article_detail_screen.dart';
import '../../articles/screen/article_screen.dart';
import '../../auth/screens/login_screen.dart';
import '../../custom_widget/loading_efffect/loading_brand.dart';
import '../../custom_widget/loading_efffect/loading_category.dart';
import '../../custom_widget/loading_efffect/loading_container_category.dart';
import '../../custom_widget/loading_efffect/loading_product.dart';
import '../../perfume_details/screens/perfume_details_screen.dart';
import '../../shop_by_brand/screen/shop_by_brand_screen.dart';
import '../../shop_by_category/screen/shop_by_category.dart';
import '../../show_all_care_product/screen/show_all_care_product_screen.dart';
import '../../show_all_famous_product/screen/show_all_famous_product_screen.dart';
import '../../show_all_gift_package/screen/show_all_gift_package_screen.dart';
import '../../show_all_product_less_than_100/screen/show_all_product_less_than_100_screen.dart';
import '../widget/article_home_item.dart';
import '../widget/brand_item.dart';
import '../widget/perfume_product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    log('home screen ${deviceSize.width}');
    log('home screen ${deviceSize.height}');
    return Obx(
      () {
        // var ads = productController.getAdsData?.value.listAdsResponse;
        var brand = brandController.getBrandData!.value.listBrandResponse;
        var category =
            categoryController.getCategoryData!.value.listCategoryResponse;
        var famousProduct = productController.getFamousProductData!.value.data;
        var giftProduct =
            productController.getGiftPackageProductData!.value.data;
        var famousBrandAds = productController
            .getFamousBrandAdsData?.value.listFamousBrandResponse;
        var careProduct = productController.getCareProductDataData!.value.data;
        var listOffersProduct =
            productController.getListOffersProductResponseData!.value.data;
        var lessThanProduct = productController
            .getListLessThanPriceProductResponseData!.value.data;
        var recentlyAddedProduct =
            productController.getRecentlyAddedProductDataData!.value.data;
        var post = postsController.getPostsData!.value.listPostsResponse;
        //
        var ramadanCare = productController.getRamadanProductData?.value.data;
        var lensesProduct = productController.getLensesProductData?.value.data;
        var ramadanOffers =
            productController.getRamadanOffersProductData?.value.data;
        var topMakeup = productController.getTopMakeupProductData?.value.data;
        var topDevices = productController.getTopDevicesProductData?.value.data;
        var topNails = productController.getTopNailsProductData?.value.data;
        var topPerfume = productController.getTopPerfumeProductData?.value.data;

        AdsResponse? getAd({String? title}) {
          AdsResponse? adsResponse;
          productController.getAdsData?.value.listAdsResponse
              ?.forEach((element) {
            if (element.image != null) {
              title == element.url ? adsResponse = element : null;
            }
          });
          return adsResponse;
        }

        return RefreshIndicator(
          displacement: 250,
          backgroundColor: AppColors.whiteColor,
          color: AppColors.primaryColor,
          strokeWidth: 3,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            // home screen request

            BrandApies.brandApies.getBrandData();
            CategoryApies.categoryApies.getCategoryData('0');
            PostsApies.postsApies.getPostsData();

            ProductApies.productApies
                .getGiftPackageProductData(pageNumber: '1');
            ProductApies.productApies.getFamousProductData(category: "2482");
            ProductApies.productApies.getWholeSaleProductData(onSale: true);
            ProductApies.productApies.getOffersProductData();
            ProductApies.productApies.getLessThanPriceProductResponseData(
              order: 'asc',
              orderBy: 'price',
              lessThan: '20',
              pageNumber: '1',
            );
            ProductApies.productApies.getCareProductData(pageNumber: '1');
            ProductApies.productApies
                .getRecentlyAddedProductData(pageNumber: '1');
            //
            ProductApies.productApies.getRamadanProductData();
            ProductApies.productApies.getLensesProductData();
            ProductApies.productApies.getRamadanOffersProductData();
            ProductApies.productApies.getTopMakeupProductData();
            ProductApies.productApies.getTopDevicesProductData();
            ProductApies.productApies.getTopNailsProductData();
            ProductApies.productApies.getTopPerfumeProductData();
          },
          child: SingleChildScrollView(
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

                      const Image(
                          image: AssetImage(
                            'assets/images/Notification.png',
                          ),
                      ),

                      SizedBox(width: MediaQuery.of(context).size.height*0.015,),

                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Get.to(() => const SearchScreen());
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.06,
                            child: TextFormField(

                              decoration: InputDecoration(
                                hintText: 'اكتب كلمه البحث...',
                                filled: true,
                                suffixIcon: Image.asset(
                                  'assets/images/Search.png',
                                  height: MediaQuery.of(context).size.height*0.005,
                                  width: MediaQuery.of(context).size.height*0.005,
                                ),
                                fillColor: const Color(0XFFF7F8FA),
                                hintStyle: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height*0.018,
                                  color: Colors.black54,
                                  fontFamily: 'din',
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide.none,
                                ),
                              ),

                              style: TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.of(context).size.height*0.018,
                              ),
                              controller: searchController,

                            ),
                          ),
                        ),
                      ),

                      // Row(
                      //   children: [
                      //
                      //
                      //     InkWell(
                      //       onTap: () {
                      //         if (SPHelper.spHelper.getToken() == null) {
                      //           Get.offAll(() => const LoginScreen());
                      //         } else {
                      //           Get.to(() => const CartScreen());
                      //         }
                      //       },
                      //       child: GetBuilder<CartController>(
                      //         init: CartController(),
                      //         builder: (controller) {
                      //           return badges.Badge(
                      //             showBadge: cartController.items.isNotEmpty
                      //                 ? true
                      //                 : false,
                      //             position: badges.BadgePosition.topEnd(),
                      //             badgeStyle: badges.BadgeStyle(
                      //               shape: badges.BadgeShape.circle,
                      //               borderRadius: BorderRadius.circular(12.r),
                      //               badgeColor: AppColors.primaryColor,
                      //             ),
                      //             badgeContent: CustomText(
                      //               controller.items.length.toString(),
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.normal,
                      //               fontSize: 11.sp,
                      //               textAlign: TextAlign.center,
                      //             ),
                      //             child: SvgPicture.asset(
                      //               'assets/svg/cart.svg',
                      //               color: AppColors.greenText,
                      //               fit: BoxFit.contain,
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //
                      //   ],
                      // ),

                      SizedBox(width: MediaQuery.of(context).size.height*0.01,),

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
                Container(
                  height: 10850.h,
                  width: 500.w,
                  child: Expanded(
                    child: DefaultTabController(
                        length: 4,
                        child: Scaffold(
                          appBar: AppBar(
                            elevation: 0.0,
                            backgroundColor: Colors.white,
                            toolbarHeight: 0,
                            bottom:  TabBar(
                              indicatorColor: AppColors.primaryColor,
                              tabs: [
                                Tab(
                                  child: CustomText(
                                    'الرئيسيه',
                                     color: const Color(0XFFC8C8C8),
                                     fontSize: 13.sp,
                                  )
                                ),
                                Tab(
                                    child: CustomText(
                                      'العروض',
                                      color: const Color(0XFFC8C8C8),
                                      fontSize: 13.sp,
                                    )
                                ),
                                Tab(
                                    child: CustomText(
                                      maxLines: 1,
                                      'منتجات اقل من 10 ريال',
                                      color: const Color(0XFFC8C8C8),
                                      fontSize: 13.sp,
                                    )
                                ),
                                Tab(
                                    child: CustomText(
                                      'المكياج',
                                      color: const Color(0XFFC8C8C8),
                                      fontSize: 13.sp,
                                    )
                                ),


                              ],
                            ),
                          ),
                          body:  TabBarView(
                            children: [
                              const HomeScreenItem(),
                              ShopByCategoryScreen(
                                categoryId: 2482,
                                categoryName: 'top_offers_value'.tr,
                              ),
                              const ShowAllProductLessThan100Screen(),
                              ShopByCategoryScreen(
                                categoryName:
                                "top_makeup_product_value".tr,
                                categoryId: 2444,
                                fullCategoryName: true,
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
