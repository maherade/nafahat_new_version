import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../colors.dart';
import 'custom_text.dart';

class CustomTextFormFieldWithTopTitle extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? topTitle;
  final Widget? suffixIcon;
  final int? maxLines;
  final Color? borderColor;
  final void Function(String)? onChange;
  final String? Function(String?)? validator;

  const CustomTextFormFieldWithTopTitle(
      {super.key, this.controller, this.hintText,this.borderColor, this.topTitle, this.suffixIcon,this.onChange, this.maxLines,this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          topTitle ?? "",
          fontSize: 15.sp,
          fontWeight: FontWeight.normal,
        ),
        SizedBox(
          height: 12.h,
        ),
        TextFormField(
          onChanged: onChange,
          maxLines: maxLines ?? 1,
          controller: controller,
          validator:validator,
          autofocus: false,
          style: const TextStyle(fontSize: 15.0, color: Colors.black),
          decoration: InputDecoration(
              suffixIcon: suffixIcon ?? null,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.grey,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'urw_din'),
              // filled: true,
              // fillColor: AppColors.whiteColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w, vertical: 15.h),
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(color:borderColor?? AppColors.greyBorder),
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.greyBorder),
                borderRadius: BorderRadius.circular(8.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.greyBorder),
                borderRadius: BorderRadius.circular(8.0),
              )),
        ),
      ],
    );
  }
}
