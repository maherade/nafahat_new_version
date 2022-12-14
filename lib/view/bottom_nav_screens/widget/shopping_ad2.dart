import '../../../services/app_imports.dart';
import '../../custom_widget/custom_button.dart';

class ShoppingAd2 extends StatelessWidget {
  final String? adTitle;
  final String? adImage;
  final VoidCallback? onTapShopping;

  const ShoppingAd2({super.key, this.adTitle, this.adImage,this.onTapShopping});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(11.w),
      decoration:
      BoxDecoration(color: Color(0x8afcf5f7).withOpacity(0.03), borderRadius: BorderRadius.circular(8.r)),
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
                    height: 13.h,
                  ),
                  CustomButton(
                    onTap: onTapShopping,
                    height: 48.h,
                    width: 154.w,
                    title: 'تسوق الآن',
                    radious: 10.r,
                  )
                ],
              )),
          SizedBox(width: 20.w,),
          Expanded(
              child: Container(
                height: 88.h,
                  width: 120.w,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Image.asset(
                    'assets/images/perfume.png',
                    width: 120.w,
                    height: 88.h,
                  )))
          // Expanded(
          //     child: CachedNetworkImageShare(
          //       urlImage:adImage,
          //       fit: BoxFit.contain,
          //       heigthNumber: 88.h,
          //       widthNumber: 120.w,
          //     ))
        ],
      ),
    );
  }
}
