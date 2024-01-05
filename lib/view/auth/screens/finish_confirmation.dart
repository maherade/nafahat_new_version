import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../colors.dart';
import '../../custom_widget/custom_text.dart';

class FinishConfirmation extends StatefulWidget {
  const FinishConfirmation({super.key});

  @override
  State<FinishConfirmation> createState() => _FinishConfirmationState();
}

class _FinishConfirmationState extends State<FinishConfirmation> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h,),
                CustomText(
                  'إعادة تعيين كلمة المرور',
                  fontSize:  25.sp,
                  fontWeight: FontWeight.normal,
                ),
                SizedBox(height:  5.h,),
                CustomText(
                  'يمكنك الان كتابة كلمة المرور الجديدة',
                  fontSize:  14.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.grey,
                ),
                SizedBox(height:  MediaQuery.sizeOf(context).height*.25,),
                CustomText(
                  'كلمة المرور',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
                SizedBox(
                  height: 12.h,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.grey
                        .withOpacity(.1),
                    hintText: 'قم بإدخال كلمة المرور',
                    prefixIcon: Padding(
                      padding:
                      const EdgeInsets.symmetric(
                          horizontal: 10.0),
                      child: Image.asset(
                        "assets/images/lock.png",
                        color: AppColors.blackColor
                            .withOpacity(.8),
                        width: 30.w,
                        height: 30.h,
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets
                            .symmetric(
                            horizontal: 10.0),
                        child: Image.asset(
                          "assets/images/hide.png",
                          color: AppColors.blackColor
                              .withOpacity(.8),
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                    ),
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'urw_din',
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 15.h),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.blackColor
                              .withOpacity(.2)),
                      borderRadius:
                      BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.blackColor
                              .withOpacity(.2)),
                      borderRadius:
                      BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                //confirm password
                CustomText(
                  'تأكيد كلمة المرور',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
                SizedBox(
                  height: 12.h,
                ),
                TextFormField(
                  controller:
                  confirmPasswordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.grey
                        .withOpacity(.1),
                    hintText: 'قم بتأكيد كلمة المرور',
                    prefixIcon: Padding(
                      padding:
                      const EdgeInsets.symmetric(
                          horizontal: 10.0),
                      child: Image.asset(
                        "assets/images/lock.png",
                        color: AppColors.blackColor
                            .withOpacity(.8),
                        width: 30.w,
                        height: 30.h,
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets
                            .symmetric(
                            horizontal: 10.0),
                        child: Image.asset(
                          "assets/images/hide.png",
                          color: AppColors.blackColor
                              .withOpacity(.8),
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                    ),
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'urw_din',
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 15.h),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.blackColor
                              .withOpacity(.2)),
                      borderRadius:
                      BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.blackColor
                              .withOpacity(.2)),
                      borderRadius:
                      BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height*.2,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) =>const FinishConfirmation()
                    ),
                    );
                  },
                  height: 50.h,
                  minWidth: double.infinity,
                  color: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(25),
                  ),
                  child: Text(
                    'انتهاء',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),


              ],
            ),
          ) ,
        ),
      ),
    );
  }
}
