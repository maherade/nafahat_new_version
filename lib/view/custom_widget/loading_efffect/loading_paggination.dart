import '../../../services/app_imports.dart';
import '../Skelton.dart';

class LoadingPaggination extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          padding: EdgeInsets.all(8.w),
          alignment: Alignment.center,
          height: 50.h,
          width: 50.h,
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(color: AppColors.greyBorder)),
          child: Skelton(
            height: index == 0 || index == 6 ? 10.h : 20.h,
            width: index == 0 || index == 6 ? 10.h : 10.h,
            radious: 10.r,
          ),
        );
      },),
    );
  }
}

