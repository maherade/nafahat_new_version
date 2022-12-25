

import 'dart:async';

import 'package:perfume_store_mobile_app/controller/app_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../apies/auth_apies.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/custom_button.dart';
import '../../custom_widget/custom_text_form_field_with_top_title.dart';
import '../widget/custom_auth_button.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  TextEditingController emailController = TextEditingController();
  String code = '';

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AppController>(
        init: AppController(),
        builder: (controller) {
          return SingleChildScrollView(
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
                SizedBox(height: 25.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 36.0.w),
                  child: Column(
                    children: [
                      CustomText(
                        'نسيان كلمة المرور',
                        fontSize: 14.sp,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomText(
                        'هل قمت بنسيان كلمة المرور؟ قم بإدخال بريدك الالكتروني حتى تتمكن من  استعادة كلمة المرور',
                        fontSize: 12.sp,
                        color: AppColors.grey,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex:2,
                            child: CustomTextFormFieldWithTopTitle(
                              controller: emailController,
                              topTitle: '',
                              hintText: 'قم بإدخال بريدك الالكتروني',
                              suffixIcon: const Icon(
                                Icons.mail,
                                color: Color(0xffAFAFAF),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          Visibility(
                            visible: controller.visibleButton,
                            child: CustomButton(
                              height: 57.h,
                              width: 70.w,
                              titleSize: 10.sp,
                              title: 'أرسل رمز التحقق',
                              onTap: (){
                                if(emailController.text != '' ){
                                  controller.startTimer();
                                  AuthApis.authApis.resetPassword(email: emailController.text);
                                }
                                else{
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(content: Text('يرجى ادخال البريد الإلكتروني')));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: PinCodeTextField(
                    length: 4,
                    obscureText: true,
                    obscuringCharacter: '*',
                    animationType: AnimationType.fade,
                    blinkWhenObscuring: true,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        activeFillColor: Colors.white,
                        inactiveColor:const Color(0xffE1D3D6),
                        fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 5),
                        borderRadius: BorderRadius.circular(4.w)
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    mainAxisAlignment: MainAxisAlignment.center,
                    onChanged: (value){
                      print(value);
                    },
                    validator: (v) {
                      if (v!.length < 4) {
                        return "كود التحقق يجب أن يتكون من 4 أرقام";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    onCompleted: (v) {
                      setState(() => code = v);
                    },
                    appContext: context,
                  ),
                ),
                SizedBox(height: 22.h,),
                CustomText('${controller.myDuration.inMinutes.remainder(60)}:${controller.myDuration.inSeconds.remainder(60)}',fontWeight: FontWeight.normal,fontSize: 14.sp,),
                SizedBox(height: 25.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 36.0.w),
                  child: CustomAuthButton(
                    title: 'تأكيد',
                    onTap: (){
                      AuthApis.authApis.validateCode(email: emailController.text.trim(),code: code);
                    },
                  ),
                ),
                SizedBox(height: 17.h,),
                Visibility(
                  visible: controller.visibleButton,
                  child: TextButton(
                      onPressed: () {
                        AuthApis.authApis.resetPassword(email: emailController.text);
                        controller.startTimer();
                      },
                      child: CustomText('ارسال الرمز مرة أخرى',fontWeight: FontWeight.normal,fontSize: 14.sp,)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
