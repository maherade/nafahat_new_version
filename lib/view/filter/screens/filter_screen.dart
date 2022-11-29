import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';

import '../../../services/app_imports.dart';
import 'filter_result_screen.dart';

class FilterScreen extends StatefulWidget {
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<BrandModel> brandItems = [
    BrandModel('Aesthetica', false),
    BrandModel('Aesthetica', false),
    BrandModel('Aesthetica', false),
    BrandModel('Aesthetica', false),
  ];
  List<CategoryModel> categoryItems = [
    CategoryModel('قسم العطور', true),
    CategoryModel('قسم العناية البشرة', false),
    CategoryModel('قسم المكياج', false),
    CategoryModel('قسم العناية بالشعر', false),
  ];
  RangeValues values = const RangeValues(0, 1000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics:const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      'فرز حسب',
                      fontSize: 18.sp,
                    ),
                    Divider(
                      thickness: 2,
                      height: 29.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('الماركات', fontSize: 18.sp, fontWeight: FontWeight.normal),
                        SizedBox(
                          height: 18.h,
                        ),
                        CustomText(
                          'بحث في الماركات',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xff9E9E9E),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: brandItems.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Checkbox(
                                  value: brandItems[index].checked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      brandItems[index].checked = value;
                                    });
                                  },
                                  activeColor: AppColors.primaryColor,
                                ),
                                CustomText(brandItems[index].brandName, fontSize: 16.sp, fontWeight: FontWeight.normal),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      height: 40.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('السعر', fontSize: 18.sp, fontWeight: FontWeight.normal),
                        RangeSlider(
                            min: 0,
                            max: 1000,
                            activeColor: AppColors.primaryColor,
                            inactiveColor: const Color(0xffE4E4E4),
                            labels: RangeLabels(values.start.round().toString(), values.end.round().toString()),
                            values: values,
                            onChanged: (newValues) {
                              setState(() => values = newValues);
                            }),
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 61.w,
                              height: 37.h,
                              decoration: BoxDecoration(color: AppColors.greyBorder, borderRadius: BorderRadius.circular(8.r)),
                              child: CustomText(values.start.round().toString(), fontSize: 16.sp, fontWeight: FontWeight.normal),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 61.w,
                              height: 37.h,
                              decoration: BoxDecoration(color: AppColors.greyBorder, borderRadius: BorderRadius.circular(8.r)),
                              child: CustomText(values.end.round().toString(), fontSize: 16.sp, fontWeight: FontWeight.normal),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      height: 54.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('القسم', fontSize: 18.sp, fontWeight: FontWeight.normal),
                        SizedBox(
                          height: 18.h,
                        ),
                        CustomText(
                          'بحث في الأقسام',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xff9E9E9E),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: categoryItems.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Checkbox(
                                  value: categoryItems[index].checked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      categoryItems[index].checked = value;
                                    });
                                  },
                                  activeColor: AppColors.primaryColor,
                                ),
                                CustomText(categoryItems[index].categoryName, fontSize: 16.sp, fontWeight: FontWeight.normal),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h,),
                    CustomButton(
                      onTap: (){
                        Get.to(()=>FilterResultScreen());
                      },
                      title:'عرض النتائج',
                      height: 60.h,
                    ),
                    SizedBox(height: 40.h,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BrandModel {
  String? brandName;
  bool? checked;

  BrandModel(this.brandName, this.checked);
}
class CategoryModel {
  String? categoryName;
  bool? checked;

  CategoryModel(this.categoryName, this.checked);
}
