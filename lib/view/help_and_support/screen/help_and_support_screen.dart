import 'package:flutter_svg/svg.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';

import '../../../services/app_imports.dart';
import '../../custom_widget/custom_text_form_field_with_top_title.dart';
import '../widget/question_item.dart';

class HelpAndSupportScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController noteController = TextEditingController();
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
              physics:const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 36.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0.w),
                      border: Border.all(width: 1.0, color: AppColors.greyBorder),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 27.h,
                        ),
                        CustomText(
                          'الأسئلة الشائعة',
                          fontSize: 16.sp,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        CustomText(
                          'هنا بعض الأسئلة التي قام المستخدمون بالاستفسار عنها',
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
                          physics:const NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                          return const QuestionItem(
                            question: 'ما هو موقع نفحات؟',
                            answer:'متجرنا  اكبر موقع تجميل مكياج، عطور منتجات  العناية،الكترونيات، اكسسوارات  الجوال والمزيد  في المملكة |منتجاتنا اصلية 100% | التوصيل  لكافة مناطق  لمملكة خلال 5 ايام عمل والرياض  72 ساعة | خدمة',
                          );
                        },),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    margin: EdgeInsets.symmetric(horizontal: 36.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0.w),
                      border: Border.all(width: 1.0, color: AppColors.greyBorder),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 32.h,),
                        SvgPicture.asset(
                          'assets/svg/support.svg',
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 35.h,
                        ),
                        CustomText(
                          'اتصل بنا',
                          fontSize: 16.sp,
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        CustomText(
                          'اذا واجهتك أي مشكلة , قم بالاتصال بنا',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        SizedBox(
                          height: 34.h,
                        ),
                        CustomTextFormFieldWithTopTitle(
                          controller: emailController,
                          topTitle: 'الايميل',
                          hintText: 'قم بإدخال الايميل الخاص بك',
                        ),
                        SizedBox(
                          height: 17.h,
                        ),
                        CustomTextFormFieldWithTopTitle(
                          controller: noteController,
                          maxLines: 10,
                          topTitle: 'الملاحظات',
                          hintText: 'قم بإدخال ملاحظاتك , لنقوم بحلها',
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        CustomButton(
                          onTap: (){},
                          height: 40.h,
                          title: 'ارسال',
                        ),
                        SizedBox(
                          height: 43.h,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
