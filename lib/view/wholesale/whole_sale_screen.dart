import 'package:flutter_svg/svg.dart';
import 'package:perfume_store_mobile_app/apies/product_apies.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';

import '../../controller/cart_controller.dart';
import '../../services/app_imports.dart';
import '../cart/screen/cart_screen.dart';
import '../custom_widget/custom_text_form_field_with_top_title.dart';
import '../search/screen/search_screen.dart';
import 'package:badges/badges.dart' as badges;

class WholeSaleScreen extends StatelessWidget {

TextEditingController clientNameController = TextEditingController();
TextEditingController organizationNameController = TextEditingController();
TextEditingController organizationAddressController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();

final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const BackButton(),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=> CartScreen());
                      },
                      child: GetBuilder<CartController>(
                        init: CartController(),
                        builder: (controller) {
                          return badges.Badge(
                            showBadge: controller.items.isNotEmpty ? true :false,
                            position: badges.BadgePosition.topEnd(),
                            badgeStyle: badges.BadgeStyle(
                              shape: badges.BadgeShape.circle,
                              borderRadius: BorderRadius.circular(12.r),
                              badgeColor: AppColors.primaryColor,
                            ),
                            badgeContent: CustomText(
                              controller.items.length.toString(),
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 11.sp,
                              textAlign: TextAlign.center,
                            ),
                            child: SvgPicture.asset(
                              'assets/svg/cart.svg',
                              color: AppColors.greenText,
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 3.w,),
                    IconButton(onPressed: () {
                      Get.to(()=>SearchScreen());
                    }, icon: Icon(Icons.search))
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:36.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.h,),
                        CustomTextFormFieldWithTopTitle(
                          controller: clientNameController,
                          hintText: 'enter_client_name_value'.tr,
                          topTitle: 'client_name_value'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'client_name_cannot_empty_value'.tr;
                            }
                            return null;
                          },

                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormFieldWithTopTitle(
                          controller: organizationNameController,
                          hintText: 'enter_organization_name_value'.tr,
                          topTitle: 'organization_name_value'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'organization_name_cannot_empty_value'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormFieldWithTopTitle(
                          controller: organizationAddressController,
                          hintText: 'enter_organization_address_value'.tr,
                          topTitle: 'organization_address_value'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'organization_address_cannot_empty_value'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormFieldWithTopTitle(
                          controller: emailController,
                          hintText: 'enter_email_address_value'.tr,
                          topTitle: 'email_address_value'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email_address_cannot_empty_value'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormFieldWithTopTitle(
                          controller: phoneController,
                          hintText: 'enter_phone_number_value'.tr,
                          topTitle: 'phone_number_value'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'phone_number_cannot_empty_value'.tr;
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
                                  CustomText('send_request_value'.tr,fontWeight: FontWeight.normal,color: AppColors.whiteColor,fontSize: 16.sp,),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
