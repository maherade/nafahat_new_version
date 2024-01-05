import 'package:flutter/material.dart';
import 'package:perfume_store_mobile_app/services/app_imports.dart';
import 'package:perfume_store_mobile_app/view/auth/screens/confirm_phone_code.dart';

import '../auth/screens/confirm_email_code.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:  10.h,),
                CustomText(
                  'استعادة كلمة المرور',
                  fontSize:  25.sp,
                  fontWeight: FontWeight.normal,
                ),
                SizedBox(height:  5.h,),
                CustomText(
                  'قم باستعادة كلمة المرور خاصتك باتباع الخطوات التالية',
                  fontSize:  14.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.grey,
                ),
                SizedBox(height:  30.h,),
                DefaultTabController(
                  initialIndex: 0,
                  length: 2,
                  child: TabBar(
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                        print(selectedIndex);
                      });
                    },
                    indicatorColor: AppColors.primaryColor,
                    isScrollable: false,
                    indicatorSize: TabBarIndicatorSize.tab,
                    // tabAlignment: TabAlignment.fill,
                    labelColor: AppColors.primaryColor,
                    unselectedLabelColor: AppColors.grey,
                    labelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: [
                      Tab(
                        child: CustomText(
                          'رقم الهاتف',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: selectedIndex == 0
                              ? AppColors.primaryColor
                              : AppColors.grey,
                        ),
                      ),
                      Tab(
                        child: CustomText(
                          'البريد الالكتروني',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: selectedIndex == 1
                              ? AppColors.primaryColor
                              : AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height*.2),
                selectedIndex == 0 ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      'رقم الهاتف',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      textInputAction:
                      TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.grey
                            .withOpacity(.1),
                        hintText: 'ادخل رقم هاتفك',
                        prefixIcon: Padding(
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 10.0),
                          child: Image.asset(
                            "assets/images/call.png",
                            color: AppColors.blackColor
                                .withOpacity(.8),
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'urw_din',
                        ),
                        prefixIconConstraints:
                        const BoxConstraints(
                            minWidth: 0,
                            minHeight: 0),
                        prefixStyle:
                        const TextStyle(color: Colors.grey),
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
                      height: MediaQuery.sizeOf(context).height*.3,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context) =>const ConfirmPhoneCode()
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
                        'التالي',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),

                  ],
                )
               :Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      'البريد الالكتروني',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType:
                      TextInputType.emailAddress,
                      textInputAction:
                      TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.grey
                            .withOpacity(.1),
                        hintText: 'ادخل بريدك الالكتروني',
                        prefixIcon: Padding(
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 10.0),
                          child: Image.asset(
                            "assets/images/message.png",
                            color: AppColors.blackColor
                                .withOpacity(.8),
                            width: 20.w,
                            height: 20.h,
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
                      height: MediaQuery.sizeOf(context).height*.3,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context) =>const ConfirmEmailCode()
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
                        'التالي',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
