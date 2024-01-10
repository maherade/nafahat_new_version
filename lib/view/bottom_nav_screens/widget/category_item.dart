import '../../../services/app_imports.dart';

class CategoryItem extends StatelessWidget {
  final int? index;
  final String? imgUrl;
  final String? title;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    this.index,
    this.imgUrl,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          index == 0
              ? const SizedBox(
                  width: 10,
                )
              : const SizedBox(),
          SizedBox(
            height: 200,
            width: 80,
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 75.w,
                  padding: EdgeInsets.all(5.w),
                  decoration: const BoxDecoration(
                    color: AppColors.greyContainer,
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImageShare(
                    urlImage: imgUrl,
                    fit: BoxFit.contain,
                    heigthNumber: double.infinity,
                    widthNumber: double.infinity,
                    borderRadious: 0,
                  ),
                ),
                const SizedBox(
                  height: 5,
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
          SizedBox(
            height: 8.w,
          ),
        ],
      ),
    );
  }
}
