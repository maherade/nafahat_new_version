import '../../../services/app_imports.dart';
import '../Skelton.dart';

class LoadingArticleDetails extends StatelessWidget {
  const LoadingArticleDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16.0.r),
          border: Border.all(width: 1.0, color: AppColors.greyBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skelton(
              height: 250.h,
              width: double.infinity,
              radious: 1.r,
            ),
            SizedBox(
              height: 18.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Skelton(
                        height: 10.h,
                        width: 55.w,
                        radious: 10.r,
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      Skelton(
                        height: 10.h,
                        width: 58.w,
                        radious: 10.r,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Skelton(
                    height: 10.h,
                    width: 180.w,
                    radious: 10.r,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(20, (index) => Skelton(
                      height: 10.h,
                      width: double.infinity,
                      radious: 8.r,
                      margin: 5.w,
                    ))),

                  SizedBox(
                    height: 14.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
