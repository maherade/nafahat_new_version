import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_text_form_field.dart';

import '../../../services/app_imports.dart';
import '../../controller/app_controller.dart';

class CustomBottomSheet {
  CustomBottomSheet._();

  static CustomBottomSheet customBottomSheet = CustomBottomSheet._();

  showMessageBottomSheet({VoidCallback? onTapSend,required TextEditingController pinController}) {
    Get.bottomSheet(
      isScrollControlled: true,
      Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.only(top: 100.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          color: Colors.white,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return GetBuilder<AppController>(
              init: AppController(),
              builder: (controller) {
                return Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r))),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 50.h,),

                              CustomText('تم إرسال رسالة بكود تحقق إلى رقم هاتفك يرجى إدخال رمز التحقق بالمربع أدناه',fontSize: 14.sp,),
                              SizedBox(height: 20.h,),
                              CustomTextFormField(
                                controller: pinController,
                                hintText: 'كود التحقق',
                              ),
                              SizedBox(height: 20.h,),
                              CustomButton(
                                onTap: onTapSend,
                                title: 'تأكيد',
                                height: 35.h,
                              ),
                              SizedBox(height: 20.h,),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.close)),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    ).then((value) {
      if (value == null) {
        // close
      } else {}
    });
  }



}
