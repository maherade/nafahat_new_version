import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skelton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? margin;
  final double? radious;

  const Skelton({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.radious,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: margin ?? 0),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: radious == 0 ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: radious != null && radious != 0
              ? BorderRadius.circular(radious!)
              : null,
        ),
      ),
    );
  }
}
