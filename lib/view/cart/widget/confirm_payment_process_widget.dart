import 'dart:async';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:flutter/scheduler.dart';
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


import 'package:perfume_store_mobile_app/controller/auth_controller.dart';
import 'package:perfume_store_mobile_app/model/coupon_response.dart';
import 'package:perfume_store_mobile_app/model/order.dart' as order_model;

import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_text_form_field_with_top_title.dart';
import '../../../apies/order_apies.dart';
import '../../../controller/app_controller.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/order_controller.dart';

import '../../../services/app_imports.dart';
import '../../../services/sp_helper.dart';

import '../../../services/src/models/models.dart';
import '../../custom_widget/custom_text_form_field.dart';


import 'package:perfume_store_mobile_app/services/tabby_flutter_inapp_sdk.dart' as tabby;

class ConfirmPaymentProcessWidget extends StatefulWidget {
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

  ConfirmPaymentProcessWidget(
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
  State<ConfirmPaymentProcessWidget> createState() => _ConfirmPaymentProcessWidgetState();
}

class _ConfirmPaymentProcessWidgetState extends State<ConfirmPaymentProcessWidget> {
  CartController cartController = Get.find();
  OrderController orderController = Get.find();
  AuthController authController = Get.find();
  AppController appController = Get.find();


  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getCurrentLang();
    });
    super.initState();
  }
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

                var point = orderController.getCustomerPointsData?.value;

                List<Map<String, dynamic>> getCartItem() {
                  List<Map<String, dynamic>> list = [];
                  cartController.items.forEach((key, value) {
                    list.add({
                      'product_id': value.id,
                      'quantity': value.quantity!.toInt(),
                    });
                  });
                  return list;
                }

                List<Map<String, dynamic>> getRedboxCartItem() {
                  List<Map<String, dynamic>> list = [];
                  cartController.items.forEach((key, value) {
                    list.add({
                      'name': value.name,
                      'quantity': value.quantity!.toInt(),
                      'description': value.name,
                      'unitPrice': value.price?.toInt(),
                      'currency': 'SAR',
                    });
                  });
                  return list;
                }

                List<OrderItem> getTabbyCartItem() {
                  List<OrderItem> list = [];
                  cartController.items.forEach((key, value) {
                    list.add(OrderItem(
                      title: value.name ?? '',
                      description: value.name ?? '',
                      quantity: value.quantity?.toInt() ?? 0,
                      unitPrice: value.price.toString(),
                      referenceId: value.id ?? '',
                      productUrl: '',
                      category: '',
                    ));
                  });
                  return list;
                }

                List<Map<String, dynamic>> getPayTabsCartItem() {
                  List<Map<String, dynamic>> list = [];
                  cartController.items.forEach((key, value) {
                    list.add({
                      'اسم المنتج': value.name,
                      'العدد': value.quantity!.toInt(),
                      'سعر المنتج': value.price?.toInt(),
                      'العملة': 'SAR',
                    });
                  });
                  return list;
                }

                // payTaps Start
                PaymentSdkConfigurationDetails generateConfig() {
                  var billingDetails = BillingDetails(
                      "${widget.firstNameController.text} ${widget.lastNameController.text} ",
                      widget.emailController.text.replaceAll(' ', ''),
                      appController.selectedCountries?.code == 'SA'
                          ? '+966${widget.phoneController.text.replaceAll(' ', '')}'
                          : widget.phoneController.text.replaceAll(' ', ''),
                      widget.address1Controller.text,
                      appController.selectedCountries?.code,
                      widget.cityController.text,
                      widget.address2Controller.text,
                      widget.postcodeController.text);
                  var shippingDetails = ShippingDetails(
                      "${widget.firstNameController.text} ${widget.lastNameController.text} ",
                      widget.emailController.text.replaceAll(' ', ''),
                      appController.selectedCountries?.code == 'SA'
                          ? '+966${widget.phoneController.text.replaceAll(' ', '')}'
                          : widget.phoneController.text.replaceAll(' ', ''),
                      widget.address1Controller.text,
                      appController.selectedCountries?.code,
                      widget.cityController.text,
                      widget.address2Controller.text,
                      widget.postcodeController.text);
                  List<PaymentSdkAPms> apms = [];
                  apms.add(PaymentSdkAPms.STC_PAY);
                  apms.add(PaymentSdkAPms.AMAN);
                  apms.add(PaymentSdkAPms.FAWRY);
                  apms.add(PaymentSdkAPms.KNET_CREDIT);
                  apms.add(PaymentSdkAPms.KNET_DEBIT);
                  apms.add(PaymentSdkAPms.MEEZA_QR);
                  apms.add(PaymentSdkAPms.OMAN_NET);
                  apms.add(PaymentSdkAPms.UNION_PAY);
                  apms.add(PaymentSdkAPms.URPAY);
                  apms.add(PaymentSdkAPms.VALU);
                  var configuration = PaymentSdkConfigurationDetails(
                      profileId: "98726",
                      serverKey: "S9JN2KT6Z2-J6DTGKDT96-D66WKJZ9J6",
                      clientKey: "CRKMQV-6KK96G-D7TKD7-HMRDKT",
                      cartId: Random().nextInt(100).toString(),
                      cartDescription: getPayTabsCartItem().join(),
                      merchantName: "شركة الجمال والصحة للتجارة",
                      screentTitle: "",
                      amount: appController.selectedAddress == 'redbox_pickup_delivery'&&appController.selectedPaymentMethods == 'cod'
                          ? (17+17+cartController.totalAfterDiscount)
                          : appController.selectedAddress == 'naqel_shipping'&&appController.selectedPaymentMethods == 'cod'
                          ? (30+17+cartController.totalAfterDiscount)
                          : appController.selectedPaymentMethods == 'cod'? (17+cartController.totalAfterDiscount)
                          : appController.selectedAddress == 'redbox_pickup_delivery'
                          ? (17+cartController.totalAfterDiscount)
                          : appController.selectedAddress == 'naqel_shipping'
                          ? (30+cartController.totalAfterDiscount)
                          : cartController.totalAfterDiscount,
                      showBillingInfo: true,
                      forceShippingInfo: false,
                      currencyCode: "SAR",
                      //"EGP",//SAR
                      merchantCountryCode: "SA",
                      // "EG",//""
                      billingDetails: billingDetails,
                      shippingDetails: shippingDetails,
                      alternativePaymentMethods: apms,
                      locale: PaymentSdkLocale.AR,
                      hideCardScanner: true,
                      linkBillingNameWithCardHolderName: true);

                  var theme = IOSThemeConfigurations(
                    buttonColor: "#C9415E",
                    titleFontColor: "#C9415E",
                    secondaryFontColor: "#C9415E",
                    secondaryColor: "#C9415E",
                  );

                  theme.logoImage = "assets/images/logo.png";

                  configuration.iOSThemeConfigurations = theme;
                  configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
                  configuration.showShippingInfo = true;

                  return configuration;
                }
                return  Column(
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomText(
                                'product_value'.tr,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.sp,
                              ),
                              SizedBox(
                                width: 22.w,
                              ),
                              CustomText(
                                cartController.items.length.toString(),
                                fontWeight: FontWeight.normal,
                                fontSize: 12.sp,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomText(
                                'final_price_value'.tr,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.sp,
                              ),
                              SizedBox(
                                width: 22.w,
                              ),
                              CustomText(
                                cartController.total.toStringAsFixed(2),
                                fontWeight: FontWeight.normal,
                                fontSize: 12.sp,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 23.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.greyBorder)),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                                color: const Color(0xffF2F1F1),
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  'delivery_location_value'.tr,
                                  fontSize: 16.sp,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 29.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'delivery_location_value'.tr,
                                fontSize: 14.sp,
                                color: const Color(0xff6C6C6C),
                                fontWeight: FontWeight.normal,
                              ),
                              CustomText(
                                appController.selectedCountries?.name,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.greyBorder)),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                                color: const Color(0xffF2F1F1),
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  'payment_method_value'.tr,
                                  fontSize: 16.sp,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 29.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'payment_method_value'.tr,
                                fontSize: 14.sp,
                                color: const Color(0xff6C6C6C),
                                fontWeight: FontWeight.normal,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CustomText(
                                    appController.selectedPaymentMethodsTitle,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.greyBorder)),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                                color: const Color(0xffF2F1F1),
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  'delivery_method_value'.tr,
                                  fontSize: 16.sp,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 29.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'delivery_method_value'.tr,
                                fontSize: 14.sp,
                                color: const Color(0xff6C6C6C),
                                fontWeight: FontWeight.normal,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      appController.selectedAddressName,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.greyBorder)),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                                color: const Color(0xffF2F1F1),
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  'total_price_value'.tr,
                                  fontSize: 16.sp,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                      'you_own_value'.tr,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    CustomText(
                                      cartController.items.length.toString(),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    CustomText(
                                      'product_in_cart_value'.tr,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 29.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'total_orders_value'.tr,
                                fontSize: 14.sp,
                                color: const Color(0xff6C6C6C),
                                fontWeight: FontWeight.normal,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      cartController.total.toString(),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'delivery_cost_value'.tr,
                                fontSize: 14.sp,
                                color: const Color(0xff6C6C6C),
                                fontWeight: FontWeight.normal,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      appController.selectedAddress == 'redbox_pickup_delivery'&&appController.selectedPaymentMethods == 'cod'
                                          ? '${17+17}'
                                          : appController.selectedAddress == 'naqel_shipping'&&appController.selectedPaymentMethods == 'cod'
                                          ? '${30+17}'
                                          :appController.selectedPaymentMethods == 'cod'? '17'
                                          : appController.selectedAddress == 'redbox_pickup_delivery'
                                          ? '17'
                                          : appController.selectedAddress == 'naqel_shipping'
                                          ? "30.00"
                                          : '0',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'total_amount_value'.tr,
                                fontSize: 14.sp,
                                color: const Color(0xff6C6C6C),
                                fontWeight: FontWeight.normal,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      appController.selectedAddress == 'redbox_pickup_delivery'&&appController.selectedPaymentMethods == 'cod'
                                          ? (cartController.totalAfterDiscount + 17 + 17).toStringAsFixed(2)
                                          : appController.selectedAddress == 'naqel_shipping'&&appController.selectedPaymentMethods == 'cod'
                                          ? (cartController.totalAfterDiscount + 30 + 17).toStringAsFixed(2)
                                          :appController.selectedPaymentMethods == 'cod'? (cartController.totalAfterDiscount + 17).toStringAsFixed(2)
                                          : appController.selectedAddress == 'redbox_pickup_delivery' ? (cartController.totalAfterDiscount + 17).toStringAsFixed(2)
                                          : appController.selectedAddress == 'naqel_shipping' ? (cartController.totalAfterDiscount + 30).toStringAsFixed(2)
                                          : (cartController.totalAfterDiscount + 0).toStringAsFixed(2),

                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 3,
                                child: CustomTextFormFieldWithTopTitle(
                                  controller: widget.couponController,
                                  topTitle: 'coupon_value'.tr,
                                  hintText: 'enter_coupon_value'.tr,
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              orderController.getCouponData?.value.status != 'publish'
                                  ? Expanded(
                                child: CustomButton(
                                  onTap: () {
                                    OrderApies.orderApies
                                        .checkCoupon(coupon: widget.couponController.text)
                                        .then((value) {
                                      cartController.subtractFromPrice(double.parse(
                                          orderController.getCouponData!.value.amount!));
                                    });
                                  },
                                  height: 50.h,
                                  title: 'use_value'.tr,
                                ),
                              )
                                  : Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'you_havee_value'.tr,
                                style: TextStyle(color: Colors.black, fontSize: 13.sp),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: point?.points.toString(),
                                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                                  ),
                                  TextSpan(
                                    text: 'point_value'.tr,
                                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                                  ),
                                  TextSpan(
                                    text: 'worth_value'.tr,
                                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                                  ),
                                  TextSpan(
                                    text: point?.worth.toString(),
                                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                                  ),
                                  TextSpan(
                                    text: 'you_can_use_point_value'.tr,
                                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: CustomTextFormField(
                                  controller: widget.pointController,
                                  hintText: 'enter_points_value'.tr,
                                  onChange: (value) {},
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              point?.points == null
                                  ? SizedBox()
                                  : Expanded(
                                child: CustomButton(
                                  onTap: () {
                                    int points = int.tryParse(widget.pointController.text) ?? 0;
                                    double SARper100Points = 10;
                                    int SAR = (points / 100 * SARper100Points).floor();
                                    print(SAR);

                                    if (int.parse(point!.points.toString()) >= points &&
                                        points > 0) {
                                      OrderApies.orderApies
                                          .decreasePoints(point: points.toString())
                                          .then((value) {
                                        cartController.subtractFromPrice(SAR);
                                      });
                                    } else {
                                      SVProgressHUD.showError(
                                          status: 'you_dont_have_enough_point_value'.tr);
                                    }
                                  },
                                  height: 50.h,
                                  title: 'use_value'.tr,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 29.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 19.0.w),
                      child: CustomButton(
                        onTap: () async {
                          if (appController.selectedPaymentMethods == 'tabby_credit_card_installments') {
                            session == null && _status == 'pending'
                                ? null
                                : await createSession(tabby.Payment(
                              currency: tabby.Currency.sar,
                              amount:  appController.selectedAddress == 'redbox_pickup_delivery'&&appController.selectedPaymentMethods == 'cod'
                                  ? (17+17+cartController.totalAfterDiscount).toString()
                                  : appController.selectedAddress == 'naqel_shipping'&&appController.selectedPaymentMethods == 'cod'
                                  ? (30+17+cartController.totalAfterDiscount).toString()
                                  : appController.selectedPaymentMethods == 'cod'? (17+cartController.totalAfterDiscount).toString()
                                  : appController.selectedAddress == 'redbox_pickup_delivery'
                                  ? (17+cartController.totalAfterDiscount).toString()
                                  : appController.selectedAddress == 'naqel_shipping'
                                  ? (30+cartController.totalAfterDiscount).toString()
                                  : cartController.totalAfterDiscount.toString(),
                              buyer: Buyer(
                                email: widget.emailController.text.replaceAll(' ', ''),
                                phone: appController.selectedCountries?.code == 'SA'
                                    ? '+966${widget.phoneController.text.replaceAll(' ', '')}'
                                    : widget.phoneController.text.replaceAll(' ', ''),
                                name:
                                '${widget.firstNameController.text} ${widget.lastNameController.text}' ??
                                    '',
                                dob: '2019-08-24',
                              ),
                              buyerHistory: BuyerHistory(
                                loyaltyLevel: 0,
                                registeredSince: '2019-08-24T14:15:22Z',
                                wishlistCount: 0,
                              ),
                              order: tabby.Order(
                                  referenceId: 'id123', items: getTabbyCartItem()),
                              orderHistory: [],
                              shippingAddress: ShippingAddress(
                                city: appController.selectedCountries?.name ?? '',
                                address:
                                'address1: ${widget.address1Controller.text} / address2: ${widget.address2Controller.text}',
                                zip: widget.postcodeController.text,
                              ),
                            ));

                            openInAppBrowser(() {
                              OrderApies.orderApies
                                  .createOrder2(
                                customer_id: SPHelper.spHelper.getUserId(),
                                payment_method: appController.selectedPaymentMethods!,
                                payment_method_title: appController.selectedPaymentMethodsTitle!,
                                firstName: widget.firstNameController.text,
                                lastName: widget.lastNameController.text,
                                addressOne: widget.address1Controller.text,
                                addressTwo: widget.address2Controller.text,
                                city: widget.cityController.text,
                                country: appController.selectedCountries?.code,
                                state: "",
                                postcode: widget.postcodeController.text,
                                email: widget.emailController.text.replaceAll(' ', ''),
                                phone: appController.selectedCountries?.code == 'SA'
                                    ? '+966${widget.phoneController.text.replaceAll(' ', '')}'
                                    : widget.phoneController.text.replaceAll(' ', ''),
                                total: cartController.totalAfterDiscount.toString(),
                                listProduct: getCartItem(),
                                setPaid: true,
                                couponCode: widget.couponController.text,
                                listShipment: [
                                  {
                                    "method_id": appController.selectedAddress,
                                    "method_title": appController.selectedAddressName,
                                    "total": appController.selectedAddress == 'redbox_pickup_delivery'&&appController.selectedPaymentMethods == 'cod'
                                        ? '${17+17}'
                                        : appController.selectedAddress == 'naqel_shipping'&&appController.selectedPaymentMethods == 'cod'
                                        ? '${30+17}'
                                        :appController.selectedPaymentMethods == 'cod'? '17'
                                        : appController.selectedAddress == 'redbox_pickup_delivery'
                                        ? '17'
                                        : appController.selectedAddress == 'naqel_shipping'
                                        ? "30.00"
                                        : '0',
                                  }
                                ],
                                listMetaData: appController.myMarker != null
                                    ? [
                                  {
                                    'key': '_redbox_point',
                                    'value':
                                    "${appController.myMarker?.point?.pointName} - ${appController.myMarker?.point?.city} - ${appController.myMarker?.point?.address?.street}",
                                  },
                                  {
                                    'key': '_redbox_point_id',
                                    'value': "${appController.myMarker?.point?.id}",
                                  },
                                ]
                                    : [],
                              )
                                  .then((value) {
                                orderController.getCouponData!.value = CouponResponse();
                                appController.myMarker != null
                                    ? OrderApies.orderApies.createRedBoxShippment(
                                    items: getRedboxCartItem(),
                                    reference: value.id.toString(),
                                    point_id: appController.myMarker?.point?.id ?? '',
                                    sender_name: 'مؤسسة الجمال والصحة للتجارة',
                                    sender_email: 'info@dermarollersystemsa.com',
                                    sender_phone: '0114130336',
                                    sender_address: 'Riyadh -  - ',
                                    customer_name:
                                    '${widget.firstNameController.text} - ${widget.lastNameController.text}',
                                    customer_email: widget.emailController.text.replaceAll(' ', ''),
                                    customer_phone: appController.selectedCountries?.code == 'SA'
                                        ? '+966${widget.phoneController.text.replaceAll(' ', '')}'
                                        : widget.phoneController.text.replaceAll(' ', ''),
                                    customer_address:
                                    '${widget.address1Controller.text} - ${widget.address2Controller.text}',
                                    cod_currency: 'SAR',
                                    cod_amount: cartController.totalAfterDiscount.toString(),
                                    nameOfPackage: 'nameOfPackage')
                                    : print('my Marker not Selected');
                              });
                            });
                          } else if (appController.selectedPaymentMethods == 'cod') {
                            OrderApies.orderApies
                                .createOrder2(
                              customer_id: SPHelper.spHelper.getUserId(),
                              payment_method: appController.selectedPaymentMethods!,
                              payment_method_title: appController.selectedPaymentMethodsTitle!,
                              firstName: widget.firstNameController.text,
                              lastName: widget.lastNameController.text,
                              addressOne: widget.address1Controller.text,
                              addressTwo: widget.address2Controller.text,
                              city: widget.cityController.text,
                              country: appController.selectedCountries?.code,
                              state: "",
                              postcode: widget.postcodeController.text,
                              email: widget.emailController.text.replaceAll(' ', ''),
                              phone: appController.selectedCountries?.code == 'SA'
                                  ? '+966${widget.phoneController.text.replaceAll(' ', '')}'
                                  : widget.phoneController.text.replaceAll(' ', ''),
                              total: cartController.totalAfterDiscount.toString(),
                              listProduct: getCartItem(),
                              setPaid: false,
                              couponCode: widget.couponController.text,
                              listShipment: [
                                {
                                  "method_id": appController.selectedAddress,
                                  "method_title": appController.selectedAddressName,
                                  "total": appController.selectedAddress == 'redbox_pickup_delivery'&&appController.selectedPaymentMethods == 'cod'
                                      ? '${17+17}'
                                      : appController.selectedAddress == 'naqel_shipping'&&appController.selectedPaymentMethods == 'cod'
                                      ? '${30+17}'
                                      :appController.selectedPaymentMethods == 'cod'? '17'
                                      : appController.selectedAddress == 'redbox_pickup_delivery'
                                      ? '17'
                                      : appController.selectedAddress == 'naqel_shipping'
                                      ? "30.00"
                                      : '0',
                                }
                              ],
                              listMetaData: appController.myMarker != null
                                  ? [
                                {
                                  'key': '_redbox_point',
                                  'value':
                                  "${appController.myMarker?.point?.pointName} - ${appController.myMarker?.point?.city} - ${appController.myMarker?.point?.address?.street}",
                                },
                                {
                                  'key': '_redbox_point_id',
                                  'value': "${appController.myMarker?.point?.id}",
                                },
                              ]
                                  : [],
                            )
                                .then((value) {
                              orderController.getCouponData!.value = CouponResponse();
                              appController.myMarker != null
                                  ? OrderApies.orderApies.createRedBoxShippment(
                                  items: getRedboxCartItem(),
                                  reference: value.id.toString(),
                                  point_id: appController.myMarker?.point?.id ?? '',
                                  sender_name: 'مؤسسة الجمال والصحة للتجارة',
                                  sender_email: 'info@dermarollersystemsa.com',
                                  sender_phone: '0114130336',
                                  sender_address: 'Riyadh -  - ',
                                  customer_name:
                                  '${widget.firstNameController.text} - ${widget.lastNameController.text}',
                                  customer_email: widget.emailController.text.replaceAll(' ', ''),
                                  customer_phone: appController.selectedCountries?.code == 'SA'
                                      ? '+966${widget.phoneController.text.replaceAll(' ', '')}'
                                      : widget.phoneController.text.replaceAll(' ', ''),
                                  customer_address:
                                  '${widget.address1Controller.text} - ${widget.address2Controller.text}',
                                  cod_currency: 'SAR',
                                  cod_amount: cartController.totalAfterDiscount.toString(),
                                  nameOfPackage: 'nameOfPackage')
                                  : print('my Marker not Selected');
                            });
                          }
                          else if (appController.selectedPaymentMethods == 'paytabs_all') {
                            payPressed(
                                generateConfig: generateConfig(),
                                createOrder: () {
                                  OrderApies.orderApies
                                      .createOrder2(
                                    customer_id: SPHelper.spHelper.getUserId(),
                                    payment_method: appController.selectedPaymentMethods!,
                                    payment_method_title: appController.selectedPaymentMethodsTitle!,
                                    firstName: widget.firstNameController.text,
                                    lastName: widget.lastNameController.text,
                                    addressOne: widget.address1Controller.text,
                                    addressTwo: widget.address2Controller.text,
                                    city: widget.cityController.text,
                                    country: appController.selectedCountries?.code,
                                    state: "",
                                    postcode: widget.postcodeController.text,
                                    email: widget.emailController.text.replaceAll(' ', ''),
                                    phone: appController.selectedCountries?.code == 'SA'
                                        ? '+966${widget.phoneController.text.replaceAll(' ', '')}'
                                        : widget.phoneController.text.replaceAll(' ', ''),
                                    total: cartController.totalAfterDiscount.toString(),
                                    listProduct: getCartItem(),
                                    setPaid: false,
                                    couponCode: widget.couponController.text,
                                    listShipment: [
                                      {
                                        "method_id": appController.selectedAddress,
                                        "method_title": appController.selectedAddressName,
                                        "total": appController.selectedAddress == 'redbox_pickup_delivery'&&appController.selectedPaymentMethods == 'cod'
                                            ? '${17+17}'
                                            : appController.selectedAddress == 'naqel_shipping'&&appController.selectedPaymentMethods == 'cod'
                                            ? '${30+17}'
                                            :appController.selectedPaymentMethods == 'cod'? '17'
                                            : appController.selectedAddress == 'redbox_pickup_delivery'
                                            ? '17'
                                            : appController.selectedAddress == 'naqel_shipping'
                                            ? "30.00"
                                            : '0',
                                      }
                                    ],
                                    listMetaData: appController.myMarker != null
                                        ? [
                                      {
                                        'key': '_redbox_point',
                                        'value':
                                        "${appController.myMarker?.point?.pointName} - ${appController.myMarker?.point?.city} - ${appController.myMarker?.point?.address?.street}",
                                      },
                                      {
                                        'key': '_redbox_point_id',
                                        'value': "${appController.myMarker?.point?.id}",
                                      },
                                    ]
                                        : [],
                                  )
                                      .then((value) {
                                    orderController.getCouponData!.value = CouponResponse();
                                    appController.myMarker != null
                                        ? OrderApies.orderApies.createRedBoxShippment(
                                        items: getRedboxCartItem(),
                                        reference: value.id.toString(),
                                        point_id: appController.myMarker?.point?.id ?? '',
                                        sender_name: 'مؤسسة الجمال والصحة للتجارة',
                                        sender_email: 'info@dermarollersystemsa.com',
                                        sender_phone: '0114130336',
                                        sender_address: 'Riyadh -  - ',
                                        customer_name:
                                        '${widget.firstNameController.text} - ${widget.lastNameController.text}',
                                        customer_email: widget.emailController.text.replaceAll(' ', ''),
                                        customer_phone: appController.selectedCountries?.code == 'SA'
                                            ? '+966${widget.phoneController.text.replaceAll(' ', '')}'
                                            : widget.phoneController.text.replaceAll(' ', ''),
                                        customer_address:
                                        '${widget.address1Controller.text} - ${widget.address2Controller.text}',
                                        cod_currency: 'SAR',
                                        cod_amount:
                                        cartController.totalAfterDiscount.toString(),
                                        nameOfPackage: 'nameOfPackage')
                                        : print('my Marker not Selected');
                                  });
                                });
                          }
                          else if (appController.selectedPaymentMethods == 'paytabs_stcpay' ||
                              appController.selectedPaymentMethods == 'paytabs_mada' ||
                              appController.selectedPaymentMethods == 'paytabs_creditcard' ||
                              appController.selectedPaymentMethods == 'paytabs_sadad' ||
                              appController.selectedPaymentMethods == 'paytabs_amex' ||
                              appController.selectedPaymentMethods == 'paytabs_urpay') {
                            apmsPayPressed(
                                generateConfig: generateConfig(),
                                createOrder: () {
                                  OrderApies.orderApies
                                      .createOrder2(
                                    customer_id: SPHelper.spHelper.getUserId(),
                                    payment_method: appController.selectedPaymentMethods!,
                                    payment_method_title: appController.selectedPaymentMethodsTitle!,
                                    firstName: widget.firstNameController.text,
                                    lastName: widget.lastNameController.text,
                                    addressOne: widget.address1Controller.text,
                                    addressTwo: widget.address2Controller.text,
                                    city: widget.cityController.text,
                                    country: appController.selectedCountries?.code,
                                    state: "",
                                    postcode: widget.postcodeController.text,
                                    email: widget.emailController.text.replaceAll(' ', ''),
                                    phone: appController.selectedCountries?.code == 'SA'
                                        ? '+966${widget.phoneController.text.replaceAll(' ', '')}'
                                        : widget.phoneController.text.replaceAll(' ', ''),
                                    total: cartController.totalAfterDiscount.toString(),
                                    listProduct: getCartItem(),
                                    setPaid: false,
                                    couponCode: widget.couponController.text,
                                    listShipment: [
                                      {
                                        "method_id": appController.selectedAddress,
                                        "method_title": appController.selectedAddressName,
                                        "total": appController.selectedAddress == 'redbox_pickup_delivery'&&appController.selectedPaymentMethods == 'cod'
                                            ? '${17+17}'
                                            : appController.selectedAddress == 'naqel_shipping'&&appController.selectedPaymentMethods == 'cod'
                                            ? '${30+17}'
                                            :appController.selectedPaymentMethods == 'cod'? '17'
                                            : appController.selectedAddress == 'redbox_pickup_delivery'
                                            ? '17'
                                            : appController.selectedAddress == 'naqel_shipping'
                                            ? "30.00"
                                            : '0',
                                      }
                                    ],
                                    listMetaData: appController.myMarker != null
                                        ? [
                                      {
                                        'key': '_redbox_point',
                                        'value':
                                        "${appController.myMarker?.point?.pointName} - ${appController.myMarker?.point?.city} - ${appController.myMarker?.point?.address?.street}",
                                      },
                                      {
                                        'key': '_redbox_point_id',
                                        'value': "${appController.myMarker?.point?.id}",
                                      },
                                    ]
                                        : [],
                                  )
                                      .then((value) {
                                    orderController.getCouponData!.value = CouponResponse();
                                    appController.myMarker != null
                                        ? OrderApies.orderApies.createRedBoxShippment(
                                        items: getRedboxCartItem(),
                                        reference: value.id.toString(),
                                        point_id: appController.myMarker?.point?.id ?? '',
                                        sender_name: 'مؤسسة الجمال والصحة للتجارة',
                                        sender_email: 'info@dermarollersystemsa.com',
                                        sender_phone: '0114130336',
                                        sender_address: 'Riyadh -  - ',
                                        customer_name:
                                        '${widget.firstNameController.text} - ${widget.lastNameController.text}',
                                        customer_email: widget.emailController.text.replaceAll(' ', ''),
                                        customer_phone: appController.selectedCountries?.code == 'SA'
                                            ? '+966${widget.phoneController.text.replaceAll(' ', '')}'
                                            : widget.phoneController.text.replaceAll(' ', ''),
                                        customer_address:
                                        '${widget.address1Controller.text} - ${widget.address2Controller.text}',
                                        cod_currency: 'SAR',
                                        cod_amount:
                                        cartController.totalAfterDiscount.toString(),
                                        nameOfPackage: 'nameOfPackage')
                                        : print('my Marker not Selected');
                                  });
                                });
                          }

                        },
                        height: 40.h,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              'order_value'.tr,
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
                      height: 54.h,
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

//----------------- Tabby ----------------
  // ----------------------------------------------------------
  late tabby.Lang lang;
  void getCurrentLang() {
    final myLocale = Localizations.localeOf(context);
    setState(() {
      lang = myLocale.languageCode == 'ar' ? tabby.Lang.ar : tabby.Lang.en;
    });
  }
  tabby.WebViewResult? tabbyResultCode;
  String _status = 'idle';
  tabby.TabbySession? session;

  void _setStatus(String newStatus) {
    setState(() {
      _status = newStatus;
    });
  }


  Future<void> createSession(orderDetails) async {
    try {
      _setStatus('pending');

      final s = await tabby.TabbySDK().createSession(tabby.TabbyCheckoutPayload(
        merchantCode: 'sa',
        lang: lang,
        payment: orderDetails,
      ));

      print('Session id:  ${s.sessionId}');

      setState(() {
        session = s;
      });
      _setStatus('created');
    } catch (e, s) {
      _setStatus('error');
    }
  }

  void openInAppBrowser(createOrder) {
    tabby.TabbyWebView.showWebView(
      context: context,
      webUrl: session!.availableProducts.installments!.webUrl,
      onResult: (tabby.WebViewResult resultCode) {
        tabbyResultCode = resultCode;
        Navigator.pop(context);
        resultCode.name == 'authorized'
            ? Timer(
          Duration(seconds: 2),
              () {
            createOrder();
          },
        )
            : print('failedPayment');
      },
    );
  }

  //-------------------------------------------PAYTaps----------------------------------------------
  Future<void> payPressed({createOrder, required PaymentSdkConfigurationDetails? generateConfig}) async {
    FlutterPaytabsBridge.startCardPayment(generateConfig!, (event) {
      setState(() {
        print('yehya' + event.toString());
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            createOrder();
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(transactionDetails["paymentResult"]["responseMessage"].toString()),
                duration: Duration(milliseconds: 900),
                backgroundColor: Colors.red));
            print("failed transaction");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
          print(event['message'].toString());
        } else if (event["status"] == "event") {
          // Handle events here.
          print(event['message'].toString());
        }
      });
    });
  }

  Future<void> apmsPayPressed({createOrder, required PaymentSdkConfigurationDetails? generateConfig}) async {
    FlutterPaytabsBridge.startAlternativePaymentMethod(await generateConfig!, (event) {
      setState(() {
        print('yehya' + event.toString());
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            createOrder();
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(transactionDetails["paymentResult"]["responseMessage"].toString()),
                duration: Duration(milliseconds: 900),
                backgroundColor: Colors.red));
            print("failed transaction");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
          print(event['message'].toString());
        } else if (event["status"] == "event") {
          // Handle events here.
          print(event['message'].toString());
        }
      });
    });
  }

  Future<void> applePayPressed({createOrder,}) async {
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "*Profile id*",
        serverKey: "*server key*",
        clientKey: "*client key*",
        cartId: "12433",
        cartDescription: "Flowers",
        merchantName: "Flowers Store",
        amount: 20.0,
        currencyCode: "SAR",
        merchantCountryCode: "ae",
        merchantApplePayIndentifier: "merchant.com.bunldeId",
        simplifyApplePayValidation: true);
    FlutterPaytabsBridge.startApplePayPayment(configuration, (event) {
      setState(() {
        print('yehya' + event.toString());
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            createOrder();
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(transactionDetails["paymentResult"]["responseMessage"].toString()),
                duration: Duration(milliseconds: 900),
                backgroundColor: Colors.red));
            print("failed transaction");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
          print(event['message'].toString());
        } else if (event["status"] == "event") {
          // Handle events here.
          print(event['message'].toString());
        }
      });
    });
  }
}
