import '../../../services/app_imports.dart';
import '../../custom_widget/custom_rate_write_bar.dart';

class RatingItem extends StatelessWidget {
  final String? imgUrl;
  final String? name;
  final String? date;
  final double? rate;
  final String? comment;

  const RatingItem({
    super.key,
    this.imgUrl,
    this.name,
    this.date,
    this.rate,
    this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(width: 1.0, color: AppColors.greyBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImageShare(
            urlImage: imgUrl,
            fit: BoxFit.contain,
            heigthNumber: 32.h,
            widthNumber: 32.w,
            borderRadious: 0,
          ),
          SizedBox(
            width: 6.w,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  name,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
                SizedBox(
                  height: 14.h,
                ),
                CustomText(
                  date,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.grey,
                ),
                SizedBox(
                  height: 14.h,
                ),
                CustomRateRead(
                  size: 20.w,
                  rate: rate,
                ),
                SizedBox(
                  height: 17.h,
                ),
                CustomText(
                  comment,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.grey,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
