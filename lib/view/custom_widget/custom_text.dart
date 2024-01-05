import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final TextAlign? textAlign;
  final Color? color;
  final bool underline;
  final FontWeight? fontWeight;
  final int? maxLines;
  final String? fontFamily;

  const CustomText(
    this.text, {
    super.key,
    this.fontSize,
    this.textAlign,
    this.color,
    this.fontWeight,
    this.underline = false,
    this.maxLines,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'استبدل',
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: fontSize ?? 18.sp,
        color: color ?? Colors.black,
        fontFamily: fontFamily ?? 'din',
        decoration:
            underline ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }
}
