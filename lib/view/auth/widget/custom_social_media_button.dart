import 'package:flutter_svg/svg.dart';

import '../../../services/app_imports.dart';

class CustomFacebookButton extends StatelessWidget {
final VoidCallback? onTap;

  const CustomFacebookButton({super.key, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color:const  Color(0xff395693),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/f.svg',
              fit: BoxFit.contain,
            ),
            SizedBox(width: 12.w,),
            CustomText('فيس بوك',fontSize: 10.sp,color: AppColors.whiteColor,fontWeight: FontWeight.normal,)
          ],
        ),
      ),
    );
  }
}
class CustomGoogleButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomGoogleButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 1.0, color: const Color(0xff121212)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/g.svg',
              fit: BoxFit.contain,
            ),
            SizedBox(width: 12.w,),
            CustomText('جوجل',fontSize: 12.sp,fontWeight: FontWeight.normal,)
          ],
        ),
      ),
    );
  }
}
