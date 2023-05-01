
import 'package:flutter/gestures.dart';
import 'package:perfume_store_mobile_app/apies/auth_apies.dart';

import '../../../privacy_policy.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/custom_text_form_field_with_top_title.dart';
import '../../teems_and_conditions.dart';
import '../widget/custom_auth_button.dart';
import '../widget/custom_social_media_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  bool _termsChecked = false;
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/auth.png',width: double.infinity,fit: BoxFit.cover,),
                Column(
                  children: [
                    SizedBox(height: 30.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                      child: const BackButton(),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 36.0.w),
              child: Column(
                children: [
                  CustomText(
                    'تسجيل حساب جديد  بواسطة',
                    fontSize: 14.sp,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: CustomFacebookButton(
                  //         onTap: () {},
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 24.w,
                  //     ),
                  //     Expanded(
                  //       child: CustomGoogleButton(
                  //         onTap: () {},
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 18.h,
                  // ),
                  // Row(
                  //   children: [
                  //     const Expanded(
                  //         child: Divider(
                  //           color: AppColors.greyBorder,
                  //           thickness: 2,
                  //         )),
                  //     Container(
                  //         margin: EdgeInsets.symmetric(horizontal: 6.w),
                  //         child: CustomText(
                  //           'أو',
                  //           fontSize: 11.sp,
                  //         )),
                  //     const Expanded(
                  //         child: Divider(
                  //           color: AppColors.greyBorder,
                  //           thickness: 2,
                  //         )),
                  //   ],
                  // ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 36.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormFieldWithTopTitle(
                    controller: emailController,
                    topTitle: 'البريد الالكتروني',
                    hintText: 'قم بإدخال بريدك الالكتروني',
                    suffixIcon: const Icon(
                      Icons.mail,
                      color: Color(0xffAFAFAF),
                    ),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  CustomTextFormFieldWithTopTitle(
                    controller: nameController,
                    topTitle: 'الاسم كامل',
                    hintText: 'قم بإدخال الاسم كامل',
                    suffixIcon: const Icon(
                      Icons.person_outline,
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
                  CustomTextFormFieldWithTopTitle(
                    controller: confirmPasswordController,
                    topTitle: 'تأكيد كلمة المرور',
                    hintText: 'قم بإدخال تأكيد كلمة المرور',
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
                  CustomAuthButton(
                    title: 'حساب جديد',
                    onTap: (){
                      if(_termsChecked){
                       if(emailRegex.hasMatch(emailController.text)){
                         if(passwordController.text==confirmPasswordController.text){
                           AuthApis.authApis.register(nameController.text, emailController.text, passwordController.text);
                         }
                         else{
                           ScaffoldMessenger.of(context)
                               .showSnackBar(const SnackBar(content: Text('كلمة السر لا تتوافق مع الشروط')));
                         }
                       }else{
                         ScaffoldMessenger.of(context)
                             .showSnackBar(const SnackBar(content: Text('يرجى إدخال صيغة بريد الكتروني صحيحة')));
                       }
                      }else{
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('الرجاء الموافقة على الشروط والاحكام')));
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText('اذا كنت تمتلك حساب قم ب',fontSize: 12.sp,fontWeight: FontWeight.normal,),
                      TextButton(
                          onPressed: () { Get.to(()=>LoginScreen()); },
                          child: CustomText('تسجيل الدخول',fontSize: 14.sp,fontWeight: FontWeight.normal,color: AppColors.primaryColor,)),
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
