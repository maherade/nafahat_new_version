import '../../../services/app_imports.dart';
import '../../custom_widget/custom_button.dart';

class DiscountPerfumeItem extends StatelessWidget {
final String? title;
final String? discountPercent;
final String? imgUrl;
final VoidCallback? onTapShoppingNow;

  const DiscountPerfumeItem({super.key, this.title, this.discountPercent, this.imgUrl, this.onTapShoppingNow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 21.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(11.w),
            decoration: BoxDecoration(
              gradient:const LinearGradient(
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0),
                colors: [
                  Color(0xffaae5d3),
                  Color(0xffe4f2ee),
                  Color(0xfff9f3ee),
                  Color(0xfffcdfe6),
                  Color(0xff727b78)
                ],
                stops: [0.0, 0.28, 1.0, 1.0, 1.0],
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          title,
                          fontSize: 12.sp,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(
                          height: 23.h,
                        ),
                        CustomText(
                          discountPercent,
                          fontSize: 16.sp,
                          color: AppColors.greenText,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomButton(
                          onTap: onTapShoppingNow,
                          height: 48.h,
                          width: 133.w,
                          title: 'تسوق الآن',
                          radious: 10.r,
                        )
                      ],
                    )),
                SizedBox(width: 5.w,),
                Expanded(
                    child: Container(
                        height: 130.h,
                        width: 130.w,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Image.asset(
                          'assets/images/$imgUrl.png',
                          width: 130.w,
                          height: 130.h,
                        )))
                // Expanded(
                //     child: CachedNetworkImageShare(
                //       urlImage: imgUrl,
                //       fit: BoxFit.contain,
                //       heigthNumber: 130.h,
                //       widthNumber: 130.w,
                //     ))
              ],
            ),
          ),
          SizedBox(height: 16.h,)
        ],
      ),
    );
  }
}

class ReverseDiscountPerfumeItem extends StatelessWidget {
final String? title;
final String? discountPercent;
final String? imgUrl;
final VoidCallback? onTapShoppingNow;

  const ReverseDiscountPerfumeItem({super.key, this.title, this.discountPercent, this.imgUrl, this.onTapShoppingNow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 21.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(11.w),
            decoration: BoxDecoration(
              gradient:const LinearGradient(
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0),
                colors: [
                  Color(0xffaae5d3),
                  Color(0xffe4f2ee),
                  Color(0xfff9f3ee),
                  Color(0xfffcdfe6),
                  Color(0xff727b78)
                ],
                stops: [0.0, 0.28, 1.0, 1.0, 1.0],
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        height: 130.h,
                        width: 130.w,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Image.asset(
                          'assets/images/$imgUrl.png',
                          width: 130.w,
                          height: 130.h,
                        ))),
                // Expanded(
                //     child: CachedNetworkImageShare(
                //       urlImage: imgUrl,
                //       fit: BoxFit.contain,
                //       heigthNumber: 130.h,
                //       widthNumber: 130.w,
                //     )),
                SizedBox(width: 5.w,),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          title,
                          fontSize: 12.sp,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(
                          height: 23.h,
                        ),
                        CustomText(
                          discountPercent,
                          fontSize: 16.sp,
                          color: AppColors.greenText,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomButton(
                          onTap: onTapShoppingNow,
                          height: 48.h,
                          width: 133.w,
                          title: 'تسوق الآن',
                          radious: 10.r,
                        )
                      ],
                    )),

              ],
            ),
          ),
          SizedBox(height: 16.h,)
        ],
      ),
    );
  }
}
