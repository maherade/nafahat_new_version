import 'package:flutter_svg/svg.dart';

import '../../../services/app_imports.dart';
import '../../custom_widget/cached_network_image.dart';
import '../../custom_widget/custom_button.dart';

class SliderHeaderItem extends StatelessWidget {
final String? imgUrl;
final String? title;
final String? description;
final VoidCallback? onTapShopping;


  const SliderHeaderItem({super.key, this.imgUrl, this.title, this.description, this.onTapShopping,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  title,
                  fontSize: 16.sp,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomText(
                 description,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.hintGrey,
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomButton(
                  height: 48.h,
                  width: 150.w,
                  title: 'تسوق الآن',
                  titleSize: 16.sp,
                  radious: 4.r,
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/u.svg',
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 29.2.h,
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                width: 134.w,
                    height: 134.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle
                    ),
                    child: Image.asset('assets/images/slider_image.png',width: 134.w,height: 134.h,)),
                // CachedNetworkImageShare(
                //   urlImage: imgUrl,
                //   borderRadious: 0,
                //   fit: BoxFit.cover,
                //   heigthNumber: 134.h,
                //   widthNumber: 134.w,
                // ),
                SizedBox(height: 18.3.h),
                SvgPicture.asset(
                  'assets/svg/d.svg',
                  fit: BoxFit.contain,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
