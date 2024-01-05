// ignore_for_file: must_be_immutable

import 'package:perfume_store_mobile_app/apies/auth_apies.dart';

import '../../../services/app_imports.dart';
import '../../custom_widget/custom_text_form_field_with_top_title.dart';
import '../widget/custom_auth_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String? email;
  final String? code;

  ResetPasswordScreen({super.key, this.email, this.code});

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
                Image.asset(
                  'assets/images/auth.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
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
              padding: EdgeInsets.symmetric(horizontal: 36.0.w),
              child: Column(
                children: [
                  CustomText(
                    'كلمة مرور جديدة',
                    fontSize: 14.sp,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      CustomText(
                        'قم بإنشاء كلمة مرور جديدة',
                        fontSize: 12.sp,
                        color: AppColors.grey,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    title: 'تأكيد',
                    onTap: () {
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        AuthApis.authApis.setPassword(
                          email: email,
                          code: code,
                          password: passwordController.text,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('كلمة السر غير متطابقة'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
