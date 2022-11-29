import 'package:flutter_svg/svg.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_rate_write_bar.dart';

import '../../../services/app_imports.dart';
import '../../bottom_nav_screens/widget/perfume_product_item.dart';
import '../../custom_widget/custom_text_form_field.dart';
import '../widget/overview_item.dart';
import '../widget/perfume_details_item.dart';
import '../widget/rating_item.dart';

class PerfumeDetailsScreen extends StatefulWidget {
  @override
  State<PerfumeDetailsScreen> createState() => _PerfumeDetailsScreenState();
}

class _PerfumeDetailsScreenState extends State<PerfumeDetailsScreen> {
  TextEditingController addCommentController = TextEditingController();

  List<Color> listColor = [
    AppColors.priceBrownColor,
    AppColors.starYellowColor,
    AppColors.blackColor,
    AppColors.greenText,
    AppColors.priceBrownColor,
  ];

  int currentIndex = 0;
  int overviewAndRatingToggle = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: const BackButton(),
          ),
          SizedBox(
            height: 17.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.w),
            child: CustomText(
              'الرئيسية/البيع بالجملة/قسم المكياج/تفاصيل المنتج',
              color: const Color(0xff707070),
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PerfumeDetailsItem(
                    imgUrl: 'https://pngimg.com/uploads/perfume/perfume_PNG99995.png',
                    brandName: 'ماركة توب فيس',
                    perfumeName: 'عطر سكيندال من جين بول جولتير للنساء',
                    perfumeRate: 4,
                    rateCount: '(255)',
                    priceBeforeDiscount: '152.55',
                    priceAfterDiscount: '10',
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    height: 30.h,
                    child: Row(
                      children: [
                        SizedBox(width: 15.w,),
                        Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: listColor.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() => currentIndex = index);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                                  height: 24.h,
                                  width: 24.w,
                                  decoration: BoxDecoration(
                                      color: listColor[index],
                                      shape: BoxShape.circle,
                                      border: currentIndex == index
                                          ? Border.all(color: AppColors.primaryColor, width: 5)
                                          : null),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 18.0.w),
                    child: SizedBox(
                      width: 245.w,
                      child: CustomText(
                        'تقدم العلامة التجارية الخاصة بنا مجموعة متنوعةمن العبايات والجلابيات والقفطان. فهذه العلامةالتجارية تتميز بإضفاء مزيج من التفاصيل التقليديةمع لمسة عصرية على كل النساء. تتميز المجموعةبالبساطة والأناقة. كما توفر العلامة التجاريةتشكيلة كبيرة من الملابس المريحة والملونة لأداءالصلاة.',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff707070),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: CustomButton(
                      onTap: () {},
                      height: 50.h,
                      radious: 6.r,
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/cart.svg',
                            color: AppColors.whiteColor,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(
                            'أضف الى السلة',
                            fontSize: 16.sp,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.normal,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        width: 1.0,
                        color: AppColors.greyBorder,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() => overviewAndRatingToggle = 0);
                          },
                          child: CustomText(
                            'نظرة عامة',
                            fontSize: 16.sp,
                            color: overviewAndRatingToggle == 0 ? AppColors.primaryColor : AppColors.blackColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => overviewAndRatingToggle = 1);
                          },
                          child: CustomText(
                            'التقييمات',
                            fontSize: 16.sp,
                            color: overviewAndRatingToggle == 1 ? AppColors.primaryColor : AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 19.h,
                  ),
                  overviewAndRatingToggle == 0
                      ? OverviewItem()
                      : Column(
                          children: [
                            CustomTextFormField(
                              hintText: 'أضف تعليق',
                              controller: addCommentController,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(15),
                                child: CachedNetworkImageShare(
                                  urlImage:
                                      'https://img.freepik.com/premium-photo/3d-character-male-cartoon-with-eye-glasses-yellow-orange-polo-shirt-good-profile-picture_477250-8.jpg?w=740',
                                  fit: BoxFit.contain,
                                  heigthNumber: 32.h,
                                  widthNumber: 32.w,
                                  borderRadious: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            ListView.builder(
                              itemCount: 4,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return const RatingItem(
                                  imgUrl: 'https://img.freepik.com/premium-photo/3d-character-male-cartoon-with-eye-glasses-yellow-orange-polo-shirt-good-profile-picture_477250-8.jpg?w=740',
                                  name: 'سارة أحمد',
                                  date: '11/11/2022',
                                  rate: 4,
                                  comment:'هذا النص هو مثال لنص يمكن أنيستبدل في نفس المساحة، لقد تم هذالنص من مولد النص العربى، حيث يمكنكأن تولد مثل توليد هذا النص أو العديد ',

                                );
                              },
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomText(
                              'أخر المشاهدات',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                        GridView.builder(
                          itemCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.65.h,
                            crossAxisCount: 2,
                            crossAxisSpacing: 11.w,
                            mainAxisSpacing: 16.h,
                          ),
                          itemBuilder: (_, index) {
                            return PerfumeProductItem(
                              imgUrl:
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiZjqZiPHhz01pFiyTK5gymcx4bn7XilQgr4eu_cEhVrF7ZNKQIi0uSYytf1Vz940z0ZQ&usqp=CAU',
                              brandName: 'Essence',
                              perfumeName: 'عطر لازورد',
                              perfumeRate: 3,
                              rateCount: '(25555)',
                              priceBeforeDiscount: '152.55',
                              priceAfterDiscount: '10',
                              onTapBuy: () {
                                Get.to(() => PerfumeDetailsScreen());
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
