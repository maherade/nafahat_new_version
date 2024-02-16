import 'package:flutter/cupertino.dart';
import 'package:perfume_store_mobile_app/apies/brand_apies.dart';
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';
import 'package:perfume_store_mobile_app/controller/category_controller.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_text_form_field.dart';

import '../../../apies/category_apies.dart';
import '../../../apies/product_apies.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/loading_efffect/loading_filter_category.dart';
import 'filter_result_screen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  CategoryController categoryController = Get.find();
  BrandController brandController = Get.find();
  RangeValues values = const RangeValues(0, 1000);
  int currentIndex = 0;
  int categoryId = 27;
  String categoryName = 'الأجهزة';

  int? selectedBrandId;
  String? selectedBrandName;

  int? selectedCategoryId;
  String? selectedCategoryName;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CategoryApies.categoryApies.getCategoryData('0');
      BrandApies.brandApies.getBrandData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () {
          var category =
              categoryController.getCategoryData!.value.listCategoryResponse;
          var brand = brandController.getBrandData!.value.listBrandResponse;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 83.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.close,
                          size: 30.w,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          'filter'.tr,
                          color: AppColors.blackColor,
                          fontSize: 18.sp,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            'shop_by_category_value'.tr,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          category == null
                              ? const LoadingFilterCategory()
                              : SizedBox(
                            height: 60.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: category.length < 6
                                  ? category.length
                                  : 6,
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
                                        setState(
                                              () => currentIndex = index,
                                        );
                                        setState(
                                              () => selectedCategoryName =
                                          category[index].name!,
                                        );
                                        setState(
                                              () => selectedBrandId =
                                          category[index].id!,
                                        );
                                         setState(() {
                                           selectedCategoryId = category[index].id;
                                         });
                                        ProductApies.productApies
                                            .getFamousProductData(
                                          category: category[index]
                                              .id
                                              .toString(),
                                          onSale: true,
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 60.h,
                                        width: 130.h,
                                        padding: EdgeInsets.all(5.w),
                                        decoration: BoxDecoration(
                                          color: currentIndex == index
                                              ? AppColors.primaryColor
                                              : AppColors.whiteColor,
                                          borderRadius:
                                          BorderRadius.circular(30.r),
                                          border: Border.all(
                                            color: AppColors.greyBorder,
                                          ),
                                        ),
                                        child: CustomText(
                                          category[index].name,
                                          fontSize: 14.sp,
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
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            'price_value'.tr,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          RangeSlider(
                            min: 0,
                            max: 1000,
                            activeColor: AppColors.primaryColor,
                            inactiveColor: const Color(0xffE4E4E4),
                            labels: RangeLabels(
                              values.start.round().toString(),
                              values.end.round().toString(),
                            ),
                            values: values,
                            onChanged: (newValues) {
                              setState(() => values = newValues);
                              debugPrint(values.start.toInt().toString());
                              debugPrint(values.end.toInt().toString());
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 61.w,
                                height: 37.h,
                                child: CustomText(
                                  values.start.round().toString(),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 61.w,
                                height: 37.h,
                                child: CustomText(
                                  values.end.round().toString(),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            'brands_value'.tr,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal,
                          ),

                          // CustomTextFormField(
                          //   hintText: 'search_by_brand_value'.tr,
                          //   onChange: (value) {
                          //     BrandApies.brandApies
                          //         .getBrandData(search: value);
                          //   },
                          // ),
                          brand == null
                              ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                              : brand.isEmpty
                              ? CustomText(
                            'لا تتوفر نتائج',
                            fontSize: 13.sp,
                          )
                              : SizedBox(
                              height: 500,
                              width: double.infinity,
                              child: GridView.count(
                                childAspectRatio: 1 / .5,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 3,
                                children: List.generate(
                                    brand.length,
                                        (index) => Row(
                                      children: [
                                        // Checkbox(
                                        //   value: selectedBrandId ==
                                        //       int.parse(
                                        //         brand[index].data!.termId,
                                        //       ),
                                        //   onChanged: (bool? value) {
                                        //     debugPrint(
                                        //       {
                                        //         int.parse(
                                        //           brand[index]
                                        //               .data!
                                        //               .termId!,
                                        //         )
                                        //       }.toString(),
                                        //     );
                                        //     debugPrint(
                                        //       brand[index].data?.name,
                                        //     );
                                        //     setState(() {
                                        //       selectedBrandId = int.parse(
                                        //         brand[index]
                                        //             .data!
                                        //             .termId!,
                                        //       );
                                        //       selectedBrandName =
                                        //           brand[index].data?.name;
                                        //     });
                                        //   },
                                        //   activeColor:
                                        //   AppColors.primaryColor,
                                        // ),
                                        Expanded(
                                          child: Container(
                                            height: 50.h,
                                            padding:
                                            const EdgeInsets.all(
                                                10),
                                            alignment:
                                            Alignment.center,
                                            decoration:
                                            BoxDecoration(
                                              color: AppColors
                                                  .primaryColor,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  50),
                                            ),
                                            child: CustomText(
                                              brand[index]
                                                  .data
                                                  ?.name,
                                              fontSize: 13.sp,
                                              textAlign: TextAlign
                                                  .center,
                                              color: AppColors
                                                  .whiteColor,
                                              maxLines: 1,
                                              fontWeight:
                                              FontWeight
                                                  .normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ),
                              ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      CustomButton(
                        onTap: () {
                          if (selectedCategoryId != null) {
                            Get.to(
                                  () => FilterResultScreen(
                                categoryName: selectedCategoryName,
                                categoryId: selectedCategoryId,
                                brandName: selectedBrandName,
                                brandId: selectedBrandId,
                                maxPrice: values.end.toInt(),
                                minPrice: values.start.toInt(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'please_select_category_value'.tr,
                                ),
                              ),
                            );
                          }
                        },
                        title: 'view_result_value'.tr,
                        height: 60.h,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                    ],
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
