import '../../../services/app_imports.dart';
import '../Skelton.dart';

class LoadingContainerCategory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Row(
            children: [
              index == 0
                  ? SizedBox(
                width: 21.w,
              )
                  : const SizedBox(),
              Container(
                alignment: Alignment.center,
                height: 38.h,
                width: 117.h,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(5.r),
                    border: Border.all(color: AppColors.greyBorder)),
                child: Skelton(
                  height: 10.h,
                  width: 35.w,
                  radious: 10.r,
                ),
              ),
              SizedBox(
                width: 12.w,
              )
            ],
          );
        },
      ),
    );
  }
}

