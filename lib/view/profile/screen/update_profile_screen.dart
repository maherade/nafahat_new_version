import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfume_store_mobile_app/apies/auth_apies.dart';
import 'package:perfume_store_mobile_app/controller/app_controller.dart';
import 'package:perfume_store_mobile_app/controller/auth_controller.dart';
import 'package:perfume_store_mobile_app/services/sp_helper.dart';

import '../../../services/app_imports.dart';
import '../../../services/locale_controller.dart';
import '../widget/custom_profile_text_form_field.dart';

class UpdateProfileScreen extends StatefulWidget {

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  MyLocaleController myLocaleController = Get.find();
  AuthController authController = Get.find();

  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController addressController = TextEditingController();



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){

      AuthApis.authApis.getCustomerInformation(SPHelper.spHelper.getUserId()).then((value) {
       var auth = authController.getCustomerInformationData?.value.listViewAllInformationAboutCustomerList?[0];
       emailController.text = auth?.userMainEmail??'';
       nameController.text = auth?.userBillingFullname??'';
       addressController.text = auth?.userAddress??'';
       // selectedLang = auth?.userLang == 'ar'?"العربية":"English";
      });


    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          var user = authController.getCustomerInformationData?.value.listViewAllInformationAboutCustomerList;
          return Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back)),
                    CustomText(
                      'personal_information_value'.tr,
                      fontSize: 17.sp,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              user == null ? Center(child: CupertinoActivityIndicator()):  GetBuilder<AppController>(
                init: AppController(),
                builder: (controller) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.pickImage(ImageSource.gallery);
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    width: 70.w,
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle
                                    ),
                                    child: controller.selectedImage == null ? CachedNetworkImageShare(
                                      urlImage: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                      fit: BoxFit.fill,
                                      widthNumber: 50.w,
                                      heigthNumber: 50.h,
                                      borderRadious: 0,
                                    ) : Image.file(controller.selectedImage!, fit: BoxFit.fill),),
                                  Container(
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 15.w,),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            CustomProfileTextFormField(
                              topTitle: 'email_value'.tr,
                              hintText: 'enter_email_value'.tr,
                              suffixIcon: Icon(Icons.email_outlined),
                              controller: emailController,
                            ),
                            SizedBox(height: 15.h,),
                            CustomProfileTextFormField(
                              topTitle: 'name_value'.tr,
                              hintText: 'enter_name_value'.tr,
                              suffixIcon: Icon(Icons.person_2_outlined),
                              controller: nameController,
                            ),
                            SizedBox(height: 15.h,),
                            CustomProfileTextFormField(
                              topTitle: 'password_value'.tr,
                              hintText: 'enter_password_value'.tr,
                              suffixIcon: Icon(Icons.remove_red_eye_outlined),
                              controller: passwordController,
                            ),
                            SizedBox(height: 15.h,),

                            CustomProfileTextFormField(
                              topTitle: 'address_value'.tr,
                              hintText: 'enter_address_value'.tr,
                              suffixIcon: Icon(Icons.not_listed_location_outlined),
                              controller: addressController,
                            ),
                            SizedBox(height: 15.h,),

                            SizedBox(height: 15.h,),
                            GestureDetector(
                              onTap: (){
                                AuthApis.authApis.updateCustomerProfile(
                                    user_id: SPHelper.spHelper.getUserId(),
                                    user_address: addressController.text,
                                    user_email: emailController.text,
                                    user_fullname: nameController.text,
                                    user_password: passwordController.text,
                                    user_lang: 'ar'
                                    // user_lang: selectedLang == 'العربية'? 'ar' : 'en'
                                );
                              },
                              child: Container(alignment: Alignment.center,
                                height: 40.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: CustomText('save_value'.tr,fontSize: 15.sp,color: Colors.white,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }

}
