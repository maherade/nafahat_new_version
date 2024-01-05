import 'package:perfume_store_mobile_app/view/custom_widget/Skelton.dart';

import '../../../services/app_imports.dart';

class LoadingSendRequest extends StatelessWidget {
  const LoadingSendRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skelton(
                    height: 23.h,
                    width: 70.w,
                    radious: 5.r,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Skelton(
                    height: 60.h,
                    width: double.infinity,
                    radious: 7.r,
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Skelton(
                height: 50.h,
                width: 170.w,
                radious: 7.r,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
