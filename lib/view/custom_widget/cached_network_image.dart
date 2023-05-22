import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:skeleton_text/skeleton_text.dart';

class CachedNetworkImageShare extends StatelessWidget {
  final String? urlImage;
  final double? widthNumber;
  final double? heigthNumber;
  final double? borderRadious;
  final BoxFit? fit;

 const CachedNetworkImageShare(
      { this.urlImage, this.heigthNumber, this.widthNumber, this.borderRadious=1,
      required this.fit});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: urlImage!,
      placeholderFadeInDuration: Duration.zero,
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      imageBuilder: (context, imageProvider) => Container(
        width: widthNumber,
        height: heigthNumber,
        decoration: BoxDecoration(
          shape: borderRadious == 0 ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: borderRadious != 0 ? BorderRadius.circular(borderRadious!) : null,
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        width: widthNumber,
        height: heigthNumber,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          shape: borderRadious == 0 ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: Container(
          width: widthNumber,
          height: heigthNumber,
          decoration: BoxDecoration(
            shape: borderRadious == 0 ? BoxShape.circle : BoxShape.rectangle,
            color: Colors.grey[200],
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: widthNumber,
        height: heigthNumber,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          shape: borderRadious == 0 ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: Container(
          width: widthNumber,
          height: heigthNumber,
          decoration: BoxDecoration(
            shape: borderRadious == 0 ? BoxShape.circle : BoxShape.rectangle,
            color: Colors.grey[200],
          ),
        )
      ),
    );
  }
}
