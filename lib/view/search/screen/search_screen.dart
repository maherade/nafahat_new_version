import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

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
import '../../custom_widget/loading_efffect/sliver_loading_product.dart';
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
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
        onPressed: _scrollToTop,
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.arrow_upward),
      ),
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
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal:5.w),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        const BackButton(),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal:20.w),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  sliver: ProductApies.productApies.listSearchProduct == null
                      ? SliverLoadingProduct(8)
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.45.h,
                      crossAxisCount: 2,
                      crossAxisSpacing: 11.w,
                      mainAxisSpacing: 16.h,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: ProductApies.productApies.listSearchProduct?.length,
                          (_, index) {
                            var product = ProductApies.productApies.listSearchProduct;
                        print(index);
                        return PerfumeProductItem(
                          variations:  ProductApies.productApies.listSearchProduct?[index].variations,

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
                          priceBeforeDiscount:
                          (product?[index].regularPrice == null) ||
                              (product?[index].regularPrice == '0.00')
                              ? (product?[index].price).toString()
                              : product?[index].regularPrice,
                          priceAfterDiscount: (product?[index].salePrice == null) ||
                              (product?[index].salePrice == '0.00')
                              ? (product?[index].price).toString()
                              : product?[index].salePrice,
                          onTapBuy: () {
                            print(ProductApies.productApies.listSearchProduct?[index].id.toString());
                            Get.to(() => PerfumeDetailsScreen(
                              productId: ProductApies.productApies.listSearchProduct?[index].id.toString(),
                            ));
                          },
                        );
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  sliver: SliverToBoxAdapter(
                    child: product == null ? CupertinoActivityIndicator() : SizedBox(),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverToBoxAdapter(
                    child:  Row(
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
                  padding: EdgeInsets.symmetric(vertical: 40.h,horizontal: 20.w),
                  sliver:  lastViewedProduct == null
                      ? SliverLoadingProduct(2)
                      : SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.45.h,
                      crossAxisCount: 2,
                      crossAxisSpacing: 11.w,
                      mainAxisSpacing: 16.h,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (_, index) {
                        return PerfumeProductItem(
                          variations:  lastViewedProduct[index].variations,

                          id: lastViewedProduct[index].images?[0].id.toString(),
                          imgUrl: lastViewedProduct[index].images?[0].src ?? '',
                          brandName: lastViewedProduct[index].brands!.isNotEmpty
                              ? lastViewedProduct[index].brands != null
                              ? lastViewedProduct[index].brands![0].name
                              : ''
                              : '',
                          perfumeName: lastViewedProduct[index].title ?? '',
                          perfumeRate: double.parse(lastViewedProduct[index].averageRating ?? '0.0'),
                          rateCount: lastViewedProduct[index].ratingCount.toString() ?? '0',
                          priceBeforeDiscount:
                          (lastViewedProduct[index].regularPrice == null) || (lastViewedProduct[index].regularPrice == '0.00')
                              ? (lastViewedProduct[index].price).toString()
                              : lastViewedProduct[index].regularPrice,
                          priceAfterDiscount:
                          (lastViewedProduct[index].salePrice == null) || (lastViewedProduct[index].salePrice == '0.00')
                              ? (lastViewedProduct[index].price).toString()
                              : lastViewedProduct[index].salePrice,
                          onTapBuy: () {
                            print(lastViewedProduct[index].id.toString());
                            Get.to(() => PerfumeDetailsScreen(
                              productId: lastViewedProduct[index].id.toString(),
                            ));
                          },
                        );
                      },
                      childCount: lastViewedProduct.length ?? 0,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
