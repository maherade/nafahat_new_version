import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../custom_widget/cached_network_image.dart';

class BrandItem extends StatelessWidget {
final int? index ;
final String? imgUrl ;

  const BrandItem({super.key, this.index, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        index == 0
            ? SizedBox(
          width: 25.w,
        )
            : const SizedBox(),
        CachedNetworkImageShare(
          urlImage:
          imgUrl,
          fit: BoxFit.cover,
          heigthNumber: 30.h,
          widthNumber: 72.w,
        ),
        SizedBox(
          width: 16.w,
        ),
      ],
    );
  }
}
