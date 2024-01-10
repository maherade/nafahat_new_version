import 'package:shimmer/shimmer.dart';

import '../../../services/app_imports.dart';
import '../Skelton.dart';
import '../custom_rate_write_bar.dart';

class LoadingProduct extends StatelessWidget {
  final int count;

  const LoadingProduct(this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    Size dSize = MediaQuery.of(context).size;

    return GridView.builder(
      itemCount: count,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: dSize.width > 400 && dSize.width <= 500
            ? 1/1.5 : 1/2,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 15,
      ),
      itemBuilder: (_, index) {
        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.greyBorder, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Skelton(
                    height: 62.h,
                    width: 82.w,
                    radious: 14.r,
                  )
                ],
              ),
              SizedBox(
                height: 27.h,
              ),
              Skelton(
                height: 10.h,
                width: 45.w,
                margin: 5,
              ),
              Skelton(
                height: 10.h,
                width: 140.w,
                margin: 5,
              ),
              Skelton(
                height: 10.h,
                width: 130.w,
                margin: 5,
              ),
              Skelton(
                height: 10.h,
                width: 120.w,
                margin: 5,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: CustomRateRead(
                      size: 15.w,
                      rate: 0.0,
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Skelton(
                    height: 15.h,
                    width: 20.w,
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Skelton(
                    height: 10.h,
                    width: 45.w,
                    margin: 5,
                  ),
                ],
              ),
              Row(
                children: [
                  Skelton(
                    height: 10.h,
                    width: 45.w,
                    margin: 5,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Skelton(
                    height: 35.h,
                    width: 35.w,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
