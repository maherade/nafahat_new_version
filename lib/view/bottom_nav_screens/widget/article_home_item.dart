import '../../../services/app_imports.dart';

class ArticleHomeItem extends StatelessWidget {
  final String? imgUrl;
  final String? category;
  final String? date;
  final String? title;
  final String? description;
  final VoidCallback? onTapReadMore;

  const ArticleHomeItem({
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
      width: 270.w,
      margin: EdgeInsets.symmetric(horizontal: 21.w, vertical: 8.h),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.0.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImageShare(
            urlImage: imgUrl,
            fit: BoxFit.cover,
            heigthNumber: 100.h,
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
                  CustomText(
                    date,
                    fontSize: 12.sp,
                    color: AppColors.hintGrey,
                    fontWeight: FontWeight.normal,
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
                  CustomText(
                    description,
                    fontSize: 12.sp,
                    color: AppColors.hintGrey,
                    fontWeight: FontWeight.normal,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 2.w,
                      ),
                      CustomText(
                        'قراءة المزيد',
                        fontSize: 12.sp,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppColors.primaryColor,
                      )
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
