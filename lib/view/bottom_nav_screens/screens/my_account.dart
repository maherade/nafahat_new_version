import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:perfume_store_mobile_app/apies/auth_apies.dart';
import 'package:perfume_store_mobile_app/view/profile/screen/update_profile_screen.dart';

import '../../../controller/auth_controller.dart';
import '../../../services/app_imports.dart';
import '../../../services/locale_controller.dart';
import '../../../services/sp_helper.dart';
import '../../auth/screens/login_screen.dart';
import '../../common_question/screen/common_question_screen.dart';
import '../../custom_widget/custom_dialog.dart';
import '../../favourite/screen/favourite_screen.dart';
import '../../gift_card/screen/gift_card.dart';
import '../../help_and_support/screen/help_and_support_screen.dart';
import '../../my_order/screen/my_order_screen.dart';
import '../../my_point/screen/my_point_screen.dart';
import '../../privacy_policy/screen/privacy_policy_screen.dart';
import '../../terms_and_condition/screen/terms_and_condition_screen.dart';
import '../../who_us/who_us_screen.dart';
import '../../wholesale/whole_sale_screen.dart';

class MyAccount extends StatefulWidget {
  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  AuthController authController = Get.find();
  MyLocaleController myLocaleController = Get.find();

  var selectedLang;
  List<String> listLang = ['العربية', 'English'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () {
          var auth = authController.getCustomerInformationData?.value.data;
          return SPHelper.spHelper.getToken() != null
              ? Column(
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Row(
                        children: [
                          Container(
                              height: 40.h,
                              width: 40.w,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.contain,
                              ),),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                auth?[0].userBillingFullname ?? '',
                                fontSize: 14.sp,
                              ),
                              CustomText(
                                auth?[0].userMainEmail ?? '',
                                color: Color(0xff886c72),
                                fontSize: 14.sp,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomText(
                                'language_value'.tr,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          selectLang(language: listLang),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => UpdateProfileScreen());
                      },
                      leading: Image.asset(
                        'assets/images/profile.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "personal_information_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => FavouriteScreen());
                      },
                      leading: Image.asset(
                        'assets/images/favourite.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "favourite_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => MyPointScreen());
                      },
                      leading: Image.asset(
                        'assets/images/my_point.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "my_points_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => MyOrderScreen());
                      },
                      leading: Image.asset(
                        'assets/images/my_order.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "my_order_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => GiftCard());
                      },
                      leading: Image.asset(
                        'assets/images/gift.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "gift_card_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => WholeSaleScreen());
                      },
                      leading: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: SvgPicture.asset(
                          'assets/svg/wholesale.svg',
                          width: 20.w,
                          height: 20.h,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      title: CustomText(
                        "whole_sale_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => WhoUsScreen());
                      },
                      leading: Image.asset(
                        'assets/images/who_us.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "who_us_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => PrivacyPolicyScreen());
                      },
                      leading: Image.asset(
                        'assets/images/privacy.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "privacy_policy_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => TermsAndCondition());
                      },
                      leading: Image.asset(
                        'assets/images/terms.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "terms_and_condition_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => CommonQuestionScreen());
                      },
                      leading: Image.asset(
                        'assets/images/question.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "common_question_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => HelpAndSupportScreen());
                      },
                      leading: Image.asset(
                        'assets/images/contact_us.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "contact_us_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        SPHelper.spHelper.removeToken();
                        Get.offAll(() => LoginScreen());
                      },
                      leading: Image.asset(
                        'assets/images/logout.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "logout_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        CustomDialog.customDialog.showDeleteAccountDialog();
                      },
                      leading: Image.asset(
                        'assets/images/profile.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        'delete_account_value'.tr,
                        fontSize: 13.sp,
                        color: Colors.red,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Row(
                        children: [
                          Container(
                              height: 40.h,
                              width: 40.w,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.contain,
                              )),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                'guest_value'.tr,
                                fontSize: 14.sp,
                              ),
                              CustomText(
                                'sign_in_to_use_all_feature_value'.tr,
                                color: Color(0xff886c72),
                                fontSize: 12.sp,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomText(
                                'language_value'.tr,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          selectLang(language: listLang),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => FavouriteScreen());
                      },
                      leading: Image.asset(
                        'assets/images/favourite.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "favourite_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => WholeSaleScreen());
                      },
                      leading: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: SvgPicture.asset(
                          'assets/svg/wholesale.svg',
                          width: 20.w,
                          height: 20.h,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      title: CustomText(
                        "whole_sale_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => WhoUsScreen());
                      },
                      leading: Image.asset(
                        'assets/images/who_us.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "who_us_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => PrivacyPolicyScreen());
                      },
                      leading: Image.asset(
                        'assets/images/privacy.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "privacy_policy_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => TermsAndCondition());
                      },
                      leading: Image.asset(
                        'assets/images/terms.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "terms_and_condition_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => CommonQuestionScreen());
                      },
                      leading: Image.asset(
                        'assets/images/question.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "common_question_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => HelpAndSupportScreen());
                      },
                      leading: Image.asset(
                        'assets/images/contact_us.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "contact_us_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      onTap: () {
                        SPHelper.spHelper.removeToken();
                        Get.offAll(() => LoginScreen());
                      },
                      leading: Image.asset(
                        'assets/images/logout.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: CustomText(
                        "login_value".tr,
                        fontSize: 13.sp,
                      ),
                      trailing: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                );
        },
      ),
    );
  }

  Widget selectLang({List<dynamic>? language}) {
    return language == null
        ? CupertinoActivityIndicator()
        : Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 64.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: AppColors.greyBorder, width: 3),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              iconSize: 30,
              underline: const SizedBox(),
              hint: CustomText(
                'select_lang_value'.tr,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
              ),
              items: language.map(
                (value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(value ?? ''),
                          value == 'العربية'
                              ? Image.asset(
                                  'assets/images/sa.png',
                                  width: 30.w,
                                  height: 30.h,
                                )
                              : Image.asset(
                                  'assets/images/us.png',
                                  width: 30.w,
                                  height: 30.h,
                                )
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
              value: selectedLang,
              onChanged: (value) {
                setState(() {
                  selectedLang = value;
                  myLocaleController.changeLang(value == 'العربية' ? 'ar' : 'en');
                });
              },
            ),
          );
  }
}
