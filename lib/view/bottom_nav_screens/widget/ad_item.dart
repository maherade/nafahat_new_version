import 'dart:math';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

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
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(15),
          child: FancyShimmerImage(
            imageUrl: imgUrl ?? '',
            width: double.infinity,
            height: 50,
            shimmerBaseColor: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
            shimmerHighlightColor: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
            shimmerBackColor: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
            errorWidget: SizedBox(),
          ),
        ),
      ),
    );
  }
}
