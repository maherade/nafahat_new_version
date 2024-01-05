import '../../../services/app_imports.dart';

class ArticleItem extends StatelessWidget {
  final String? imgUrl;
  final String? category;
  final String? date;
  final String? title;
  final String? description;
  final VoidCallback? onTapReadMore;

  const ArticleItem({
    super.key,
    this.imgUrl,
    this.category,
    this.date,
    this.title,
    this.description,
    this.onTapReadMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 21.w, vertical: 8.h),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.0.r),
        border: Border.all(width: 1.0, color: AppColors.greyBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImageShare(
            urlImage: imgUrl,
            fit: BoxFit.cover,
            heigthNumber: 171.h,
            widthNumber: double.infinity,
          ),
          SizedBox(
            height: 18.h,
          ),
          GestureDetector(
            onTap: onTapReadMore,
            child: Container(
              color: Colors.transparent,
              width: 300.w,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        category,
                        fontSize: 12.sp,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      CustomText(
                        date,
                        fontSize: 12.sp,
                        color: AppColors.hintGrey,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  CustomText(
                    title,
                    fontSize: 14.sp,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: CustomText(
                          description,
                          fontSize: 12.sp,
                          color: AppColors.hintGrey,
                          fontWeight: FontWeight.normal,
                          maxLines: 4,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      CustomText(
                        'مشاهدة المزيد',
                        fontSize: 12.sp,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
