import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:perfume_store_mobile_app/controller/product_controller.dart';
import 'package:perfume_store_mobile_app/view/filter/screens/filter_screen.dart';
import '../../../apies/product_apies.dart';
import '../../../controller/category_controller.dart';
import '../../../services/app_imports.dart';
import '../../bottom_nav_screens/widget/perfume_product_item.dart';
import '../../custom_widget/loading_efffect/sliver_loading_product.dart';
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
    ProductApies.productApies
        .searchProduct(pageNumber: '1', word: widget.word ?? '');
    ProductApies.productApies.getLastViewProduct();
    searchController.text = widget.word ?? '';
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProductApies.productApies.listSearchProduct = null;
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
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size dSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.arrow_upward),
            ),
      body: SafeArea(
        child: Obx(
          () {
            var product = productController.getSearchProductDataData!.value.data;
            var lastViewedProduct =
                productController.getLastViewedProduct!.value.data;

            return LazyLoadScrollView(
              onEndOfPage: () {
                if (productController
                        .getSearchProductDataData?.value.headers?.xWPTotal !=
                    0) {
                  setState(() {
                    _currentPage++;
                  });
                  ProductApies.productApies
                      .searchProduct(
                    word: widget.word,
                    pageNumber: _currentPage.toString(),
                  )
                      .then((value) {
                    debugPrint('_currentPage ');
                  });
                }
              },
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [


                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        children: [

                          const Image(
                            image: AssetImage(
                              'assets/images/Notification.png',
                            ),
                          ),


                          const Spacer(),

                          CustomText('search'.tr,
                            fontSize: 17.sp,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.normal,
                          ),

                          Spacer(),

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
                  ),

                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                // Get.to(() => const SearchScreen());
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.07,
                                child: TextFormField(
                                  enabled: false,
                                  onTap: (){
                                    Get.to(() => const SearchScreen());

                                  },
                                  decoration: InputDecoration(
                                    hintText: 'اكتب كلمه البحث...',
                                    filled: true,
                                    suffixIcon: const Image(
                                        image: AssetImage('assets/images/Search.png')
                                    ),
                                    fillColor: const Color(0XFFF7F8FA),
                                    hintStyle: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.018,
                                      color: const Color(0XFF8A8A8B),
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

                          SizedBox(
                            width: 15.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const FilterScreen());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 40.h,
                              width: 40.w,
                              child: SvgPicture.asset(
                                'assets/svg/filter.svg',
                                height: 30.h,
                                width: 30.h,
                                color: Colors.white,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 20.h),
                    sliver: ProductApies.productApies.listSearchProduct == null
                        ? const SliverLoadingProduct(8)
                        : ProductApies.productApies.listSearchProduct!.isEmpty
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
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: dSize.width > 400 &&
                                          dSize.width <= 500
                                      ? 0.6
                                      : dSize.width > 500 && dSize.width <= 600
                                          ? 0.7.h
                                          : dSize.width > 600 &&
                                                  dSize.width <= 700
                                              ? 0.8.h
                                              : dSize.width > 700 &&
                                                      dSize.width <= 800
                                                  ? 0.9.h
                                                  : dSize.width > 800 &&
                                                          dSize.width <= 900
                                                      ? 1
                                                      : 1/1.9,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 15,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  childCount: ProductApies
                                      .productApies.listSearchProduct?.length,
                                  (_, index) {
                                    var product = ProductApies
                                        .productApies.listSearchProduct;
                                    debugPrint(index.toString());
                                    return PerfumeProductItem(
                                      variations: ProductApies.productApies
                                          .listSearchProduct?[index].variations,
                                      id: ProductApies.productApies
                                          .listSearchProduct?[index].id
                                          .toString(),
                                      imgUrl: ProductApies
                                              .productApies
                                              .listSearchProduct?[index]
                                              .images?[0]
                                              .src ??
                                          '',
                                      brandName: ProductApies
                                              .productApies
                                              .listSearchProduct![index]
                                              .brands!
                                              .isNotEmpty
                                          ? ProductApies
                                                      .productApies
                                                      .listSearchProduct![index]
                                                      .brands !=
                                                  null
                                              ? ProductApies
                                                  .productApies
                                                  .listSearchProduct![index]
                                                  .brands![0]
                                                  .name
                                              : ''
                                          : '',
                                      perfumeName: ProductApies.productApies
                                              .listSearchProduct?[index].title ??
                                          '',
                                      perfumeRate: double.parse(
                                        ProductApies
                                                .productApies
                                                .listSearchProduct?[index]
                                                .averageRating ??
                                            '0.0',
                                      ),
                                      rateCount: ProductApies
                                              .productApies
                                              .listSearchProduct?[index]
                                              .ratingCount
                                              .toString() ??
                                          '0',
                                      priceBeforeDiscount:
                                          (product?[index].regularPrice ==
                                                      null) ||
                                                  (product?[index].regularPrice ==
                                                      '0.00')
                                              ? (product?[index].price).toString()
                                              : product?[index].regularPrice,
                                      priceAfterDiscount:
                                          (product?[index].salePrice == null) ||
                                                  (product?[index].salePrice ==
                                                      '0.00')
                                              ? (product?[index].price).toString()
                                              : product?[index].salePrice,
                                      onTapBuy: () {
                                        debugPrint(
                                          ProductApies.productApies
                                              .listSearchProduct?[index].id
                                              .toString(),
                                        );
                                        Get.to(
                                          () => PerfumeDetailsScreen(
                                            productId: ProductApies.productApies
                                                .listSearchProduct?[index].id
                                                .toString(),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    sliver: SliverToBoxAdapter(
                      child: product == null
                          ? const CupertinoActivityIndicator()
                          : const SizedBox(),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        children: [
                          CustomText(
                            'last_seen_value'.tr,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding:
                        EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
                    sliver: lastViewedProduct == null
                        ? const SliverLoadingProduct(2)
                        : SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: dSize.width > 400 &&
                                      dSize.width <= 500
                                  ? 0.6
                                  : dSize.width > 500 && dSize.width <= 600
                                      ? 0.7.h
                                      : dSize.width > 600 && dSize.width <= 700
                                          ? 0.8.h
                                          : dSize.width > 700 &&
                                                  dSize.width <= 800
                                              ? 0.9.h
                                              : dSize.width > 800 &&
                                                      dSize.width <= 900
                                                  ? 1
                                                  : 1.1,
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 15,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (_, index) {
                                return PerfumeProductItem(
                                  variations: lastViewedProduct[index].variations,
                                  id: lastViewedProduct[index]
                                      .images?[0]
                                      .id
                                      .toString(),
                                  imgUrl:
                                      lastViewedProduct[index].images?[0].src ??
                                          '',
                                  brandName: lastViewedProduct[index]
                                          .brands!
                                          .isNotEmpty
                                      ? lastViewedProduct[index].brands != null
                                          ? lastViewedProduct[index]
                                              .brands![0]
                                              .name
                                          : ''
                                      : '',
                                  perfumeName:
                                      lastViewedProduct[index].title ?? '',
                                  perfumeRate: double.parse(
                                    lastViewedProduct[index].averageRating ??
                                        '0.0',
                                  ),
                                  rateCount: lastViewedProduct[index]
                                      .ratingCount
                                      .toString(),
                                  priceBeforeDiscount:
                                      (lastViewedProduct[index].regularPrice ==
                                                  null) ||
                                              (lastViewedProduct[
                                                          index]
                                                      .regularPrice ==
                                                  '0.00')
                                          ? (lastViewedProduct[index].price)
                                              .toString()
                                          : lastViewedProduct[index].regularPrice,
                                  priceAfterDiscount: (lastViewedProduct[index]
                                                  .salePrice ==
                                              null) ||
                                          (lastViewedProduct[index].salePrice ==
                                              '0.00')
                                      ? (lastViewedProduct[index].price)
                                          .toString()
                                      : lastViewedProduct[index].salePrice,
                                  onTapBuy: () {
                                    debugPrint(
                                      lastViewedProduct[index].id.toString(),
                                    );
                                    Get.to(
                                      () => PerfumeDetailsScreen(
                                        productId: lastViewedProduct[index]
                                            .id
                                            .toString(),
                                      ),
                                    );
                                  },
                                );
                              },
                              childCount: lastViewedProduct.length,
                            ),
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
