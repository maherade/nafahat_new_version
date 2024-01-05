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
  TextEditingController emailController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  ContactUsController contactUsController = Get.find();

  @override
  void initState() {
    ContactUsApies.contactUsApies.getCommonQuestionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: const BackButton(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                margin: EdgeInsets.symmetric(horizontal: 36.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0.w),
                  border: Border.all(width: 1.0, color: AppColors.greyBorder),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 32.h,
                    ),
                    SvgPicture.asset(
                      'assets/svg/support.svg',
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    CustomText(
                      'contact_us_value'.tr,
                      fontSize: 16.sp,
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    CustomText(
                      'if_have_problem_value'.tr,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    CustomTextFormFieldWithTopTitle(
                      controller: emailController,
                      topTitle: 'emaill_value'.tr,
                      hintText: 'enter_your_email_value'.tr,
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    CustomTextFormFieldWithTopTitle(
                      controller: noteController,
                      maxLines: 10,
                      topTitle: 'notes_value'.tr,
                      hintText: 'enter_your_notes_value'.tr,
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    CustomButton(
                      onTap: () {
                        ContactUsApies.contactUsApies.contactUs(
                          email: emailController.text,
                          notes: noteController.text,
                        );
                      },
                      height: 40.h,
                      title: 'send_value'.tr,
                    ),
                    SizedBox(
                      height: 43.h,
                    ),
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
