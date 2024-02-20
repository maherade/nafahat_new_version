import 'package:flutter_svg/svg.dart';
import 'package:perfume_store_mobile_app/apies/contact_us_apies.dart';
import 'package:perfume_store_mobile_app/controller/contact_us_controller.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';

import '../../../services/app_imports.dart';
import '../../custom_widget/custom_text_form_field_with_top_title.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  ContactUsController contactUsController = Get.find();

  @override
  void initState() {
    ContactUsApies.contactUsApies.getCommonQuestionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.whiteColor,
        title: CustomText(
          "contact_us".tr,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Image.asset('assets/images/logo.png',
              height:  43.h,
              width: 43.w,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      'الاسم الكامل',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      textInputAction:
                      TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.grey
                            .withOpacity(.1),
                        hintText: 'ادخل اسمك الكامل',
                        prefixIcon: Padding(
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 10.0),
                          child: Image.asset(
                            "assets/images/profile.png",
                            color: AppColors.blackColor
                                .withOpacity(.8),
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'urw_din',
                        ),
                        prefixIconConstraints:
                        BoxConstraints(
                            minWidth: 0,
                            minHeight: 0),
                        prefixStyle:
                        TextStyle(color: Colors.grey),
                        contentPadding:
                        EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 15.h),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.blackColor
                                  .withOpacity(.2)),
                          borderRadius:
                          BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.blackColor
                                  .withOpacity(.2)),
                          borderRadius:
                          BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomText(
                      'رقم الهاتف',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                        AppColors.grey.withOpacity(.1),
                        hintText: 'ادخل رقم هاتفك',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0),
                          child: Image.asset(
                            "assets/images/call.png",
                            color: AppColors.blackColor
                                .withOpacity(.8),
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'urw_din',
                        ),
                        prefixIconConstraints: BoxConstraints(
                            minWidth: 0, minHeight: 0),
                        prefixStyle:
                        TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 15.h),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.blackColor
                                  .withOpacity(.2)),
                          borderRadius:
                          BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.blackColor
                                  .withOpacity(.2)),
                          borderRadius:
                          BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 39.h,
                    ),
                    CustomText(
                      'عنوان الرسالة',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                        AppColors.grey.withOpacity(.1),
                        hintText: 'ادخل عنوان الرسالة هنا',
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'urw_din',
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 0, minHeight: 0,),
                        prefixStyle:
                        const TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 15.h),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.blackColor
                                  .withOpacity(.2)),
                          borderRadius:
                          BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.blackColor
                                  .withOpacity(.2)),
                          borderRadius:
                          BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomText(
                      'نص الرسالة',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    TextFormField(
                      controller: messageController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      maxLength: 4000,
                      maxLines: 12,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                        AppColors.grey.withOpacity(.1),
                        hintText: 'ادخل نص الرسالة هنا',
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'urw_din',
                        ),
                        prefixIconConstraints: const BoxConstraints(
                            minWidth: 0, minHeight: 0),
                        prefixStyle:
                        const TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 15.h),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.blackColor
                                  .withOpacity(.2)),
                          borderRadius:
                          BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.blackColor
                                  .withOpacity(.2)),
                          borderRadius:
                          BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 19.h,
                    ),

                    CustomButton(
                      onTap: () {
                        ContactUsApies.contactUsApies.contactUs(
                          email: phoneController.text,
                          notes: messageController.text,
                        );
                      },
                      height: 50.h,
                      title: 'send_value'.tr,
                      radious: 25.r,
                    ),




                    // CustomText(
                    //   'contact_us_value'.tr,
                    //   fontSize: 16.sp,
                    // ),
                    // SizedBox(
                    //   height: 11.h,
                    // ),

                    // CustomText(
                    //   'if_have_problem_value'.tr,
                    //   fontSize: 14.sp,
                    //   fontWeight: FontWeight.normal,
                    // ),
                    // SizedBox(
                    //   height: 34.h,
                    // ),
                    // CustomTextFormFieldWithTopTitle(
                    //   controller: emailController,
                    //   topTitle: 'emaill_value'.tr,
                    //   hintText: 'enter_your_email_value'.tr,
                    // ),
                    // SizedBox(
                    //   height: 17.h,
                    // ),
                    // CustomTextFormFieldWithTopTitle(
                    //   controller: noteController,
                    //   maxLines: 10,
                    //   topTitle: 'notes_value'.tr,
                    //   hintText: 'enter_your_notes_value'.tr,
                    // ),
                    // SizedBox(
                    //   height: 32.h,
                    // ),
                    // CustomButton(
                    //   onTap: () {
                    //     ContactUsApies.contactUsApies.contactUs(
                    //       email: emailController.text,
                    //       notes: noteController.text,
                    //     );
                    //   },
                    //   height: 40.h,
                    //   title: 'send_value'.tr,
                    // ),
                    // SizedBox(
                    //   height: 43.h,
                    // ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
