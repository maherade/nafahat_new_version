import 'dart:async';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';

import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

// import 'package:geideapay/api/response/order_api_response.dart';
// import 'package:geideapay/common/geidea.dart';
// import 'package:geideapay/models/address.dart';
// import 'package:geideapay/widgets/checkout/checkout_options.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perfume_store_mobile_app/controller/auth_controller.dart';
import 'package:perfume_store_mobile_app/model/coupon_response.dart';
import 'package:perfume_store_mobile_app/model/order.dart' as order_model;
import 'package:perfume_store_mobile_app/view/cart/widget/confirm_payment_process_widget.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_bottom_sheet.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_dialog.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_text_form_field_with_top_title.dart';
import '../../../apies/order_apies.dart';
import '../../../controller/app_controller.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/order_controller.dart';
import '../../../model/countries_response.dart';
import '../../../model/my_marker.dart';
import '../../../model/payment_method_response.dart';
import '../../../services/app_imports.dart';
import '../../../services/sp_helper.dart';

import '../../../services/src/models/models.dart';
import '../../custom_widget/custom_text_form_field.dart';
import '../widget/cart_widget.dart';
import '../widget/confirm_widget.dart';
import '../widget/custom_cart_product_item.dart';
import '../../red_box/screen/red_box_lat_long_screen.dart';
import '../../bottom_nav_screens/widget/stepper.dart';

import 'package:flutter/scheduler.dart';
import 'package:perfume_store_mobile_app/services/tabby_flutter_inapp_sdk.dart' as tabby;

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController cartController = Get.find();
  OrderController orderController = Get.find();
  AuthController authController = Get.find();
  AppController appController = Get.find();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController pinController = TextEditingController();

//----------------- Giedea Payment----------------
  bool _checkoutInProgress = false;

  // final plugin = GeideapayPlugin();

  String geideaPublicKey = 'e4d809d6-6a55-4627-bcb9-6628fe4f6171'; //nafahat
  String geideaApiPassword = '6686ecfb-2db6-4b73-9ab2-9c9f6c776efc'; //nafahat

  // String geideaPublicKey = 'f7bdf1db-f67e-409b-8fe7-f7ecf9634f70'; // egypt test
  // String geideaApiPassword = '0c9b36c1-3410-4b96-878a-dbd54ace4e9a'; // egypt test

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      OrderApies.orderApies.getShippingMethods();
      OrderApies.orderApies.getCountries().then((value) {
        orderController.getCountriesData?.value.listCountriesResponse?.forEach((element) {
          if (element.code == 'SA') {
            appController.updateSelectedCountries(element);
          }
        });
      });
      OrderApies.orderApies.getPaymentMethods();
      OrderApies.orderApies.getRedBoxPlaces(lat: '24.608318', long: '46.710571', distance: '15000');
      OrderApies.orderApies.getCustomerPoints(customerID: SPHelper.spHelper.getUserId());
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  LatLng? latLng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<AppController>(
      init: AppController(),
      builder: (appController) {
        return GetBuilder<CartController>(
          init: CartController(),
          builder: (cartController) {
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
                        'cart_value'.tr,
                        fontSize: 17.sp,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child:GetBuilder<AppController>(
                    init: AppController(),
                    builder: (appController) {
                      return Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              StepperRealEstates(appController.currentStepperIndex),
                              SizedBox(
                                height: 24.h,
                              ),
                              appController.currentStepperIndex == 0
                                  ? const SizedBox()
                                  : Row(
                                children: [
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  CustomButton(
                                    title: 'previous_value'.tr,
                                    color: Colors.grey,
                                    width: 70.w,
                                    height: 40.h,
                                    onTap: () {
                                      appController.updateCurrentStepperIndex(appController.currentStepperIndex - 1);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 40.h,
                                              decoration: const BoxDecoration(
                                                color: AppColors.primaryColor,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CustomText(
                                                    'product_value'.tr,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.normal,
                                                    color: AppColors.whiteColor,
                                                  ),
                                                  CustomText(
                                                    'price_value'.tr,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.normal,
                                                    color: AppColors.whiteColor,
                                                  ),
                                                  CustomText(
                                                    'quantity_value'.tr,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.normal,
                                                    color: AppColors.whiteColor,
                                                  ),
                                                  CustomText(
                                                    'total_value'.tr,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.normal,
                                                    color: AppColors.whiteColor,
                                                  ),
                                                  CustomText(
                                                    '',
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.normal,
                                                    color: AppColors.whiteColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            cartController.items.isEmpty
                                                ? CustomText(
                                              'you_not_added_item_in_cart_value'.tr,
                                              fontSize: 15.sp,
                                            )
                                                : ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: cartController.items.length,
                                              itemBuilder: (context, index) {
                                                return CustomCartProductItem(
                                                  imgUrl: cartController.items.values.toList()[index].imgurl,
                                                  price: cartController.items.values.toList()[index].price.toString(),
                                                  quantity:
                                                  cartController.items.values.toList()[index].quantity.toString(),
                                                  total: (cartController.items.values.toList()[index].quantity! *
                                                      cartController.items.values.toList()[index].price!)
                                                      .toStringAsFixed(2),
                                                  onTapTrash: () {
                                                    cartController
                                                        .removeItem(cartController.items.values.toList()[index].id!);
                                                  },
                                                  onTapIncrease: () {
                                                    cartController.addItem(
                                                        pdtid:
                                                        cartController.items.values.toList()[index].id.toString());
                                                  },
                                                  onTapDecrease: () {
                                                    cartController.removeSingleItem(
                                                        cartController.items.values.toList()[index].id.toString());
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 32.h,
                                      ),
                                      appController.currentStepperIndex == 0
                                          ? CartWidget()
                                          : appController.currentStepperIndex == 1
                                          ? ConfirmWidget(
                                        phoneController: phoneController,
                                        emailController: emailController,
                                        pinController: pinController,
                                        address1Controller: address1Controller,
                                        address2Controller: address2Controller,
                                        cityController: cityController,
                                        couponController: couponController,
                                        firstNameController: firstNameController,
                                        lastNameController: lastNameController,
                                        pointController: pointController,
                                        postcodeController: postcodeController,
                                      )
                                          : ConfirmPaymentProcessWidget(
                                        phoneController: phoneController,
                                        emailController: emailController,
                                        pinController: pinController,
                                        address1Controller: address1Controller,
                                        address2Controller: address2Controller,
                                        cityController: cityController,
                                        couponController: couponController,
                                        firstNameController: firstNameController,
                                        lastNameController: lastNameController,
                                        pointController: pointController,
                                        postcodeController: postcodeController,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          _checkoutInProgress
                              ? Container(
                            color: Colors.black.withOpacity(0.5),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                              : Container()
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    ));
  }

}
