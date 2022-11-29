import '../../services/app_imports.dart';

class CustomButton extends StatelessWidget {
final double? height ;
final double? width ;
final double? radious ;
final String? title ;
final Widget? widget ;
final double? titleSize ;
final Color? titleColor ;
final Color? borderColor ;
final Color? color ;
final VoidCallback? onTap;

  const CustomButton({super.key, this.height, this.width, this.radious, this.title,this.widget,this.titleSize,this.titleColor,this.borderColor, this.color,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height??30.h,
        width: width??double.infinity,
        decoration: BoxDecoration(
          color: color??AppColors.primaryColor,
          borderRadius: BorderRadius.circular(radious??8.r),
          border: borderColor != null ?Border.all(color: borderColor!):null
        ),
        child: widget!=null?widget:CustomText(title,fontSize: titleSize??14,fontWeight: FontWeight.bold,color: titleColor??AppColors.whiteColor,),
      ),
    );
  }
}
