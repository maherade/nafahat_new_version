import '../../../services/app_imports.dart';
import '../../custom_widget/custom_button.dart';

class ShoppingAd extends StatelessWidget {
  final String? adTitle;
  final String? adImage;
  final VoidCallback? onTapSopping;

  const ShoppingAd({super.key, this.adTitle, this.adImage, this.onTapSopping});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(11.w),
      decoration: BoxDecoration(
        color: const Color(0x2be6f8f2),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40b2b2b2),
            offset: Offset(0.30000001192092896, 0.30000001192092896),
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                adTitle,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(
                height: 17.h,
              ),
              CustomButton(
                onTap: onTapSopping,
                height: 48.h,
                width: 133.w,
                title: 'تسوق الآن',
                radious: 10.r,
              )
            ],
          )),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
              child: Container(
                  height: 130.h,
                  width: 130.w,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                  child: Image.asset(
            'assets/images/girl.png',
            width: 130.w,
            height: 130.h,
          )))
          // Expanded(
          //     child: CachedNetworkImageShare(
          //       urlImage:
          //      adImage,
          //       fit: BoxFit.contain,
          //       heigthNumber: 130.h,
          //       widthNumber: 130.w,
          //       borderRadious: 8.r,
          //     ))
        ],
      ),
    );
  }
}
