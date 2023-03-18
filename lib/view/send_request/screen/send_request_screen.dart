import 'package:perfume_store_mobile_app/apies/product_apies.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';

import '../../../services/app_imports.dart';
import '../../custom_widget/custom_text_form_field_with_top_title.dart';

class SendRequestScreen extends StatelessWidget {
TextEditingController clientNameController = TextEditingController();
TextEditingController organizationNameController = TextEditingController();
TextEditingController organizationAddressController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();

final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:36.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.h,),
                        CustomTextFormFieldWithTopTitle(
                          controller: clientNameController,
                          hintText: 'قم بإدخال اسم العميل',
                          topTitle: 'اسم العميل',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'حقل اسم العميل لا يمكن أن يكون فارغ';
                            }
                            return null;
                          },

                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormFieldWithTopTitle(
                          controller: organizationNameController,
                          hintText: 'قم بإدخال اسم المؤسسة',
                          topTitle: 'اسم المؤسسة',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'حقل اسم المؤسسة لا يمكن أن يكون فارغ';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormFieldWithTopTitle(
                          controller: organizationAddressController,
                          hintText: 'قم بإدخال عنوان المؤسسة',
                          topTitle: 'عنوان المؤسسة',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'حقل عنوان المؤسسة لا يمكن أن يكون فارغ';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormFieldWithTopTitle(
                          controller: emailController,
                          hintText: 'قم بإدخال البريد الالكتروني',
                          topTitle: 'البريد الالكتروني',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'حقل البريد الالكتروني لا يمكن أن يكون فارغ';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormFieldWithTopTitle(
                          controller: phoneController,
                          hintText: 'قم بإدخال رقم الجوال',
                          topTitle: 'رقم الجوال',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'حقل رقم الجوال لا يمكن أن يكون فارغ';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(
                              onTap: (){
                                if(_formKey.currentState!.validate()){
                                  ProductApies.productApies.sendWholeSaleRequest(
                                      clientName: clientNameController.text,
                                      companyAddress: organizationAddressController.text,
                                      companyName: organizationNameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text
                                  );
                                }

                              },
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
