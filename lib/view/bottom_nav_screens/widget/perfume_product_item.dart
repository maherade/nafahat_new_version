import 'package:flutter_svg/svg.dart';

import '../../../services/app_imports.dart';
import '../../custom_widget/custom_rate_write_bar.dart';

class PerfumeProductItem extends StatelessWidget {
final String? imgUrl;
final String? brandName;
final String? perfumeName;
final double? perfumeRate;
final String? rateCount;
final String? priceBeforeDiscount;
final String? priceAfterDiscount;
final VoidCallback? onTapBuy;

  const PerfumeProductItem({super.key, this.imgUrl, this.brandName, this.perfumeName, this.perfumeRate, this.rateCount, this.priceBeforeDiscount, this.priceAfterDiscount, this.onTapBuy});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTapBuy,
          child: Container(
            padding: EdgeInsets.all(12.w),
            width: 162.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.greyBorder,width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImageShare(
                      urlImage: imgUrl,
                      fit: BoxFit.contain,
                      heigthNumber: 120.h,
                      widthNumber: 82.w,
                      borderRadious: 14.r,
                    ),
                  ],
                ),
                SizedBox(
                  height: 17.h,
                ),
                CustomText(brandName,color: AppColors.itemGrey,fontSize: 12.sp,fontWeight: FontWeight.normal,),
                CustomText(perfumeName,fontSize: 14.sp,fontWeight: FontWeight.normal,maxLines: 2,),
                Row(
                  children: [
                    CustomRateRead(size: 15.w,rate: perfumeRate,),
                    SizedBox(width: 4.w,),
                    CustomText(rateCount,color: AppColors.itemGrey,fontSize: 12.sp,fontWeight: FontWeight.normal,),
                  ],
                ),
                Row(
                  children: [
                    CustomText(priceBeforeDiscount,color: AppColors.priceBrownColor,fontSize: 16.sp,fontWeight: FontWeight.normal,underline: true),
                    CustomText('ر.س',color: AppColors.priceBrownColor,fontSize: 16.sp,fontWeight: FontWeight.normal),
                  ],
                ),
                Row(
                  children: [
                    CustomText(priceAfterDiscount,color: AppColors.greenText,fontSize: 16.sp,),
                    CustomText('ر.س',color: AppColors.greenText,fontSize: 16.sp,),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/buy.svg',
                      fit: BoxFit.contain,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
