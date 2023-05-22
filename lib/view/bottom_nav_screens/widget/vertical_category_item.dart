
import '../../../services/app_imports.dart';

class VerticalCategoryItem extends StatelessWidget {
  final int? index ;
  final String? imgUrl ;
  final String? title ;
  final VoidCallback? onTap ;

  const VerticalCategoryItem({super.key, this.index, this.imgUrl, this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: AppColors.greyBorder)),
      child:  GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 110.h,
          width: 78.w,
          child: Column(
            children: [
              Container(
                height: 60.h,
                width: 52.w,
                padding: EdgeInsets.all(5.w),
                decoration: const BoxDecoration(
                  color: AppColors.greyContainer,
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImageShare(
                  urlImage:
                  imgUrl,
                  fit: BoxFit.contain,
                  heigthNumber: double.infinity,
                  widthNumber: double.infinity,
                  borderRadious: 0,
                ),
              ),
              SizedBox(
                height: 11.h,
              ),
              SizedBox(
                width: 100,
                child: CustomText(
                  title,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
