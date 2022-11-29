import '../../../services/app_imports.dart';

class OverviewItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'الميزات الأساسية',
            fontSize: 16.sp,
            color: AppColors.grey,
          ),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            width: 232.w,
            child: CustomText(
              'فاه بلمسة نهائية مكثفة ومشرقة لون يثبت علىالشفاه لنتيجة تدوم حتى 12 ساعة منتج مضادللتلطخ ويجف بسرعة تمنح تركيبته المنعمة الشفاهمظهراً مشرقاً وساطعاً المنتج مختبر من قبل أطباءالجلد',
              fontSize: 16.sp,
              color: AppColors.grey,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 26.h,
          ),
          CustomText(
            'الميزات الأساسية',
            fontSize: 16.sp,
            color: AppColors.grey,
          ),
          SizedBox(
            height: 15.h,
          ),
          Column(
            children: [1, 2, 3]
                .map((e) => Container(
              padding: EdgeInsets.all(18.w),
              margin: EdgeInsets.symmetric(vertical: 5.h),
              decoration: BoxDecoration(
                color: const Color(0xfffffcfd),
                borderRadius: BorderRadius.circular(8.0.r),
              ),
              child: Row(
                children: [
                  CustomText('اسم اللون',
                      fontSize: 14.sp,
                      color: const Color(0xffAFAFAF),
                      fontWeight: FontWeight.normal),
                  Spacer(),
                  CustomText('109',
                      fontSize: 14.sp,
                      color: const Color(0xffAFAFAF),
                      fontWeight: FontWeight.normal),
                  SizedBox(
                    width: 8.w,
                  ),
                  CustomText('ورد طبيعي',
                      fontSize: 14.sp,
                      color: const Color(0xffAFAFAF),
                      fontWeight: FontWeight.normal),
                ],
              ),
            ))
                .toList(),
          ),

        ],
      ),
    );
  }
}
