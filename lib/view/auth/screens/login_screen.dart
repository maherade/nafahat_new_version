
import 'package:perfume_store_mobile_app/view/auth/screens/register_screen.dart';
import 'package:perfume_store_mobile_app/view/auth/screens/reset_password_screen.dart';
import 'package:perfume_store_mobile_app/view/auth/screens/verification_code_screen.dart';

import '../../../services/app_imports.dart';
import '../../bottom_nav_screens/screens/nav_bar_screen.dart';
import '../../custom_widget/custom_text_form_field_with_top_title.dart';
import '../widget/custom_auth_button.dart';
import '../widget/custom_social_media_button.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/auth.png',width: double.infinity,fit: BoxFit.cover,),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 36.0.w),
              child: Column(
                children: [
                  CustomText(
                    'تسجيل الدخول بواسطة',
                    fontSize: 14.sp,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomFacebookButton(
                          onTap: () {},
                        ),
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                      Expanded(
                        child: CustomGoogleButton(
                          onTap: () {},
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(
                        color: AppColors.greyBorder,
                        thickness: 2,
                      )),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 6.w),
                          child: CustomText(
                            'أو',
                            fontSize: 11.sp,
                          )),
                      const Expanded(
                          child: Divider(
                        color: AppColors.greyBorder,
                        thickness: 2,
                      )),
                    ],
                  ),
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
                  TextButton(
                      onPressed: () {
                        Get.to(()=>VerificationCodeScreen());
                      },
                      child: CustomText('هل نسيت كلمة المرور؟',fontSize: 12.sp,fontWeight: FontWeight.normal,)
                  ),
                 CustomAuthButton(
                   title: 'تسجيل الدخول',
                   onTap: (){
                     Get.to(()=>NavBarScreen());
                   },
                 ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText('اذا كنت لا تمتلك حساب قم بإنشاء',fontSize: 12.sp,fontWeight: FontWeight.normal,),
                      TextButton(
                      onPressed: () {
                        Get.to(()=>RegisterScreen());
                      },
                      child: CustomText(' حساب جديد',fontSize: 14.sp,fontWeight: FontWeight.normal,color: AppColors.primaryColor,)),
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
