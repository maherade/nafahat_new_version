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
        child: CachedNetworkImageShare(
          urlImage:  imgUrl ?? '',
          widthNumber: double.infinity,
          fit: BoxFit.fill,
          heigthNumber: double.infinity,
        ),
      ),
    );
  }
}
