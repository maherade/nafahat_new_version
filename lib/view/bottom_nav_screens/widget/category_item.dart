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
            height: 140,
            width: 80,
            child: Column(
              children: [
                Container(
                  height: 55,
                  width: 52.w,
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
                  height: 11,
                ),
                SizedBox(
                  width: 100,
                  child: CustomText(
                    title,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
        ],
      ),
    );
  }
}
