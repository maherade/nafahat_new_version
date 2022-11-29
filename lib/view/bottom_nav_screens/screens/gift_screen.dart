import 'package:flutter_svg/svg.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../services/app_imports.dart';
import '../../filter/screens/filter_screen.dart';
import '../../perfume_details/screens/perfume_details_screen.dart';
import '../widget/perfume_product_item.dart';
import '../widget/shopping_ad3.dart';
class GiftScreen extends StatefulWidget {
  @override
  State<GiftScreen> createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> {
  @override
  String? selectedCategory;
  final NumberPaginatorController _controller = NumberPaginatorController();
  int? currentPage ;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.h,
          ),
          ShoppingAd3(
            imgUrl:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiZjqZiPHhz01pFiyTK5gymcx4bn7XilQgr4eu_cEhVrF7ZNKQIi0uSYytf1Vz940z0ZQ&usqp=CAU',
            adTitle: 'أفضل بكجات الهدايا في متجر نفحات',
            adDescription: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النص ',
            onTapSopping: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomText('تسوق من قسم المكياج',fontWeight: FontWeight.bold,fontSize: 14.sp,),
                    const Spacer(),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color:const Color(0xffF5E7EA), width:1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 7.0.w),
                        child: DropdownButton<String>(
                          underline:const SizedBox(),
                          focusColor:Colors.white,
                          value: selectedCategory,
                          style:  TextStyle(color: Colors.white,fontSize: 10.sp),
                          iconEnabledColor:Colors.black,
                          items: <String>[
                            'الأكثر شعبية',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: CustomText(value,fontSize: 10.sp,),
                            );
                          }).toList(),
                          hint:CustomText(
                            "التصنيف",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w,),
                    GestureDetector(
                      onTap: (){Get.to(()=>FilterScreen());},
                      child: SvgPicture.asset(
                        'assets/svg/filter.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                GridView.builder(
                  itemCount: 8,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.65.h,
                    crossAxisCount: 2,
                    crossAxisSpacing: 11.w,
                    mainAxisSpacing: 16.h,
                  ),
                  itemBuilder: (_, index) {
                    return PerfumeProductItem(
                      imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiZjqZiPHhz01pFiyTK5gymcx4bn7XilQgr4eu_cEhVrF7ZNKQIi0uSYytf1Vz940z0ZQ&usqp=CAU',
                      brandName: 'Essence',
                      perfumeName: 'عطر لازورد',
                      perfumeRate: 3,
                      rateCount: '(25555)',
                      priceBeforeDiscount: '152.55',
                      priceAfterDiscount: '10',
                      onTapBuy: (){
                        Get.to(()=>PerfumeDetailsScreen());
                      },
                    );
                  },
                ),
                SizedBox(height: 40.h,),
                NumberPaginator(
                  controller: _controller,
                  numberPages: 20,
                  config: NumberPaginatorUIConfig(
                      contentPadding: EdgeInsets.zero,
                      buttonSelectedBackgroundColor: AppColors.primaryColor,
                      buttonUnselectedForegroundColor: AppColors.blackColor,
                      buttonShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          side: BorderSide(color: AppColors.greyBorder)
                      )
                  ),

                  onPageChange: (int index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                ),
                SizedBox(height: 40.h,),
                Column(
                  children: [
                    Row(
                      children: [
                        CustomText('أخر المشاهدات',fontSize: 16.sp,fontWeight: FontWeight.normal,),
                      ],
                    ),

                    GridView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.65.h,
                        crossAxisCount: 2,
                        crossAxisSpacing: 11.w,
                        mainAxisSpacing: 16.h,
                      ),
                      itemBuilder: (_, index) {
                        return PerfumeProductItem(
                          imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiZjqZiPHhz01pFiyTK5gymcx4bn7XilQgr4eu_cEhVrF7ZNKQIi0uSYytf1Vz940z0ZQ&usqp=CAU',
                          brandName: 'Essence',
                          perfumeName: 'عطر لازورد',
                          perfumeRate: 3,
                          rateCount: '(25555)',
                          priceBeforeDiscount: '152.55',
                          priceAfterDiscount: '10',
                          onTapBuy: (){
                            Get.to(()=>PerfumeDetailsScreen());
                          },
                        );
                      },

                    ),

                  ],
                ),
                SizedBox(height: 90.h,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
