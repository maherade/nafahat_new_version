import 'package:flutter/gestures.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:perfume_store_mobile_app/view/auth/screens/register_screen.dart';
import 'package:perfume_store_mobile_app/view/auth/screens/verification_code_screen.dart';

import '../../../apies/auth_apies.dart';
import '../../../privacy_policy.dart';
import '../../../services/app_imports.dart';
import '../../bottom_nav_screens/screens/nav_bar_screen.dart';
import '../../custom_widget/custom_text_form_field_with_top_title.dart';
import '../../teems_and_conditions.dart';
import '../widget/custom_auth_button.dart';
import '../widget/custom_social_media_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool _termsChecked = false;
  @override
  void initState() {
    // emailController.text = 'basimshawwa';
    // passwordController.text = 'x0iYfv4KfNVt';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/auth.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 25.h,
            ),
            CustomText(
              'تسجيل الدخول بواسطة',
              fontSize: 14.sp,
            ),
            SizedBox(
              height: 18.h,
            ),
            // Padding(
            //   padding:  EdgeInsets.symmetric(horizontal: 36.0.w),
            //   child: Column(
            //     children: [
            //       CustomText(
            //         'تسجيل الدخول بواسطة',
            //         fontSize: 14.sp,
            //       ),
            //       SizedBox(
            //         height: 18.h,
            //       ),
            //       Row(
            //         children: [
            //           Expanded(
            //             child: CustomFacebookButton(
            //               onTap: () {},
            //             ),
            //           ),
            //           SizedBox(
            //             width: 24.w,
            //           ),
            //           Expanded(
            //             child: CustomGoogleButton(
            //               onTap: () {},
            //             ),
            //           )
            //         ],
            //       ),
            //       SizedBox(
            //         height: 18.h,
            //       ),
            //       Row(
            //         children: [
            //           const Expanded(
            //               child: Divider(
            //             color: AppColors.greyBorder,
            //             thickness: 2,
            //           )),
            //           Container(
            //               margin: EdgeInsets.symmetric(horizontal: 6.w),
            //               child: CustomText(
            //                 'أو',
            //                 fontSize: 11.sp,
            //               )),
            //           const Expanded(
            //               child: Divider(
            //             color: AppColors.greyBorder,
            //             thickness: 2,
            //           )),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormFieldWithTopTitle(
                    controller: emailController,
                    topTitle: 'اسم المستخدم/البريد الالكتروني',
                    hintText: 'قم بإدخال اسم المستخدم/البريد الالكتروني',
                    suffixIcon: const Icon(
                      Icons.mail,
                      color: Color(0xffAFAFAF),
                    ),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  CustomTextFormFieldWithTopTitle(
                    controller: passwordController,
                    topTitle: 'كلمة المرور',
                    hintText: 'قم بإدخال كلمة المرور',
                    suffixIcon: const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Color(0xffAFAFAF),
                    ),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _termsChecked,
                        activeColor: AppColors.primaryColor,
                        onChanged: (bool? value) {
                          setState(() {
                            _termsChecked = value!;
                          });
                        },
                      ),
                      SizedBox(width: 10,),
                      RichText(
                        text: TextSpan(
                          text: 'اوافق على  ',
                          style: const TextStyle(color: Colors.black),
                          children:  <TextSpan>[
                            TextSpan(text: 'الشروط والاحكام ',
                                recognizer:  TapGestureRecognizer()..onTap = () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return dialoge(text: termsAndConditions,);
                                    },
                                  );
                                },
                                style: const TextStyle(fontWeight: FontWeight.bold ,color: AppColors.primaryColor)),
                            const TextSpan(text: '  و  '),
                            const TextSpan(text: '\n'),
                            TextSpan(text: 'سياسة الخصوصية',
                                recognizer:  TapGestureRecognizer()..onTap = () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return dialoge(text: privacyPolicies,);
                                    },
                                  );
                                },
                                style: const TextStyle(fontWeight: FontWeight.bold,color: AppColors.primaryColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(() => const VerificationCodeScreen());
                      },
                      child: CustomText(
                        'هل نسيت كلمة المرور؟',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      )),
                  CustomAuthButton(
                    title: 'تسجيل الدخول',
                    onTap: () {
                      if(_termsChecked){
                        AuthApis.authApis.login(emailController.text, passwordController.text);
                      }else{
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('الرجاء الموافقة على الشروط والاحكام')));
                      }

                    },
                  ),
                  SizedBox(height: 10.h,),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>NavBarScreen());
                    },
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.primaryColor,width: 2)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText('الدخول كضيف',fontSize: 14.sp,fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        'اذا كنت لا تمتلك حساب قم بإنشاء',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(() => RegisterScreen());
                          },
                          child: CustomText(
                            ' حساب جديد',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: AppColors.primaryColor,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class dialoge extends StatelessWidget {
  String text ;
  dialoge({required this.text});
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
                child: Text(text,style: TextStyle(color: Colors.black,fontSize: 18),),
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