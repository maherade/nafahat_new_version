import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final int? maxLength;
  final TextInputType? inputType;
  final TextDirection? textDirection;
  final Function(String)? onChange;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.textDirection,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.maxLength,
    this.inputType,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      textDirection: textDirection ?? TextDirection.rtl,
      onChanged: onChange,
      keyboardType: inputType ?? TextInputType.text,
      controller: controller,
      autofocus: false,
      style: const TextStyle(fontSize: 15.0, color: Colors.black),
      decoration: InputDecoration(
        counterText: "",
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 13.sp,
          color: AppColors.grey,
          fontWeight: FontWeight.normal,
          fontFamily: 'urw_din',
        ),
        filled: true,
        fillColor: fillColor ?? AppColors.whiteColor,
        contentPadding: EdgeInsetsDirectional.only(
          start: 10.w,
          end: 3,
          top: 18.h,
          bottom: 18.h,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.greyBorder),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.greyBorder),
          borderRadius: BorderRadius.circular(8.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.greyBorder),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
