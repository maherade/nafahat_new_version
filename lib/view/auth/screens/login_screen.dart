// ignore_for_file: must_be_immutable, camel_case_types

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:perfume_store_mobile_app/view/auth/screens/register_screen.dart';
import 'package:perfume_store_mobile_app/view/auth/screens/verification_code_screen.dart';
import 'package:perfume_store_mobile_app/view/reset_password/reset_passwrod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../apies/auth_apies.dart';
import '../../../privacy_policy.dart';
import '../../../services/app_imports.dart';
import '../../bottom_nav_screens/screens/nav_bar_screen.dart';
import '../../custom_widget/custom_text_form_field_with_top_title.dart';
import '../../teems_and_conditions.dart';
import '../widget/custom_auth_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  int selectedIndex = 0;

  @override
  void initState() {
    // emailController.text = 'basimshawwa';
    // passwordController.text = 'x0iYfv4KfNVt';
    super.initState();
  }

  Future<void> signInWithApple() async {
    Dio dio = Dio();
    // Set the headers property of the Dio instance.
    dio.options.headers['username'] = "islam";
    dio.options.headers['password'] = 'mIjL 9IDN 85ka jMRq 0G5F BSv0';
    dio.options.headers['Content-Type'] = 'application/json';

    try {
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Retrieve the ID token
      String? idToken = credential.identityToken;
      log('apple idToken: $idToken');

      // Sign the user in (or link) with the credential
      Map<String, dynamic> params = {
        'auth': {"id_token": idToken},
        'provider': 'apple',
      };
      log('apple params: $params');
      try {
        final x = await dio.post(
          'https://nafahat.com/wp-json/nafahat/api/v1/social?auth=id_token&provider=apple',
        );
        log('apple response: $x');
      } catch (e) {
        log('apple error: $e');
      }

      // Use the ID token as needed
      // ...
    } on PlatformException catch (error) {
      // Handle any errors that occur during the sign-in process
      print('Error signing in with Apple: ${error.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity ,
            child: Stack(
                  children: [
            Image.asset(
              'assets/images/login_pic.png',
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            Positioned(
              top: 130.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                // height: MediaQuery.sizeOf(context).height,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.r),
                    topRight: Radius.circular(50.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            'تسجيل الدخول',
                            fontSize: 25.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          CustomText(
                            'سجل دخولك من اجل الاستمرار في استخدام التطبيق',
                            fontSize: 14.sp,
                            color: AppColors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          DefaultTabController(
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
                              tabAlignment: TabAlignment.fill,
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
                          SizedBox(
                            height: 20.h,
                          ),

                          //phone number tab
                          selectedIndex == 0
                              ? SingleChildScrollView(
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 90.h,
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Image.asset(
                                    "assets/images/back_login_button.png",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: MediaQuery.sizeOf(context).height,
                                    opacity: const AlwaysStoppedAnimation(.2),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
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
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                        AppColors.grey.withOpacity(.1),
                                        hintText: 'ادخل رقم هاتفك',
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
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
                                        prefixIconConstraints: BoxConstraints(
                                            minWidth: 0, minHeight: 0),
                                        prefixStyle:
                                        TextStyle(color: Colors.grey),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 15.h),
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
                                        fillColor:
                                        AppColors.grey.withOpacity(.1),
                                        hintText: 'قم بإدخال كلمة المرور',
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
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
                                            padding:
                                            const EdgeInsets.symmetric(
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
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 15.h),
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
                                    TextButton(
                                      child: Text('نسيت كلمة المرور',style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.primaryColor,
                                      ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context, MaterialPageRoute(
                                          builder: (context) {
                                            return const ResetPassword();
                                          },
                                        ),
                                        );
                                      },
                                    ),

                                    MaterialButton(
                                      onPressed: () {},
                                      height: 50.h,
                                      minWidth: double.infinity,
                                      color: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(25),
                                      ),
                                      child: Text(
                                        'تسجيل الدخول',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Center(
                                      child: Text(
                                        "أو",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            height: 58.h,
                                            width: 103.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: AppColors.grey
                                                      .withOpacity(.2)),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/facebook_icon.png",
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            height: 58.h,
                                            width: 103.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: AppColors.grey
                                                      .withOpacity(.2)),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/google_icon.png",
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            height: 58.h,
                                            width: 103.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: AppColors.grey
                                                      .withOpacity(.2)),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/apple_icon.png",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        const Text("ليس لديك حساب؟"),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,MaterialPageRoute(builder: (context) =>const  RegisterScreen(),)
                                            );
                                          },
                                          child: Text("انشاء حساب",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColors.primaryColor,
                                              )),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )

                          // email tab
                              : SingleChildScrollView(
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 90.h,
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Image.asset(
                                    "assets/images/back_login_button.png",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: MediaQuery.sizeOf(context).height,
                                    opacity: const AlwaysStoppedAnimation(.2),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
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
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                        AppColors.grey.withOpacity(.1),
                                        hintText: 'ادخل بريدك الالكتروني',
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
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
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 15.h),
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
                                        fillColor:
                                        AppColors.grey.withOpacity(.1),
                                        hintText: 'قم بإدخال كلمة المرور',
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Image.asset(
                                            "assets/images/lock.png",
                                            color: AppColors.blackColor
                                                .withOpacity(.8),
                                            width: 20.w,
                                            height: 20.h,
                                          ),
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
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
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 15.h),
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

                                    TextButton(
                                      child: Text('نسيت كلمة المرور',style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.primaryColor,
                                      ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context, MaterialPageRoute(
                                            builder: (context) {
                                              return const ResetPassword();
                                            },
                                          ),
                                        );
                                      },
                                    ),

                                    MaterialButton(
                                      onPressed: () {},
                                      height: 50.h,
                                      minWidth: double.infinity,
                                      color: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(25),
                                      ),
                                      child: Text(
                                        'تسجيل الدخول',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Center(
                                      child: Text(
                                        "أو",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            height: 58.h,
                                            width: 103.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: AppColors.grey
                                                      .withOpacity(.2)),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/facebook_icon.png",
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            height: 58.h,
                                            width: 103.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: AppColors.grey
                                                      .withOpacity(.2)),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/google_icon.png",
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            height: 58.h,
                                            width: 103.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: AppColors.grey
                                                      .withOpacity(.2)),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/apple_icon.png",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        const Text("ليس لديك حساب؟"),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,MaterialPageRoute(builder: (context) =>const  RegisterScreen(),),);
                                          },
                                          child: Text("انشاء حساب",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColors.primaryColor,
                                              )),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
                  ],
                ),
          ),
        )

        // SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       Image.asset(
        //         'assets/images/auth.png',
        //         width: double.infinity,
        //         fit: BoxFit.cover,
        //       ),
        //       SizedBox(
        //         height: 25.h,
        //       ),
        //       CustomText(
        //         'تسجيل الدخول بواسطة',
        //         fontSize: 14.sp,
        //       ),
        //       SizedBox(
        //         height: 18.h,
        //       ),
        //       // Padding(
        //       //   padding:  EdgeInsets.symmetric(horizontal: 36.0.w),
        //       //   child: Column(
        //       //     children: [
        //       //       CustomText(
        //       //         'تسجيل الدخول بواسطة',
        //       //         fontSize: 14.sp,
        //       //       ),
        //       //       SizedBox(
        //       //         height: 18.h,
        //       //       ),
        //       //       Row(
        //       //         children: [
        //       //           Expanded(
        //       //             child: CustomFacebookButton(
        //       //               onTap: () {},
        //       //             ),
        //       //           ),
        //       //           SizedBox(
        //       //             width: 24.w,
        //       //           ),
        //       //           Expanded(
        //       //             child: CustomGoogleButton(
        //       //               onTap: () {},
        //       //             ),
        //       //           )
        //       //         ],
        //       //       ),
        //       //       SizedBox(
        //       //         height: 18.h,
        //       //       ),
        //       //       Row(
        //       //         children: [
        //       //           const Expanded(
        //       //               child: Divider(
        //       //             color: AppColors.greyBorder,
        //       //             thickness: 2,
        //       //           )),
        //       //           Container(
        //       //               margin: EdgeInsets.symmetric(horizontal: 6.w),
        //       //               child: CustomText(
        //       //                 'أو',
        //       //                 fontSize: 11.sp,
        //       //               )),
        //       //           const Expanded(
        //       //               child: Divider(
        //       //             color: AppColors.greyBorder,
        //       //             thickness: 2,
        //       //           )),
        //       //         ],
        //       //       ),
        //       //     ],
        //       //   ),
        //       // ),
        //       Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 36.0.w),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             CustomTextFormFieldWithTopTitle(
        //               controller: emailController,
        //               topTitle: 'اسم المستخدم/البريد الالكتروني',
        //               hintText: 'قم بإدخال اسم المستخدم/البريد الالكتروني',
        //               suffixIcon: const Icon(
        //                 Icons.mail,
        //                 color: Color(0xffAFAFAF),
        //               ),
        //             ),
        //             SizedBox(
        //               height: 17.h,
        //             ),
        //             CustomTextFormFieldWithTopTitle(
        //               controller: passwordController,
        //               topTitle: 'كلمة المرور',
        //               hintText: 'قم بإدخال كلمة المرور',
        //               suffixIcon: const Icon(
        //                 Icons.remove_red_eye_outlined,
        //                 color: Color(0xffAFAFAF),
        //               ),
        //             ),
        //             SizedBox(
        //               height: 17.h,
        //             ),
        //             Row(
        //               children: [
        //                 Checkbox(
        //                   value: _termsChecked,
        //                   activeColor: AppColors.primaryColor,
        //                   onChanged: (bool? value) {
        //                     setState(() {
        //                       _termsChecked = value!;
        //                     });
        //                   },
        //                 ),
        //                 const SizedBox(
        //                   width: 10,
        //                 ),
        //                 RichText(
        //                   text: TextSpan(
        //                     text: 'اوافق على  ',
        //                     style: const TextStyle(color: Colors.black),
        //                     children: <TextSpan>[
        //                       TextSpan(
        //                         text: 'الشروط والاحكام ',
        //                         recognizer: TapGestureRecognizer()
        //                           ..onTap = () {
        //                             showDialog(
        //                               context: context,
        //                               builder: (context) {
        //                                 return dialoge(
        //                                   text: termsAndConditions,
        //                                 );
        //                               },
        //                             );
        //                           },
        //                         style: const TextStyle(
        //                           fontWeight: FontWeight.bold,
        //                           color: AppColors.primaryColor,
        //                         ),
        //                       ),
        //                       const TextSpan(text: '  و  '),
        //                       const TextSpan(text: '\n'),
        //                       TextSpan(
        //                         text: 'سياسة الخصوصية',
        //                         recognizer: TapGestureRecognizer()
        //                           ..onTap = () {
        //                             showDialog(
        //                               context: context,
        //                               builder: (context) {
        //                                 return dialoge(
        //                                   text: privacyPolicies,
        //                                 );
        //                               },
        //                             );
        //                           },
        //                         style: const TextStyle(
        //                           fontWeight: FontWeight.bold,
        //                           color: AppColors.primaryColor,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             SizedBox(
        //               height: 17.h,
        //             ),
        //             TextButton(
        //               onPressed: () {
        //                 Get.to(() => const VerificationCodeScreen());
        //               },
        //               child: CustomText(
        //                 'هل نسيت كلمة المرور؟',
        //                 fontSize: 12.sp,
        //                 fontWeight: FontWeight.normal,
        //               ),
        //             ),
        //             CustomAuthButton(
        //               title: 'تسجيل الدخول',
        //               onTap: () {
        //                 if (_termsChecked) {
        //                   AuthApis.authApis.login(
        //                     emailController.text,
        //                     passwordController.text,
        //                   );
        //                 } else {
        //                   ScaffoldMessenger.of(context).showSnackBar(
        //                     const SnackBar(
        //                       content: Text(
        //                         'الرجاء الموافقة على الشروط والاحكام',
        //                       ),
        //                     ),
        //                   );
        //                 }
        //               },
        //             ),
        //             SizedBox(
        //               height: 5.h,
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 CustomText(
        //                   'او',
        //                   fontSize: 12.sp,
        //                   fontWeight: FontWeight.normal,
        //                 ),
        //               ],
        //             ),
        //             SizedBox(
        //               height: 5.h,
        //             ),
        //             SignInWithAppleButton(
        //               onPressed: () async => await signInWithApple(),
        //               text: "تسجيل الدخول باستخدام Apple",
        //             ),
        //             SizedBox(
        //               height: 10.h,
        //             ),
        //             GestureDetector(
        //               onTap: () {
        //                 Get.to(() => const NavBarScreen());
        //               },
        //               child: Container(
        //                 height: 50.h,
        //                 width: double.infinity,
        //                 decoration: BoxDecoration(
        //                   color: AppColors.whiteColor,
        //                   borderRadius: BorderRadius.circular(8.r),
        //                   border:
        //                       Border.all(color: AppColors.primaryColor, width: 2),
        //                 ),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     CustomText(
        //                       'الدخول كضيف',
        //                       fontSize: 14.sp,
        //                       fontWeight: FontWeight.bold,
        //                       color: AppColors.primaryColor,
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 CustomText(
        //                   'اذا كنت لا تمتلك حساب قم بإنشاء',
        //                   fontSize: 12.sp,
        //                   fontWeight: FontWeight.normal,
        //                 ),
        //                 TextButton(
        //                   onPressed: () {
        //                     Get.to(() => const RegisterScreen());
        //                   },
        //                   child: CustomText(
        //                     ' حساب جديد',
        //                     fontSize: 14.sp,
        //                     fontWeight: FontWeight.normal,
        //                     color: AppColors.primaryColor,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}

class dialoge extends StatelessWidget {
  String text;

  dialoge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: AppColors.primaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                child: const Text(
                  "تم",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
