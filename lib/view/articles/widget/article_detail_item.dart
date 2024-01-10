import '../../../services/app_imports.dart';

class ArticleDetailItem extends StatelessWidget {
  final String? imgUrl;
  final String? category;
  final String? date;
  final String? title;
  final String? description;
  final VoidCallback? onTapReadMore;

  const ArticleDetailItem({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          fontSize: 18.sp,
          fontWeight: FontWeight.normal,
        ),
        SizedBox(
          height: 18.h,
        ),
        CachedNetworkImageShare(
          urlImage: imgUrl,
          fit: BoxFit.cover,
          heigthNumber: 250.h,
          widthNumber: double.infinity,
          borderRadious: 16.r,
        ),
        SizedBox(
          height: 23.h,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     CustomText(
              //       category,
              //       fontSize: 12.sp,
              //       color: AppColors.primaryColor,
              //     ),
              //     SizedBox(
              //       width: 50.w,
              //     ),
              //     CustomText(
              //       date,
              //       fontSize: 12.sp,
              //       color: AppColors.hintGrey,
              //       fontWeight: FontWeight.normal,
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 14.h,
              // ),
              CustomText(
                description,
                fontSize: 14.sp,
                color: AppColors.hintGrey,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
