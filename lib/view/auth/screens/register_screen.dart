import 'package:flutter/gestures.dart';
import 'package:perfume_store_mobile_app/apies/auth_apies.dart';

import '../../../privacy_policy.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/custom_text_form_field_with_top_title.dart';
import '../../teems_and_conditions.dart';
import '../widget/custom_auth_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  int selectedIndex = 0;

  bool _termsChecked = false;
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
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
                            'انشاء حساب',
                            fontSize: 25.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          CustomText(
                            'قم بإدخال معلوماتك الشخصية',
                            fontSize: 14.sp,
                            color: AppColors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
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
                          SizedBox(
                            height: 20.h,
                          ),

                          //phone number tab
                          selectedIndex == 0
                              ? SingleChildScrollView(
                                  child: Stack(
                                    children: [
                                      // background image
                                      Positioned(
                                        top: 90.h,
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Image.asset(
                                          "assets/images/back_login_button.png",
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height:
                                              MediaQuery.sizeOf(context).height,
                                          opacity:
                                              const AlwaysStoppedAnimation(.2),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //name
                                          CustomText(
                                            'الاسم الكامل',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          TextFormField(
                                            controller: phoneController,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppColors.grey
                                                  .withOpacity(.1),
                                              hintText: 'ادخل اسمك الكامل',
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: Image.asset(
                                                  "assets/images/profile.png",
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
                                                  BoxConstraints(
                                                      minWidth: 0,
                                                      minHeight: 0),
                                              prefixStyle:
                                                  TextStyle(color: Colors.grey),
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
                                          //phone
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
                                                TextInputAction.next,
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
                                                  BoxConstraints(
                                                      minWidth: 0,
                                                      minHeight: 0),
                                              prefixStyle:
                                                  TextStyle(color: Colors.grey),
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
                                          //password
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
                                            height: 27.h,
                                          ),
                                          //sign up button
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
                                              'انشاء حساب',
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
                                          //or
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
                                          //sign in with
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
                                                        BorderRadius.circular(
                                                            50),
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
                                                        BorderRadius.circular(
                                                            50),
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
                                                        BorderRadius.circular(
                                                            50),
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
                                          // already have an account
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text("لديك حساب بالفعل؟"),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginScreen(),
                                                      ),);
                                                },
                                                child: Text("تسجيل الدخول",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: AppColors
                                                          .primaryColor,
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
                                      // background image
                                      Positioned(
                                        top: 90.h,
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Image.asset(
                                          "assets/images/back_login_button.png",
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height:
                                              MediaQuery.sizeOf(context).height,
                                          opacity:
                                              const AlwaysStoppedAnimation(.2),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //name
                                          CustomText(
                                            'الاسم الكامل',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          TextFormField(
                                            controller: phoneController,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                            TextInputAction.next,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppColors.grey
                                                  .withOpacity(.1),
                                              hintText: 'ادخل اسمك الكامل',
                                              prefixIcon: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                child: Image.asset(
                                                  "assets/images/profile.png",
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
                                              BoxConstraints(
                                                  minWidth: 0,
                                                  minHeight: 0),
                                              prefixStyle:
                                              TextStyle(color: Colors.grey),
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

                                          //email
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
                                                TextInputAction.next,
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
                                            height: 22.h,
                                          ),
                                          //password
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
                                                  width: 20.w,
                                                  height: 20.h,
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
                                            height: 27.h,
                                          ),
                                          //sign up button
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
                                              'انشاء حساب',
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
                                          //or
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
                                          //sign in with
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
                                                        BorderRadius.circular(
                                                            50),
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
                                                        BorderRadius.circular(
                                                            50),
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
                                                        BorderRadius.circular(
                                                            50),
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
                                          //already have an account
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text("لديك حساب بالفعل؟"),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
                                                },
                                                child: Text("تسجيل الدخول",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: AppColors
                                                          .primaryColor,
                                                    )),
                                              )
                                            ],
                                          ),
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
