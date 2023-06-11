import 'package:intl/intl.dart' as intl;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_text_form_field.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_text_form_field_with_top_title.dart';

import '../../../services/app_imports.dart';

class SentGiftItem extends StatefulWidget {
  @override
  State<SentGiftItem> createState() => _SentGiftItemState();
}

class _SentGiftItemState extends State<SentGiftItem> {
  String selectedAmount = '25';
  TextEditingController otherValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Image.asset(
                    'assets/images/gift_background.png',
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 20.h,horizontal: 15.w),
                    child: CustomText('SAR_value'.tr+'$selectedAmount',fontSize: 15.sp,),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  CustomText(
                    'balance_value'.tr,
                    fontSize: 14.sp,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          selectedAmount = '25';
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r), border: Border.all(color:selectedAmount == '25'?AppColors.primaryColor :AppColors.greyBorder, width: 2)),
                        child: CustomText(
                          '25'+'sar_value'.tr,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          selectedAmount = '50';
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r), border: Border.all(color:selectedAmount == '50'?AppColors.primaryColor :AppColors.greyBorder, width: 2)),
                        child: CustomText(
                          '50'+'sar_value'.tr,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          selectedAmount = '100';
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r), border: Border.all(color:selectedAmount == '100'?AppColors.primaryColor :AppColors.greyBorder, width: 2)),
                        child: CustomText(
                          '100'+'sar_value'.tr,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          selectedAmount = '150';
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r), border: Border.all(color:selectedAmount == '150'?AppColors.primaryColor :AppColors.greyBorder, width: 2)),
                        child: CustomText(
                          '150'+'sar_value'.tr,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),

              CustomTextFormFieldWithTopTitle(
                controller: otherValueController,
                topTitle: 'enter_another_value'.tr,
                hintText: 'please_enter_another_value'.tr,
                borderColor: AppColors.primaryColor,
                onChange: (value) {
                  setState(() {
                    selectedAmount = value;
                  });
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomText(
                'enter_phone_for_reciever_value'.tr,
                fontSize: 14.sp,
                color: Color(0xff6b6b6b),
              ),
              SizedBox(
                height: 10.h,
              ),

              Directionality(
                textDirection: TextDirection.ltr,
                child: IntlPhoneField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  initialCountryCode: 'SA',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                    print(phone.countryCode);
                    print(phone.countryISOCode);
                  },
                  invalidNumberMessage: 'enter_active_phone_value'.tr,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextFormFieldWithTopTitle(
                topTitle: 'enter_phone_(optional)_value"'.tr,
                hintText: 'another_value_is_the_recipients_email_value'.tr,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                color: AppColors.primaryColor,
                title: 'complete_order_value',
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
