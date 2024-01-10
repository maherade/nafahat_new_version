import 'package:perfume_store_mobile_app/apies/brand_apies.dart';
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/Skelton.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_text_form_field.dart';
import 'package:perfume_store_mobile_app/view/shop_by_brand/screen/shop_by_brand_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/app_imports.dart';
import '../../search/screen/search_screen.dart';

class ShowAllBrandScreen extends StatefulWidget {
  const ShowAllBrandScreen({super.key});

  @override
  State<ShowAllBrandScreen> createState() => _ShopByBrandScreenState();
}

class _ShopByBrandScreenState extends State<ShowAllBrandScreen> {
  TextEditingController searchController = TextEditingController();

  BrandController brandController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CustomText(
        'brands_value'.tr,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Image.asset(
              "assets/images/logo.png",
              height: 43.h,
              width: 43.w,
            ),
          ),

        ],
      ),
      body: Obx(
        () {
          var brand = brandController.getBrandData!.value.listBrandResponse;

          return RefreshIndicator(
            displacement: 250,
            backgroundColor: AppColors.whiteColor,
            color: AppColors.primaryColor,
            strokeWidth: 3,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: () async {
              BrandApies.brandApies.getBrandData();
            },
            child: Padding(
              padding:   EdgeInsets.symmetric(horizontal: 17.0.w, vertical: 14.h),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
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
                                'assets/images/search.png',
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

                          ),
                        ),
                      ),

                      SizedBox(
                        height: 19.h,
                      ),
                      brand != null
                          ? GridView.builder(

                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: (){
                                    Get.to(
                                          () => ShopByBrandScreen(
                                        brandId:
                                        int.parse(brand[index].data!.termId!),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 140.h ,
                                    width: 80.w,
                                    decoration:
                                    BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: AppColors.greyBorder,
                                      )
                                    ),
                                    child:  CachedNetworkImageShare(
                                      urlImage: brand[index].logo ?? '',
                                      fit: BoxFit.contain,
                                      heigthNumber: 50.h,
                                      widthNumber: 60.w,
                                    ),
                                  ),
                                );

                                //   ListTile(
                                //   onTap: () {
                                //     Get.to(
                                //       () => ShopByBrandScreen(
                                //         brandId:
                                //             int.parse(brand[index].data!.termId!),
                                //       ),
                                //     );
                                //   },
                                //   title: CustomText(
                                //     brand[index].data?.name,
                                //     fontSize: 15.sp,
                                //   ),
                                //   trailing: CachedNetworkImageShare(
                                //     urlImage: brand[index].logo ?? '',
                                //     fit: BoxFit.contain,
                                //     heigthNumber: 50.h,
                                //     widthNumber: 60.w,
                                //   ),
                                // );
                              },
                              itemCount: brand.length,
                               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.80,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              ),
                            )
                          : GridView.builder(
                              padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    height: 140.h ,

                                    width: 80.w,
                                    decoration:
                                    BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                color: AppColors.greyBorder,
                                ),
                                ),
                                child: Skelton(
                                  height: 50.h,
                                  width: 60.w,
                                ),
                                );
                              },
                              itemCount: 50, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.80,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              ),
                            ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
