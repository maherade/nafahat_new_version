import '../../../services/app_imports.dart';

class AdItem extends StatelessWidget {
  final String? imgUrl;

  const AdItem({super.key, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        height: 200.h,
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: CachedNetworkImageShare(
            urlImage: imgUrl ?? '',
            widthNumber: double.infinity,
            fit: BoxFit.fill,
            heigthNumber: double.infinity,
          ),
        ),
      ),
    );
  }
}
