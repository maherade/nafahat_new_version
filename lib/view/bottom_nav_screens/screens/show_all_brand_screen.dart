import 'package:flutter/cupertino.dart';
import 'package:perfume_store_mobile_app/apies/brand_apies.dart';
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/Skelton.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_search_bar.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_text_form_field.dart';
import 'package:perfume_store_mobile_app/view/shop_by_brand/screen/shop_by_brand_screen.dart';
import '../../../services/app_imports.dart';
import '../../search/screen/search_screen.dart';

class ShowAllBrandScreen extends StatefulWidget {
  @override
  State<ShowAllBrandScreen> createState() => _ShopByBrandScreenState();
}

class _ShopByBrandScreenState extends State<ShowAllBrandScreen> {
  TextEditingController searchController = TextEditingController();

  BrandController brandController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BrandApies.brandApies.getBrandData();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var brand = brandController.getBrandData!.value.listBrandResponse;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: CustomText(
                  'shop_by_brand_value'.tr,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: CustomTextFormField(
                  onChange: (value) {
                    BrandApies.brandApies.getBrandData(search: value);
                  },
                  hintText: 'search_by_brand_value'.tr,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: brand != null
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              Get.to(() => ShopByBrandScreen(
                                    brandId: int.parse(brand[index].data!.termId!),
                                  ));
                            },
                            title: CustomText(
                              brand[index].data?.name,
                              fontSize: 15.sp,
                            ),
                            trailing: CachedNetworkImageShare(
                              urlImage: brand[index].logo ?? '',
                              fit: BoxFit.cover,
                              heigthNumber: 50.h,
                              widthNumber: 60.w,
                            ),
                          );
                        },
                        itemCount: brand.length,
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5.h),
                            child: Row(
                              children: [
                                Skelton(
                                  height: 50.h,
                                  width: 60.w,
                                ),
                                Spacer(),
                                Skelton(
                                  height: 10.h,
                                  width: 100.w,
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: 50,
                      ),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
