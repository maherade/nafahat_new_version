import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';

import '../../../services/app_imports.dart';
import '../../custom_widget/custom_text_form_field_with_top_title.dart';

class SendRequestScreen extends StatelessWidget {
TextEditingController clientNameController = TextEditingController();
TextEditingController organizationNameController = TextEditingController();
TextEditingController organizationAddressController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50.h,
        ),

        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:36.w),
              child: Column(
                children: [
                  CustomTextFormFieldWithTopTitle(
                    controller: clientNameController,
                    hintText: 'قم بإدخال اسم العميل',
                    topTitle: 'اسم العميل',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFormFieldWithTopTitle(
                    controller: organizationNameController,
                    hintText: 'قم بإدخال اسم المؤسسة',
                    topTitle: 'اسم المؤسسة',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFormFieldWithTopTitle(
                    controller: organizationAddressController,
                    hintText: 'قم بإدخال عنوان المؤسسة',
                    topTitle: 'عنوان المؤسسة',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFormFieldWithTopTitle(
                    controller: emailController,
                    hintText: 'قم بإدخال البريد الالكتروني',
                    topTitle: 'البريد الالكتروني',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFormFieldWithTopTitle(
                    controller: phoneController,
                    hintText: 'قم بإدخال رقم الجوال',
                    topTitle: 'رقم الجوال',
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        onTap: (){},
                        height: 45.h,
                        width: 184.w,
                        radious: 8.r,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomText('ارسال الطلب',fontWeight: FontWeight.normal,color: AppColors.whiteColor,fontSize: 16.sp,),
                            Icon(Icons.arrow_forward,color: AppColors.whiteColor,)
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
