
import '../../../services/app_imports.dart';
import '../../custom_widget/custom_rate_write_bar.dart';

class PerfumeDetailsItem extends StatefulWidget {
  final String? imgUrl;
  final String? brandName;
  final String? perfumeName;
  final double? perfumeRate;
  final String? rateCount;
  final String? priceBeforeDiscount;
  final String? priceAfterDiscount;
  const PerfumeDetailsItem(
      {super.key,
      this.imgUrl,
      this.brandName,
      this.perfumeName,
      this.perfumeRate,
      this.rateCount,
      this.priceBeforeDiscount,
      this.priceAfterDiscount,
      });

  @override
  State<PerfumeDetailsItem> createState() => _PerfumeDetailsItemState();
}

class _PerfumeDetailsItemState extends State<PerfumeDetailsItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: AppColors.greyBorder),
          height: 233.h,
          width: double.infinity,
          child: CachedNetworkImageShare(
            urlImage: widget.imgUrl,
            fit: BoxFit.contain,
            heigthNumber: 159.h,
            widthNumber: 297.w,
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            children: [
              CustomText(
                widget.brandName,
                color: const Color(0xff678185),
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomText(
                widget.perfumeName,
                fontSize: 14.sp,
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  CustomRateRead(
                    size: 15.w,
                    rate: widget.perfumeRate,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  CustomText(
                    widget.rateCount,
                    color: AppColors.itemGrey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      CustomText(widget.priceBeforeDiscount,
                          color: AppColors.priceBrownColor, fontSize: 16.sp, fontWeight: FontWeight.normal, underline: true),
                      CustomText(' ر.س', color: AppColors.priceBrownColor, fontSize: 16.sp, fontWeight: FontWeight.normal),
                    ],
                  ),
                  SizedBox(
                    width: 83.w,
                  ),
                  Row(
                    children: [
                      CustomText(
                        widget.priceAfterDiscount,
                        color: AppColors.greenText,
                        fontSize: 16.sp,
                      ),
                      CustomText(
                        ' ر.س',
                        color: AppColors.greenText,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),


      ],
    );
  }
}
