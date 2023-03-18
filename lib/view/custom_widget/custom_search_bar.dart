import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors.dart';


class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final VoidCallback? onTapSearch;

  const CustomSearchBar({super.key, this.controller, this.hintText, this.prefixIcon, this.suffixIcon, this.fillColor, this.onTapSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r)
        ),
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: TextFormField(
                controller: controller,
                autofocus: false,
                style: const TextStyle(fontSize: 15.0, color: Colors.black),

                decoration: InputDecoration(
                    prefixIcon: prefixIcon??null,
                    suffixIcon: suffixIcon,
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'din'
                    ),
                    filled: true,
                    fillColor: fillColor??AppColors.whiteColor,
                    contentPadding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
                    focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.only(
                        topRight:Radius.circular(15.0.r),
                        bottomRight:Radius.circular(15.0.r),

                      ),                  ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.only(
                        topRight:Radius.circular(15.0.r),
                        bottomRight:Radius.circular(15.0.r),

                      ),                  ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.only(
                          topRight:Radius.circular(15.0.r),
                          bottomRight:Radius.circular(15.0.r),

                      ),
                    )
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: onTapSearch,
                child: Container(
                  height: 48.h,
                  decoration:const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft:Radius.circular(8.0),
                      bottomLeft:Radius.circular(8.0),
                  ),),
                  child: Icon(Icons.search,color: Colors.white,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
