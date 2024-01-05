import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../custom_widget/cached_network_image.dart';

class BrandItem extends StatelessWidget {
  final int? index;

  final String? imgUrl;

  final VoidCallback? onTap;

  const BrandItem({super.key, this.index, this.imgUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          index == 0
              ? SizedBox(
                  width: 25.w,
                )
              : const SizedBox(),
          CachedNetworkImageShare(
            urlImage: imgUrl,
            fit: BoxFit.cover,
            heigthNumber: 50.h,
            widthNumber: 60.w,
          ),
          SizedBox(
            width: 16.w,
          ),
        ],
      ),
    );
  }
}
