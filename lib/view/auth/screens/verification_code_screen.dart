

import 'dart:async';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../services/app_imports.dart';
import '../widget/custom_auth_button.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 5);
  @override
  void initState() {
    startTimer();
    super.initState();
  }
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }
  void resetTimer() {
    setState(() => myDuration =const Duration(minutes: 5));
  }
  void setCountDown() {
   int reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
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
              ],
            ),
          ),
          SizedBox(height: 25.h,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: PinCodeTextField(
              length: 5,
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
                if (v!.length < 3) {
                  return "I'm from validator";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.number,
              onCompleted: (v) {
                debugPrint("Completed");
              },
              appContext: context,
            ),
          ),
          SizedBox(height: 22.h,),
          CustomText('${myDuration.inMinutes.remainder(60)}:${myDuration.inSeconds.remainder(60)}',fontWeight: FontWeight.normal,fontSize: 14.sp,),
          SizedBox(height: 25.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 36.0.w),
            child: CustomAuthButton(
              title: 'تأكيد',
              onTap: (){
                // Get.to(()=>NavBarScreen());
              },
            ),
          ),
          SizedBox(height: 17.h,),
          TextButton(
          onPressed: () {
            resetTimer();
          },
          child: CustomText('ارسال الرمز مرة أخرى',fontWeight: FontWeight.normal,fontSize: 14.sp,))

        ],
      ),
    );
  }
}
