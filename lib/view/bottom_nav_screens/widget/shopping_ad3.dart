import '../../../services/app_imports.dart';
import '../../custom_widget/custom_button.dart';

class ShoppingAd3 extends StatelessWidget {
final String? imgUrl;
final String? adTitle;
final String? adDescription;
final VoidCallback? onTapSopping;

  const ShoppingAd3({super.key, this.imgUrl, this.adTitle, this.adDescription, this.onTapSopping});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration:
      const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.983, -0.936),
            end: Alignment(-0.986, 1.0),
            colors: [
              Color(0x12aae5d3),
              Color(0x12b4dbce),
              Color(0x12f397ab),
              Color(0x129ecebf)
            ],
            stops: [0.0, 0.485, 1.0, 1.0],
          )
      ),
      child: Row(
        children: [
          Expanded(
              child: CachedNetworkImageShare(
                urlImage:
                imgUrl,
                fit: BoxFit.contain,
                heigthNumber: 88.h,
                widthNumber: 120.w,
              )),
          SizedBox(width: 20.w,),
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    adTitle,
                    fontSize: 14.sp,
                  ),
                  SizedBox(
                    height: 11.h,
                  ),
                  CustomText(
                    adDescription,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.hintGrey,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomButton(
                    onTap: onTapSopping,
                    height: 48.h,
                    width: 154.w,
                    title: 'تسوق الآن',
                    radious: 10.r,
                  )
                ],
              )),


        ],
      ),
    );
  }
}
