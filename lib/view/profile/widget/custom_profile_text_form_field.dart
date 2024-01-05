import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../colors.dart';
import '../../custom_widget/custom_text.dart';

class CustomProfileTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? topTitle;
  final Widget? suffixIcon;
  final int? maxLines;
  final String? Function(String?)? validator;

  const CustomProfileTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.topTitle,
    this.suffixIcon,
    this.maxLines,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          topTitle ?? "",
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
        SizedBox(
          height: 12.h,
        ),
        TextFormField(
          maxLines: maxLines ?? 1,
          controller: controller,
          validator: validator,
          autofocus: false,
          style: const TextStyle(fontSize: 15.0, color: Colors.black),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 13.sp,
              color: AppColors.grey,
              fontWeight: FontWeight.normal,
              fontFamily: 'urw_din',
            ),
            // filled: true,
            // fillColor: AppColors.whiteColor,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 18.h),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.greyBorder, width: 3),
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.greyBorder, width: 3),
              borderRadius: BorderRadius.circular(8.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.greyBorder, width: 3),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
