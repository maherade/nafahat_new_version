import '../../apies/contact_us_apies.dart';
import '../../controller/contact_us_controller.dart';
import '../../services/app_imports.dart';

class WhoUsScreen extends StatefulWidget {
  const WhoUsScreen({Key? key}) : super(key: key);

  @override
  State<WhoUsScreen> createState() => _WhoUsScreenState();
}

class _WhoUsScreenState extends State<WhoUsScreen> {
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
        children: [
          SizedBox(
            height: 60.h,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              CustomText(
                'who_us_value'.tr,
                fontSize: 15.sp,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Obx(
              () {
                var commonQuestion = contactUsController
                    .getCommonQuestionData?.value.commonQuestions;
                return commonQuestion == null
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            children: [
                              // CustomText(commonQuestion[0].title,fontFamily: 'din',fontSize: 18.sp,),
                              // SizedBox(height: 20.h,),
                              CustomText(
                                commonQuestion[0].content,
                                fontFamily: 'din',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
