import 'package:flutter_html/flutter_html.dart';

import '../../../services/app_imports.dart';

class OverviewItem extends StatelessWidget {
  final String? title;
  final String? advantages;

  const OverviewItem({super.key, this.title, this.advantages});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Html(
              data: advantages,
              style: {
                "h2": Style(
                  fontSize: FontSize(12.0),
                  fontWeight: FontWeight.bold,
                ),
                "p": Style(
                  fontSize: FontSize(15.0),
                  padding: HtmlPaddings.symmetric(vertical: 10.h),
                  lineHeight: const LineHeight(1.8),
                  fontWeight: FontWeight.normal,
                ),
              },
            ),
          ),
          // CustomText(
          //  title,
          //   fontSize: 16.sp,
          //   color: AppColors.grey,
          // ),
          // SizedBox(
          //   height: 15.h,
          // ),
          // SizedBox(
          //   width: 232.w,
          //   child: CustomText(
          //     advantages,
          //     fontSize: 16.sp,
          //     color: AppColors.grey,
          //     fontWeight: FontWeight.normal,
          //   ),
          // ),
          SizedBox(
            height: 26.h,
          ),
          // CustomText(
          //   'الميزات الأساسية',
          //   fontSize: 16.sp,
          //   color: AppColors.grey,
          // ),
          // SizedBox(
          //   height: 15.h,
          // ),
          // Column(
          //   children: [1, 2, 3]
          //       .map((e) => Container(
          //     padding: EdgeInsets.all(18.w),
          //     margin: EdgeInsets.symmetric(vertical: 5.h),
          //     decoration: BoxDecoration(
          //       color: const Color(0xfffffcfd),
          //       borderRadius: BorderRadius.circular(8.0.r),
          //     ),
          //     child: Row(
          //       children: [
          //         CustomText('اسم اللون',
          //             fontSize: 14.sp,
          //             color: const Color(0xffAFAFAF),
          //             fontWeight: FontWeight.normal),
          //         Spacer(),
          //         CustomText('109',
          //             fontSize: 14.sp,
          //             color: const Color(0xffAFAFAF),
          //             fontWeight: FontWeight.normal),
          //         SizedBox(
          //           width: 8.w,
          //         ),
          //         CustomText('ورد طبيعي',
          //             fontSize: 14.sp,
          //             color: const Color(0xffAFAFAF),
          //             fontWeight: FontWeight.normal),
          //       ],
          //     ),
          //   ))
          //       .toList(),
          // ),
        ],
      ),
    );
  }
}
