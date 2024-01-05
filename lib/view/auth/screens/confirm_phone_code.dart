import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfume_store_mobile_app/view/auth/screens/finish_confirmation.dart';

import '../../../colors.dart';
import '../../custom_widget/custom_text.dart';
import 'confirm_email_code.dart';

class ConfirmPhoneCode extends StatelessWidget {
  const ConfirmPhoneCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body:   Padding(padding:const  EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h,),
              CustomText(
                'التحقق من رقم الهاتف',
                fontSize:  25.sp,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height:  5.h,),
              CustomText(
                'قم بادخال الكود الذي سيصلك على رقم الهاتف\n الذي ادخلته',
                fontSize:  14.sp,
                fontWeight: FontWeight.normal,
                color: AppColors.grey,
              ),
              SizedBox(height:  MediaQuery.sizeOf(context).height*.25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    'لم يتم ارسال الكود؟',
                    fontSize:  14.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.grey,
                  ),
                  TextButton(onPressed: (){}, child: const Text( 'ارسال كود جديد',style: TextStyle(color: AppColors.primaryColor),))
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height*.3,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) =>const FinishConfirmation()
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
        ),
      ),
      ),
    );
  }
}
