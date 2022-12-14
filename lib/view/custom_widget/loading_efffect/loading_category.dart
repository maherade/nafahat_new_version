import '../../../services/app_imports.dart';
import '../Skelton.dart';

class LoadingCategory extends StatelessWidget {
  const LoadingCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
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
              SizedBox(
                height: 90.h,
                width: 78.w,
                child: Column(
                  children: [
                    Skelton(
                      height: 52.h,
                      width: 52.w,
                      radious: 0, // circle
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Skelton(
                      height: 10.h,
                      width: 40.w,
                      radious: 14.r,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 9.w,
              ),
            ],
          );
        },
      ),
    );
  }
}

