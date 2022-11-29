import '../../../services/app_imports.dart';

class CustomAuthButton extends StatelessWidget {
final VoidCallback? onTap;
final String? title;

  const CustomAuthButton({super.key, this.onTap, this.title});
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8.r)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(title,fontSize: 14.sp,fontWeight: FontWeight.normal,color: AppColors.whiteColor,),
            SizedBox(width: 27.w,),
            const Icon(Icons.arrow_forward,color: AppColors.whiteColor,)
          ],
        ),
      ),
    );
  }
}
