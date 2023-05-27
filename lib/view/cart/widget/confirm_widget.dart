import 'dart:math';

import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:perfume_store_mobile_app/controller/app_controller.dart';
import 'package:perfume_store_mobile_app/controller/cart_controller.dart';

import '../../../apies/order_apies.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/order_controller.dart';
import '../../../model/countries_response.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/custom_bottom_sheet.dart';
import '../../custom_widget/custom_button.dart';
import '../../custom_widget/custom_dialog.dart';
import '../../custom_widget/custom_text_form_field.dart';
import '../../red_box/screen/red_box_lat_long_screen.dart';

class ConfirmWidget extends StatelessWidget {
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  CartController cartController = Get.find();
  OrderController orderController = Get.find();
  AuthController authController = Get.find();
  AppController appController = Get.find();

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController address1Controller;
  final TextEditingController address2Controller;
  final TextEditingController postcodeController;
  final TextEditingController cityController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController couponController;
  final TextEditingController pointController;
  final TextEditingController pinController;

   ConfirmWidget(
      {super.key,
      required this.firstNameController,
      required this.lastNameController,
      required this.address1Controller,
      required this.address2Controller,
      required this.postcodeController,
      required this.cityController,
      required this.emailController,
      required this.phoneController,
      required this.couponController,
      required this.pointController,
      required this.pinController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      init: AppController(),
      builder: (appController) {
        return GetBuilder<CartController>(
          init: CartController(),
          builder: (cartController) {
            return Obx(
             () {
               var shippingMethod = orderController.getShippingMethodsData!.value.listShippingMethodsResponse;
               var countries = orderController.getCountriesData!.value.listCountriesResponse;
               var payment = orderController.getPaymentMethodsData!.value.listPaymentMethodsResponse;
               var redBox = orderController.getRedBoxData!.value.points;
               var point = orderController.getCustomerPointsData?.value;
               return Column(
                 children: [
                   Container(
                     margin: EdgeInsets.symmetric(horizontal: 20.w),
                     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                     decoration:
                     BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: Border.all(color: AppColors.greyBorder)),
                     child: Column(
                       children: [
                         Container(
                           width: double.infinity,
                           padding: EdgeInsets.all(12.w),
                           decoration: BoxDecoration(color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                           child: CustomText(
                             'delivery_location_value'.tr,
                             fontSize: 16.sp,
                           ),
                         ),
                         SizedBox(
                           height: 17.h,
                         ),
                         CustomTextFormField(
                           controller: firstNameController,
                           hintText: 'first_name_value'.tr,
                         ),
                         SizedBox(
                           height: 10.h,
                         ),
                         CustomTextFormField(
                           controller: lastNameController,
                           hintText: 'last_name_value'.tr,
                         ),
                         SizedBox(
                           height: 10.h,
                         ),
                         CustomTextFormField(
                           controller: emailController,
                           hintText: 'email_value'.tr,
                         ),
                         SizedBox(
                           height: 10.h,
                         ),
                         CustomTextFormField(
                           controller: phoneController,
                           hintText: 'phone_value'.tr,
                           inputType: TextInputType.phone,
                           textDirection: TextDirection.ltr,
                           maxLength: 12,
                           suffixIcon: appController.selectedCountries?.code == 'SA'
                               ? Padding(
                             padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.h),
                             child: CustomText(
                               '966+',
                               fontSize: 12.sp,
                             ),
                           )
                               : SizedBox.shrink(),
                         ),
                         SizedBox(
                           height: 10.h,
                         ),
                         CustomTextFormField(
                           controller: address1Controller,
                           hintText: 'address1_value'.tr,
                         ),
                         SizedBox(
                           height: 10.h,
                         ),
                         CustomTextFormField(
                           controller: address2Controller,
                           hintText: 'address2_value'.tr,
                         ),
                         SizedBox(
                           height: 10.h,
                         ),
                         CustomTextFormField(
                           controller: postcodeController,
                           hintText: 'postal_code_value'.tr,
                           inputType: TextInputType.number,
                         ),
                         SizedBox(
                           height: 10.h,
                         ),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                           child: Row(
                             children: [
                               CustomText(
                                 'select_countries_value'.tr,
                                 fontSize: 12.sp,
                                 fontWeight: FontWeight.bold,
                               ),
                               const Spacer(),
                               countries != null
                                   ? DropdownButton<CountriesResponse>(
                                 focusColor: Colors.white,
                                 value: appController.selectedCountries,
                                 style: const TextStyle(color: Colors.white),
                                 iconEnabledColor: Colors.black,
                                 items: countries.map((value) {
                                   // selectedCountries = orderController.getCountriesData!
                                   //     .value.listCountriesResponse?[48];

                                   return DropdownMenuItem<CountriesResponse>(
                                     value: value,
                                     child: CustomText(
                                       value.name,
                                       fontSize: 9.sp,
                                     ),
                                   );
                                 }).toList(),
                                 hint: CustomText(
                                   "select_countries_value".tr,
                                   fontSize: 10.sp,
                                 ),
                                 onChanged: (CountriesResponse? value) {
                                   appController.updateSelectedCountries(value!);
                                   print(appController.selectedCountries?.name);
                                   print(appController.selectedCountries?.code);
                                 },
                               )
                                   : const SizedBox(),
                             ],
                           ),
                         ),
                         SizedBox(
                           height: 10.h,
                         ),
                         CustomTextFormField(
                           controller: cityController,
                           hintText: 'city_value'.tr,
                         ),
                       ],
                     ),
                   ),
                   SizedBox(
                     height: 30.h,
                   ),
                   Container(
                     margin: EdgeInsets.symmetric(horizontal: 20.w),
                     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                     decoration:
                     BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: Border.all(color: AppColors.greyBorder)),
                     child: Column(
                       children: [
                         Container(
                           width: double.infinity,
                           padding: EdgeInsets.all(12.w),
                           decoration: BoxDecoration(color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                           child: CustomText(
                             'delivery_method_value'.tr,
                             fontSize: 16.sp,
                           ),
                         ),
                         SizedBox(
                           height: 17.h,
                         ),
                         shippingMethod == null
                             ? const SizedBox()
                             : ListView.builder(
                           shrinkWrap: true,
                           physics: const NeverScrollableScrollPhysics(),
                           itemCount: shippingMethod.length,
                           itemBuilder: (context, index) {
                             if (shippingMethod[index].id == 'naqel_shipping' ||
                                 shippingMethod[index].id == 'local_pickup' ||
                                 shippingMethod[index].id == 'redbox_pickup_delivery' ||
                                 shippingMethod[index].id == 'free_shipping' && cartController.total >= 300) {
                               return Column(
                                 children: [
                                   Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: <Widget>[
                                       Radio(
                                         activeColor: Theme.of(context).primaryColor,
                                         value: index,
                                         groupValue: appController.shippingGroupValue,
                                         onChanged: (value) async {
                                           appController.updateShippingGroupValue(index);
                                           appController.updateSelectedAddress(shippingMethod[index].id);
                                           appController.updateSelectedAddressName(shippingMethod[index].title);
                                           print(appController.selectedAddress);
                                           print(appController.selectedAddressName);

                                           if (appController.selectedAddress == 'redbox_pickup_delivery') {
                                             appController.updateMyMarker(null);
                                             Get.to(RedBoxLocationsInMapScreen(
                                               listPoints: redBox!,
                                             ));
                                           }
                                         },
                                       ),
                                       Expanded(
                                         child: Container(
                                           padding: EdgeInsets.all(18.w),
                                           decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(8.0),
                                             border: Border.all(width: 1.0, color: AppColors.greyBorder),
                                           ),
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Row(
                                                 children: [
                                                   Expanded(
                                                     child: Column(
                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: [
                                                         CustomText(
                                                           shippingMethod[index].title!,
                                                           fontSize: 14.sp,
                                                           fontWeight: FontWeight.normal,
                                                         ),
                                                         index == 3
                                                             ? CustomText(
                                                           "${'delivery_cost_value'.tr} 30 ${'sar_value'.tr}",
                                                           fontSize: 12.sp,
                                                         )
                                                             : SizedBox.shrink(),
                                                         index == 4
                                                             ? CustomText(
                                                           "${'delivery_cost_value'.tr} 17 ${'sar_value'.tr}",
                                                           fontSize: 12.sp,
                                                         )
                                                             : SizedBox.shrink(),
                                                         index == 2
                                                             ? CustomText(
                                                           'from_the_market_value'.tr,
                                                           fontSize: 12.sp,
                                                         )
                                                             : SizedBox.shrink(),
                                                       ],
                                                     ),
                                                   ),
                                                   index == 1
                                                       ? Image.asset(
                                                     'assets/images/free.jpeg',
                                                     width: 60.w,
                                                     height: 35.h,
                                                     fit: BoxFit.fill,
                                                   )
                                                       : index == 2
                                                       ? Image.asset(
                                                     'assets/images/fromStore.jpeg',
                                                     width: 60.w,
                                                     height: 35.h,
                                                     fit: BoxFit.fill,
                                                   )
                                                       : index == 3
                                                       ? Image.asset(
                                                     'assets/images/naqel.png',
                                                     width: 60.w,
                                                     height: 35.h,
                                                     fit: BoxFit.fill,
                                                   )
                                                       : index == 4
                                                       ? Image.asset(
                                                     'assets/images/redbox.png',
                                                     width: 60.w,
                                                     height: 35.h,
                                                     fit: BoxFit.fill,
                                                   )
                                                       : SizedBox()
                                                 ],
                                               ),
                                               appController.shippingGroupValue == index &&
                                                   appController.selectedAddress == 'redbox_pickup_delivery' &&
                                                   appController.myMarker != null
                                                   ? Column(
                                                 children: [
                                                   SizedBox(
                                                     height: 5.h,
                                                   ),
                                                   Divider(),
                                                   Row(
                                                     children: [
                                                       Expanded(
                                                         child: CustomText(
                                                           appController.myMarker?.point?.address?.street ?? '',
                                                           fontSize: 13.sp,
                                                         ),
                                                       ),
                                                       SizedBox(
                                                         width: 10.w,
                                                       ),
                                                       GestureDetector(
                                                         onTap: () {
                                                           appController.updateMyMarker(null);
                                                           Get.to(RedBoxLocationsInMapScreen(
                                                             listPoints: redBox!,
                                                           ));
                                                         },
                                                         child: Container(
                                                           padding: EdgeInsets.all(6.w),
                                                           decoration: BoxDecoration(
                                                               color: AppColors.primaryColor,
                                                               borderRadius: BorderRadius.circular(5.r)),
                                                           child: CustomText(
                                                             'edit_location_value'.tr,
                                                             fontSize: 11.sp,
                                                             color: Colors.white,
                                                           ),
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 ],
                                               )
                                                   : SizedBox(),
                                             ],
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 25.h,
                                   ),
                                 ],
                               );
                             } else {
                               return SizedBox();
                             }
                           },
                         )
                       ],
                     ),
                   ),
                   SizedBox(
                     height: 30.h,
                   ),
                   Container(
                     margin: EdgeInsets.symmetric(horizontal: 20.w),
                     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                     decoration:
                     BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: Border.all(color: AppColors.greyBorder)),
                     child: Column(
                       children: [
                         Container(
                           width: double.infinity,
                           padding: EdgeInsets.all(12.w),
                           decoration: BoxDecoration(color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                           child: CustomText(
                             'payment_method_value'.tr,
                             fontSize: 16.sp,
                           ),
                         ),
                         SizedBox(
                           height: 17.h,
                         ),
                         payment == null
                             ? const SizedBox()
                             : GridView.builder(
                           shrinkWrap: true,
                           physics: const NeverScrollableScrollPhysics(),
                           itemCount: payment.length,
                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                             crossAxisCount: 2, // number of columns in the grid
                             crossAxisSpacing: 5.0, // spacing between columns
                             mainAxisSpacing: 10.0, // spacing between rows
                             childAspectRatio: 1.0.h, // width to height ratio of each child
                           ),
                           itemBuilder: (BuildContext context, int index) {
                             String? image = 'pay.png';
                             payment[index].id == 'cod'
                                 ? image = 'payOnDelivery.jpeg'
                                 : payment[index].id == 'tabby_credit_card_installments'
                                 ? image = 'tabby-badge.png'
                                 : payment[index].id == 'tabby_installments'
                                 ? image = 'tabby-badge.png'
                                 : payment[index].id == 'paytabs_mada'
                                 ? image = 'mada.jpeg'
                                 : payment[index].id == 'paytabs_all'
                                 ? image = 'visa.png'
                                 : payment[index].id == 'paytabs_stcpay'
                                 ? image = 'stc.png' //stc
                                 : 'pay.png';

                             // print("id: "+payment[index].id.toString());
                             // print("name: "+payment[index].title.toString());
                             return InkWell(
                               onTap: () {
                                 appController.updateSelectedPaymentMethods(payment[index].id!);
                                 appController.updateSelectedPaymentMethodsTitle(payment[index].title!);
                                 print(appController.selectedPaymentMethods);
                                 print(appController.selectedPaymentMethodsTitle);
                               },
                               child: Stack(
                                 alignment: AlignmentDirectional.topStart,
                                 children: [
                                   Container(
                                     padding: EdgeInsets.all(15.w),
                                     decoration: BoxDecoration(
                                         color: Colors.white,
                                         border: Border.all(
                                             color: appController.selectedPaymentMethods == payment[index].id
                                                 ? Colors.black
                                                 : Colors.transparent)),
                                     child: Column(
                                       children: [
                                         Image.asset(
                                           'assets/images/$image',
                                           width: double.infinity,
                                           height: 40.h,
                                         ),
                                         SizedBox(
                                           height: 10.h,
                                         ),
                                         CustomText(
                                           payment[index].title,
                                           fontSize: 12.sp,
                                           textAlign: TextAlign.center,
                                         ),
                                         payment[index].id == 'cod'
                                             ? Column(
                                           children: [
                                             SizedBox(
                                               height: 10.h,
                                             ),
                                             CustomText(
                                               "${'cod_value'.tr} : 17 ${'sar_value'.tr}",
                                               fontSize: 10.sp,
                                               textAlign: TextAlign.center,
                                             ),
                                           ],
                                         )
                                             : SizedBox()
                                       ],
                                     ),
                                   ),
                                   Visibility(
                                     visible: appController.selectedPaymentMethods == payment[index].id,
                                     child: Container(
                                       height: 25.h,
                                       width: 20.w,
                                       decoration: BoxDecoration(
                                           color: Colors.black,
                                           borderRadius: BorderRadiusDirectional.only(
                                               bottomEnd: Radius.circular(30.r), topEnd: Radius.circular(10.r))),
                                       child: Icon(
                                         Icons.check,
                                         color: Colors.white,
                                         size: 15.w,
                                       ),
                                     ),
                                   )
                                 ],
                               ),
                             );
                           },
                         )
                       ],
                     ),
                   ),
                   SizedBox(
                     height: 32.h,
                   ),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 19.0.w),
                     child: CustomButton(
                       onTap: () {
                         FocusScope.of(context).unfocus();
                         if (appController.selectedCountries != null &&
                             cartController.items.isNotEmpty &&
                             address1Controller.text.isNotEmpty &&
                             address2Controller.text.isNotEmpty &&
                             cityController.text.isNotEmpty &&
                             emailController.text.isNotEmpty &&
                             phoneController.text.replaceAll(' ', '').isNotEmpty &&
                             firstNameController.text.isNotEmpty &&
                             lastNameController.text.isNotEmpty &&
                             postcodeController.text.isNotEmpty &&
                             appController.selectedPaymentMethods != null &&
                             appController.selectedPaymentMethodsTitle != null &&
                             appController.selectedAddress != null &&
                             appController.selectedAddressName != null &&
                             emailRegex.hasMatch(emailController.text.replaceAll(' ', ''))) {
                           if (appController.selectedCountries?.code == 'SA') {
                             print('+966${phoneController.text.replaceAll(' ', '')}');
                             int? currentPin;
                             var random = Random();
                             int min = 1000;
                             int max = 9999;
                             int pin = min + random.nextInt(max - min);
                             currentPin = pin;

                             CustomDialog.customDialog.showConfirmSendMessageDialog(
                                 onTap: () {
                                   print(currentPin);
                                   Get.back();
                                   OrderApies.orderApies
                                       .sendSms(
                                       phone: appController.selectedCountries?.code == 'SA'
                                           ? '+966${phoneController.text.replaceAll(' ', '')}'
                                           : phoneController.text.replaceAll(' ', ''),
                                       pinCode: currentPin.toString())
                                       .then((value) {
                                     print(value.toString());
                                     value.data['code'] == '1'
                                         ? CustomBottomSheet.customBottomSheet.showMessageBottomSheet(
                                         pinController: pinController,
                                         onTapSend: () {
                                           if (currentPin.toString() == pinController.text) {
                                             print('sucess');
                                             Get.back();
                                             SVProgressHUD.showSuccess(status: 'تم التحقق بنجاح');
                                             appController.updateCurrentStepperIndex(2);
                                           } else {
                                             SVProgressHUD.showError(status: 'الرجاء التحقق من الكود المدخل');
                                           }
                                         })
                                         : null;
                                   });
                                 },
                                 phone: appController.selectedCountries?.code == 'SA'
                                     ? '+966${phoneController.text.replaceAll(' ', '')}'
                                     : phoneController.text.replaceAll(' ', ''));
                           } else {
                             appController.updateCurrentStepperIndex(2);
                           }
                         } else {
                           if (!emailRegex.hasMatch(emailController.text.replaceAll(' ', ''))) {
                             ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                 content: Text('email_address_not_valid_value'.tr),
                               ),
                             );
                           } else {
                             ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                 content: Text('please_fill_all_information_value'.tr),
                               ),
                             );
                           }
                         }
                       },
                       height: 40.h,
                       widget: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           CustomText(
                             'pay_value'.tr + '${cartController.total.toStringAsFixed(2)}' + 'sar_value'.tr,
                             fontWeight: FontWeight.normal,
                             color: AppColors.whiteColor,
                             fontSize: 16.sp,
                           ),
                           SizedBox(
                             width: 14.w,
                           ),
                           const Icon(
                             Icons.arrow_forward,
                             color: AppColors.whiteColor,
                           )
                         ],
                       ),
                     ),
                   ),
                   SizedBox(
                     height: 29.h,
                   ),
                 ],
               );
             },
            );
          },
        );
      },
    );
  }
}
