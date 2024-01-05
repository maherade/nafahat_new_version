import 'package:perfume_store_mobile_app/view/custom_widget/Skelton.dart';

import '../../../services/app_imports.dart';

class LoadingArticle extends StatelessWidget {
  const LoadingArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 21.w, vertical: 8.h),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(16.0.r),
            border: Border.all(width: 1.0, color: AppColors.greyBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skelton(
                height: 171.h,
                width: double.infinity,
                radious: 1.r,
              ),
              SizedBox(
                height: 18.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Skelton(
                          height: 10.h,
                          width: 55.w,
                          radious: 10.r,
                        ),
                        SizedBox(
                          width: 50.w,
                        ),
                        Skelton(
                          height: 10.h,
                          width: 58.w,
                          radious: 10.r,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Skelton(
                      height: 10.h,
                      width: 230.w,
                      radious: 10.r,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Skelton(
                      height: 10.h,
                      width: 250.w,
                      radious: 10.r,
                      margin: 3.w,
                    ),
                    Skelton(
                      height: 10.h,
                      width: 240.w,
                      radious: 10.r,
                      margin: 3.w,
                    ),
                    Skelton(
                      height: 10.h,
                      width: 230.w,
                      radious: 10.r,
                      margin: 3.w,
                    ),
                    Skelton(
                      height: 10.h,
                      width: 220.w,
                      radious: 10.r,
                      margin: 3.w,
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
