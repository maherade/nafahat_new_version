
import '../../../services/app_imports.dart';
import '../../custom_widget/custom_text_form_field_with_top_title.dart';
import '../widget/custom_auth_button.dart';
import '../widget/custom_social_media_button.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                  CustomAuthButton(
                    title: 'حساب جديد',
                    onTap: (){},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText('اذا كنت تمتلك حساب قم ب',fontSize: 12.sp,fontWeight: FontWeight.normal,),
                      TextButton(
                          onPressed: () {  },
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
