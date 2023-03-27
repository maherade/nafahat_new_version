import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors.dart';


class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final TextInputType? inputType;

  const CustomTextFormField({super.key, this.controller, this.hintText,this.prefixIcon,this.suffixIcon,this.fillColor,this.inputType});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType ?? TextInputType.text,
      controller: controller,
      autofocus: false,
      style: const TextStyle(fontSize: 15.0, color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: prefixIcon??null,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 13.sp,
            color: AppColors.grey,
            fontWeight: FontWeight.normal,
            fontFamily: 'urw_din'
          ),
          filled: true,
          fillColor: fillColor??AppColors.whiteColor,
          contentPadding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 18.h),
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
          )
      ),
    );
  }
}
