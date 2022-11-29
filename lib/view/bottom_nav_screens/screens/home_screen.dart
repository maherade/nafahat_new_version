import 'package:perfume_store_mobile_app/view/bottom_nav_screens/widget/category_item.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/custom_button.dart';
import '../../perfume_details/screens/perfume_details_screen.dart';
import '../widget/brand_item.dart';
import '../widget/discount_perfeum_item.dart';
import '../widget/perfume_product_item.dart';
import '../widget/shopping_ad.dart';
import '../widget/shopping_ad2.dart';
import '../widget/shopping_ad3.dart';
import '../widget/slider_header_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              CachedNetworkImageShare(
                urlImage: 'https://pbs.twimg.com/media/D9dSwaVWsAADIY7.jpg',
                borderRadious: 0,
                fit: BoxFit.cover,
                heigthNumber: 39.h,
                widthNumber: 39.w,
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 250.h,
                      child: PageView.builder(
                        onPageChanged: (index){
                          setState(() => _current = index);
                        },
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return SliderHeaderItem(
                            title: 'أفضل العروض والخصومات في متجر نفحات',
                            description:  'هذا النص هو مثال لنص يمكن أن يستبدل في  نفس  المساحة، لقد تم توليد هذا النص من  مولد النص العربى ',
                            imgUrl: 'https://pbs.twimg.com/media/D9dSwaVWsAADIY7.jpg',
                            onTapShopping: (){},
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [1, 2, 3].asMap().entries.map((entry) {
                        return Container(
                          width: 12.w,
                          height: 12.h,
                          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
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
                ),
                SizedBox(
                  height: 40.h,
                ),
                SizedBox(
                  height: 50.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return BrandItem(
                        index: index,
                        imgUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Gucci_logo.png/180px-Gucci_logo.png',
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
                        'تسوق حسب الأقسام',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    SizedBox(
                      height: 90.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return CategoryItem(
                            index: index,
                            imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiZjqZiPHhz01pFiyTK5gymcx4bn7XilQgr4eu_cEhVrF7ZNKQIi0uSYytf1Vz940z0ZQ&usqp=CAU',
                            title: 'قسم العطور',
                            onTap: (){},
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),

                ShoppingAd(
                  adTitle:'مهرجان الجمال خصومات تصل الى 50%',
                  adImage:  'https://pngimg.com/uploads/perfume/perfume_PNG99988.png',
                 onTapSopping: (){},
                ),
                SizedBox(
                  height: 40.h,
                ),
                Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 21.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText('أشهر المنتجات',fontSize: 16.sp,fontWeight: FontWeight.normal,),
                          GestureDetector(onTap: (){},child: CustomText('عرض الكل',fontSize: 12.sp,fontWeight: FontWeight.normal,)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    SizedBox(
                      height: 40.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                        return Row(
                          children: [
                            index == 0 ? SizedBox(width: 21.w,):SizedBox(),
                            Container(
                              alignment: Alignment.center,
                              height: 38.h,
                              width: 117.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(color: AppColors.greyBorder)
                              ),
                              child: CustomText('قسم العطور',fontSize: 14.sp,fontWeight: FontWeight.normal,color: AppColors.greenText,),
                            ),
                            SizedBox(width: 12.w,)
                          ],
                        );
                      },),
                    )
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                ShoppingAd2(
                  adTitle: 'أفضل العروض والخصومات في متجر نفحات',
                  adImage:  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiZjqZiPHhz01pFiyTK5gymcx4bn7XilQgr4eu_cEhVrF7ZNKQIi0uSYytf1Vz940z0ZQ&usqp=CAU',
                  onTapShopping: (){},
                ),
                SizedBox(
                  height: 32.h,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText('أشهر  منتجات العطور',fontSize: 16.sp,fontWeight: FontWeight.normal,),
                          GestureDetector(onTap: (){},child: CustomText('عرض الكل',fontSize: 12.sp,fontWeight: FontWeight.normal,)),
                        ],
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      GridView.builder(
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
                        itemCount: 4,
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 40.h,),
                ShoppingAd3(
                  imgUrl:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiZjqZiPHhz01pFiyTK5gymcx4bn7XilQgr4eu_cEhVrF7ZNKQIi0uSYytf1Vz940z0ZQ&usqp=CAU',
                  adTitle: 'أفضل بكجات الهدايا في متجر نفحات',
                  adDescription: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النص ',
                  onTapSopping: () {},
                ),
                SizedBox(height: 40.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText('استكشف بكجات الهدايا',fontSize: 16.sp,fontWeight: FontWeight.normal,),
                          GestureDetector(onTap: (){},child: CustomText('عرض الكل',fontSize: 12.sp,fontWeight: FontWeight.normal,)),
                        ],
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      GridView.builder(
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
                        itemCount: 4,
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 43.h,),
                Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Row(
                        children: [
                          CustomText('أشهر الماركات',fontSize: 16.sp,fontWeight: FontWeight.normal,),
                        ],
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2,
                        crossAxisCount: 2,
                        crossAxisSpacing: 11.w,
                        mainAxisSpacing: 16.h,
                      ),
                      itemBuilder: (_, index) {
                        return CachedNetworkImageShare(
                          urlImage: 'https://images.alwatanvoice.com/news/large/9999192429.jpg',
                          fit: BoxFit.cover,
                          heigthNumber: double.infinity,
                          widthNumber: double.infinity,
                          borderRadious: 8.r,
                        );
                      },
                      itemCount: 6,
                    ),
                  ],
                ),
                SizedBox(height: 40.h,),
               ListView.builder(
                 shrinkWrap: true,
                 physics:const NeverScrollableScrollPhysics(),
                 itemCount: 3,
                 itemBuilder: (context, index) {
                 return  DiscountPerfumeItem(
                   title: 'عطور رجالية',
                   discountPercent: '50%',
                   imgUrl:'https://pngimg.com/uploads/perfume/perfume_PNG99997.png',
                   onTapShoppingNow: (){},
                 );
               },),
                SizedBox(height: 40.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText('أشهر منتجات البيع بالجملة',fontSize: 16.sp,fontWeight: FontWeight.normal,),
                          GestureDetector(onTap: (){},child: CustomText('عرض الكل',fontSize: 12.sp,fontWeight: FontWeight.normal,)),
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
                ),
                SizedBox(height: 40.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText('أكثر المنتجات مبيعاً في المكياج',fontSize: 16.sp,fontWeight: FontWeight.normal,),
                          GestureDetector(onTap: (){},child: CustomText('عرض الكل',fontSize: 12.sp,fontWeight: FontWeight.normal,)),
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
                ),
                SizedBox(height: 40.h,),
                ListView.builder(
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return  ReverseDiscountPerfumeItem(
                      title: 'عطور رجالية',
                      discountPercent: '50%',
                      imgUrl:'https://pngimg.com/uploads/perfume/perfume_PNG99997.png',
                      onTapShoppingNow: (){},
                    );
                  },),
                SizedBox(height: 40.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText('منتجات أٌقل من 100 ريال',fontSize: 16.sp,fontWeight: FontWeight.normal,),
                          GestureDetector(onTap: (){},child: CustomText('عرض الكل',fontSize: 12.sp,fontWeight: FontWeight.normal,)),
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
                ),
                SizedBox(height: 40.h,),

              ],
            ),
          ),
        )
      ],
    );
  }
}
