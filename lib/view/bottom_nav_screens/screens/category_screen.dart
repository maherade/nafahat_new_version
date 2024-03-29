import 'package:flutter/cupertino.dart';
import 'package:perfume_store_mobile_app/apies/brand_apies.dart';
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';
import 'package:perfume_store_mobile_app/view/shop_by_brand/screen/shop_by_brand_screen.dart';
import 'package:perfume_store_mobile_app/view/shop_by_category/screen/shop_by_category.dart';

import '../../../apies/category_apies.dart';
import '../../../apies/product_apies.dart';
import '../../../controller/category_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../model/ads_response.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/custom_search_bar.dart';
import '../../search/screen/search_screen.dart';
import '../widget/vertical_category_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController categoryController = Get.find();
  ProductController productController = Get.find();
  BrandController brandController = Get.find();

  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  int expandedIndex = -1;
  int lastOne = -1;

  int? selectedSubCategoryId = 1877;
  String? selectedSubCategoryName = '';

  @override
  void initState() {
    ProductApies.productApies.listProduct = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String selectAdTitle = 'بنر قسم الاجهزة ';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var product = productController.getProductData!.value.data;
        var category =
            categoryController.getCategoryData!.value.listCategoryResponse;
        var subCategory = categoryController
            .getSubCategoryData!.value.listSubCategoryResponse;
        var brand = brandController.getBrandData!.value.listBrandResponse;
        // var ads = productController.getAdsData?.value.listAdsResponse;
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
            CategoryApies.categoryApies.getCategoryData('0');
            CategoryApies.categoryApies.getSubCategoryData('2444');
            ProductApies.productApies
                .getProductData(pageNumber: '1', category: '2447');
            BrandApies.brandApies.getBrandData(categoryID: '2444');
          },
          child: SingleChildScrollView(
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
                        Get.to(
                          () => SearchScreen(
                            word: searchController.text,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: category == null
                                ? const CupertinoActivityIndicator()
                                : SizedBox(
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: category.length < 6
                                          ? category.length
                                          : 6,
                                      itemBuilder: (context, index) {
                                        return VerticalCategoryItem(
                                          index: index,
                                          imgUrl:
                                              category[index].image?.src ?? '',
                                          title: category[index].name,
                                          onTap: () {
                                            debugPrint(
                                              category[index].id.toString(),
                                            );
                                            setState(() {
                                              switch (index) {
                                                case 0:
                                                  selectAdTitle =
                                                      'بنر قسم المكياج';
                                                  break;
                                                case 1:
                                                  selectAdTitle =
                                                      'بنر قسم العناية';
                                                  break;
                                                case 2:
                                                  selectAdTitle =
                                                      'بنر قسم الأظافر';
                                                  break;
                                                case 3:
                                                  selectAdTitle =
                                                      'بنر قسم الاجهزة ';
                                                  break;
                                                case 4:
                                                  selectAdTitle =
                                                      'بنر قسم العطور ';
                                                  break;
                                                case 5:
                                                  selectAdTitle =
                                                      'بنر قسم العدسات';
                                                  break;
                                              }
                                            });
                                            BrandApies.brandApies.getBrandData(
                                              categoryID:
                                                  category[index].id.toString(),
                                            );
                                            CategoryApies.categoryApies
                                                .getSubCategoryData(
                                              category[index].id.toString(),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                getAd(title: selectAdTitle) == null
                                    ? SizedBox(
                                        height: 150.h,
                                      )
                                    : SizedBox(
                                        height: 200.h,
                                        child: SizedBox(
                                          height: 200.h,
                                          child: ClipRRect(
                                            // borderRadius: BorderRadius.circular(15),
                                            child: CachedNetworkImageShare(
                                              urlImage:
                                                  getAd(title: selectAdTitle)
                                                          ?.image ??
                                                      '',
                                              widthNumber: double.infinity,
                                              heigthNumber: double.infinity,
                                              borderRadious: 3,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                subCategory == null
                                    ? const CupertinoActivityIndicator()
                                    : subCategory.isEmpty
                                        ? CustomText(
                                            'select_from_category_value'.tr,
                                          )
                                        : Container(
                                            padding: EdgeInsets.all(5.w),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.greyBorder,
                                              ),
                                            ),
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: subCategory.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return ExpansionTile(
                                                  key: index == lastOne
                                                      ? const Key("selected")
                                                      : Key(index.toString()),
                                                  initiallyExpanded:
                                                      index == expandedIndex,
                                                  onExpansionChanged: (value) {
                                                    setState(() {
                                                      lastOne = expandedIndex;
                                                      selectedSubCategoryId =
                                                          subCategory[index].id;
                                                      selectedSubCategoryName =
                                                          subCategory[index]
                                                              .name;
                                                    });
                                                    debugPrint(
                                                        index.toString());
                                                    debugPrint(
                                                        lastOne.toString());
                                                    if (value) {
                                                      expandedIndex = index;
                                                    } else {
                                                      expandedIndex = -1;
                                                    }

                                                    ProductApies.productApies
                                                        .getProductData(
                                                      pageNumber: '1',
                                                      category:
                                                          subCategory[index]
                                                              .id
                                                              .toString(),
                                                    );
                                                  },
                                                  title: CustomText(
                                                    subCategory[index].name,
                                                    fontSize: 12.sp,
                                                  ),
                                                  children: [
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    product == null
                                                        ? const CupertinoActivityIndicator()
                                                        : GridView.builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            itemCount:
                                                                product.length >
                                                                        4
                                                                    ? 4
                                                                    : product
                                                                        .length,
                                                            shrinkWrap: true,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            gridDelegate:
                                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                              childAspectRatio:
                                                                  0.58.h,
                                                              crossAxisCount: 2,
                                                              crossAxisSpacing:
                                                                  11.w,
                                                              mainAxisSpacing:
                                                                  16.h,
                                                            ),
                                                            itemBuilder:
                                                                (_, index) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  Get.to(
                                                                    () =>
                                                                        ShopByCategoryScreen(
                                                                      categoryId:
                                                                          selectedSubCategoryId,
                                                                      categoryName:
                                                                          selectedSubCategoryName,
                                                                    ),
                                                                  );
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .all(
                                                                        10.w,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              AppColors.greyBorder,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          CachedNetworkImageShare(
                                                                        urlImage: product[index]
                                                                            .images?[0]
                                                                            .src
                                                                            .toString(),
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        heigthNumber:
                                                                            100.h,
                                                                        widthNumber:
                                                                            double.infinity,
                                                                        borderRadious:
                                                                            5,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          5.h,
                                                                    ),
                                                                    CustomText(
                                                                      product[index]
                                                                          .title,
                                                                      fontSize:
                                                                          11.sp,
                                                                      maxLines:
                                                                          1,
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          )
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                brand == null
                                    ? const CupertinoActivityIndicator()
                                    : Container(
                                        padding: EdgeInsets.all(5.w),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.greyBorder,
                                          ),
                                        ),
                                        child: ExpansionTile(
                                          onExpansionChanged: (value) {},
                                          title: CustomText(
                                            'famous_brand_value'.tr,
                                            fontSize: 12.sp,
                                          ),
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            GridView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: brand.length > 100
                                                  ? 100
                                                  : brand.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 0.80.h,
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 11.w,
                                                mainAxisSpacing: 16.h,
                                              ),
                                              itemBuilder: (_, index) {
                                                debugPrint(
                                                  brand[index].logo.toString(),
                                                );
                                                return Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(
                                                          ShopByBrandScreen(
                                                            brandId:
                                                                brand[index]
                                                                    .data!
                                                                    .termId,
                                                            brandName:
                                                                brand[index]
                                                                    .data
                                                                    ?.name,
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                          10.w,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: AppColors
                                                                .greyBorder,
                                                          ),
                                                        ),
                                                        child:
                                                            CachedNetworkImageShare(
                                                          urlImage: brand[index]
                                                                  .logo ??
                                                              '',
                                                          fit: BoxFit.fill,
                                                          heigthNumber: 50.h,
                                                          widthNumber: 50.w,
                                                          borderRadious: 5,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
//
