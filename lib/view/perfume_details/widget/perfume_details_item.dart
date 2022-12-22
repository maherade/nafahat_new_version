
import '../../../services/app_imports.dart';
import '../../custom_widget/custom_rate_write_bar.dart';

class PerfumeDetailsItem extends StatefulWidget {
  final List? imgUrl;
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
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 233.h,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                onPageChanged: (index) {
                  setState(() => _current = index);
                },
                itemCount: widget.imgUrl?.length,
                itemBuilder: (context, index) {
                  return   Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: AppColors.whiteColor),
                    height: 233.h,
                    width: double.infinity,
                    child: CachedNetworkImageShare(
                      urlImage: widget.imgUrl?[index].src,
                      fit: BoxFit.contain,
                      heigthNumber: 233.h,
                      widthNumber: double.infinity,
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.imgUrl!.asMap().entries.map((entry) {
                    return Container(
                      width:_current == entry.key ? 35.w : 10.w,
                      height: 10.h,
                      margin: EdgeInsets.symmetric( horizontal: 3.w),
                      decoration: BoxDecoration(
                          borderRadius: _current == entry.key ? BorderRadius.circular(12.r):null,
                          shape: _current == entry.key ? BoxShape.rectangle :BoxShape.circle,
                          color: _current == entry.key ?AppColors.primaryColor :AppColors.greyBorder),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
