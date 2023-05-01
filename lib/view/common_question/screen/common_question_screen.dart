import 'package:flutter_svg/svg.dart';
import 'package:perfume_store_mobile_app/apies/contact_us_apies.dart';
import 'package:perfume_store_mobile_app/controller/contact_us_controller.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';

import '../../../services/app_imports.dart';
import '../../custom_widget/custom_text_form_field_with_top_title.dart';
import '../widget/question_item.dart';

class CommonQuestionScreen extends StatefulWidget {
  @override
  State<CommonQuestionScreen> createState() => _CommonQuestionScreenState();
}

class _CommonQuestionScreenState extends State<CommonQuestionScreen> {
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
      body: Obx(
        () {
          var commonQuestion =
              contactUsController.getCommonQuestionData?.value.commonQuestions;
          return  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                      child: const BackButton(),
                    ),
                    commonQuestion == null
                        ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ))
                        :  Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 36.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0.w),
                                border: Border.all(
                                    width: 1.0, color: AppColors.greyBorder),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 27.h,
                                  ),
                                  CustomText(
                                    'common_question_value'.tr,
                                    fontSize: 16.sp,
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  CustomText(
                                    'here_some_question_value'.tr,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  SizedBox(
                                    height: 28.h,
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/question.svg',
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    height: 28.h,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: commonQuestion.length,
                                    itemBuilder: (context, index) {
                                      return QuestionItem(
                                        question: commonQuestion[index].title,
                                        answer: commonQuestion[index].content,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}


