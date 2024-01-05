import 'package:perfume_store_mobile_app/view/custom_widget/Skelton.dart';
import 'package:shimmer/shimmer.dart';

import '../../../services/app_imports.dart';
import '../custom_rate_write_bar.dart';

class LoadingPerfumeDetail extends StatelessWidget {
  const LoadingPerfumeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          child: const BackButton(),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Skelton(
                    width: 200.w,
                    height: 10.h,
                    radious: 5.r,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Skelton(
                  width: double.infinity,
                  height: 260.h,
                  radious: 1.r,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Skelton(
                        width: 70.w,
                        height: 13.h,
                        radious: 5.r,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Skelton(
                        width: 300.w,
                        height: 13.h,
                        radious: 5.r,
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: CustomRateRead(
                              size: 15.w,
                              rate: 0,
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Skelton(
                            width: 8.w,
                            height: 8.h,
                            radious: 5.r,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Skelton(
                                width: 20.w,
                                height: 13.h,
                                radious: 5.r,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Skelton(
                                width: 15.w,
                                height: 13.h,
                                radious: 5.r,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 83.w,
                          ),
                          Row(
                            children: [
                              Skelton(
                                width: 20.w,
                                height: 13.h,
                                radious: 5.r,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Skelton(
                                width: 15.w,
                                height: 13.h,
                                radious: 5.r,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 30.h,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Skelton(
                                        width: 24.w,
                                        height: 24.h,
                                        radious: 0.r,
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          20,
                          (index) => Skelton(
                            height: 10.h,
                            width: MediaQuery.of(context).size.width - 100,
                            radious: 8.r,
                            margin: 5.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
