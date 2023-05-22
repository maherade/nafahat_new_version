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
import 'package:flutter/cupertino.dart';
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
import '../widget/custom_cart_product_item.dart';
import '../../red_box/screen/red_box_lat_long_screen.dart';
import '../../bottom_nav_screens/widget/stepper.dart';

import 'package:flutter/scheduler.dart';
import 'package:perfume_store_mobile_app/services/tabby_flutter_inapp_sdk.dart' as tabby;

class CartScreen extends StatefulWidget {
  Function(MyMarker)? onFinish;

  CartScreen({this.onFinish});

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
  CountriesResponse? selectedCountries;

  String? selectedAddress;
  String? selectedAddressName;
  String? selectedPaymentMethods;
  String? selectedPaymentMethodsTitle;

  int currentStepperIndex = 0;

//----------------- Giedea Payment----------------
  bool _checkoutInProgress = false;

  // final plugin = GeideapayPlugin();

  String geideaPublicKey = 'e4d809d6-6a55-4627-bcb9-6628fe4f6171'; //nafahat
  String geideaApiPassword = '6686ecfb-2db6-4b73-9ab2-9c9f6c776efc'; //nafahat

  // String geideaPublicKey = 'f7bdf1db-f67e-409b-8fe7-f7ecf9634f70'; // egypt test
  // String geideaApiPassword = '0c9b36c1-3410-4b96-878a-dbd54ace4e9a'; // egypt test

//----------------- Tabby ----------------
  tabby.WebViewResult? tabbyResultCode;

//-----------------confirm Page ----------------

  int? shippingGroupValue;

  int? paymentGroupValue;

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

  // ----------------------------------------------------------
  @override
  void initState() {
    // plugin.initialize(
    //   publicKey: geideaPublicKey,
    //   apiPassword: geideaApiPassword,
    // );
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getCurrentLang();
      OrderApies.orderApies.getShippingMethods();
      OrderApies.orderApies.getCountries().then((value) {
        orderController.getCountriesData?.value.listCountriesResponse?.forEach((element) {
          if (element.code == 'SA') {
            selectedCountries = element;
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

  String _status = 'idle';
  tabby.TabbySession? session;
  late tabby.Lang lang;

  void _setStatus(String newStatus) {
    setState(() {
      _status = newStatus;
    });
  }

  void getCurrentLang() {
    final myLocale = Localizations.localeOf(context);
    setState(() {
      lang = myLocale.languageCode == 'ar' ? tabby.Lang.ar : tabby.Lang.en;
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

  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<CartController>(
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
              child: Obx(
                () {
                  var shippingMethod = orderController.getShippingMethodsData!.value.listShippingMethodsResponse;
                  var countries = orderController.getCountriesData!.value.listCountriesResponse;
                  var payment = orderController.getPaymentMethodsData!.value.listPaymentMethodsResponse;
                  var redBox = orderController.getRedBoxData!.value.points;
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
                        "${firstNameController.text} ${lastNameController.text} ",
                        emailController.text.replaceAll(' ', ''),
                        selectedCountries?.code == 'SA'
                            ? '+966${phoneController.text.replaceAll(' ', '')}'
                            : phoneController.text.replaceAll(' ', ''),
                        address1Controller.text,
                        selectedCountries?.code,
                        cityController.text,
                        address2Controller.text,
                        postcodeController.text);
                    var shippingDetails = ShippingDetails(
                        "${firstNameController.text} ${lastNameController.text} ",
                        emailController.text.replaceAll(' ', ''),
                        selectedCountries?.code == 'SA'
                            ? '+966${phoneController.text.replaceAll(' ', '')}'
                            : phoneController.text.replaceAll(' ', ''),
                        address1Controller.text,
                        selectedCountries?.code,
                        cityController.text,
                        address2Controller.text,
                        postcodeController.text);
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
                        amount: cartController.totalAfterDiscount,
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

                  // payTaps End
                  return GetBuilder<AppController>(
                    init: AppController(),
                    builder: (appController) {
                      return Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              StepperRealEstates(currentStepperIndex),
                              SizedBox(
                                height: 24.h,
                              ),
                              currentStepperIndex == 0
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
                                            setState(() {
                                              currentStepperIndex -= 1;
                                            });
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
                                                        quantity: cartController.items.values.toList()[index].quantity.toString(),
                                                        total: (cartController.items.values.toList()[index].quantity! *
                                                                cartController.items.values.toList()[index].price!)
                                                            .toStringAsFixed(2),
                                                        onTapTrash: () {
                                                          cartController
                                                              .removeItem(cartController.items.values.toList()[index].id!);
                                                        },
                                                        onTapIncrease: () {
                                                          cartController.addItem(
                                                              pdtid: cartController.items.values.toList()[index].id.toString());
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
                                      currentStepperIndex == 0
                                          ? Container(
                                              margin: EdgeInsets.symmetric(horizontal: 20.w),
                                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8.r),
                                                  border: Border.all(color: AppColors.greyBorder)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.all(12.w),
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        CustomText(
                                                          'total_price_value'.tr,
                                                          fontSize: 16.sp,
                                                        ),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        CustomText(
                                                          'you_have_value'.tr +
                                                              '${cartController.items.length}' +
                                                              'item_in_cart_value'.tr,
                                                          fontSize: 14.sp,
                                                          color: AppColors.hintGrey,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 25.h,
                                                  ),
                                                  CustomButton(
                                                    onTap: () {
                                                      if (cartController.items.isNotEmpty) {
                                                        setState(() => currentStepperIndex = 1);
                                                      } else {
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: Text('please_add_item_in_cart_value'.tr),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    height: 40.h,
                                                    widget: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        CustomText(
                                                          'confirm_value'.tr,
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
                                                  SizedBox(
                                                    height: 16.h,
                                                  ),
                                                  CustomButton(
                                                    onTap: () {
                                                      appController.setIndexScreen(0);
                                                    },
                                                    height: 40.h,
                                                    title: 'continue_buy_process_value'.tr,
                                                    titleColor: AppColors.hintGrey,
                                                    color: AppColors.whiteColor,
                                                    borderColor: AppColors.hintGrey,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : currentStepperIndex == 1
                                              ? Column(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                                                      decoration: BoxDecoration(
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
                                                            suffixIcon: selectedCountries?.code == 'SA'
                                                                ? Padding(
                                                                    padding:
                                                                        EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.h),
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
                                                                        value: selectedCountries,
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
                                                                          setState(() {
                                                                            selectedCountries = value;
                                                                          });
                                                                          print(selectedCountries?.name);
                                                                          print(selectedCountries?.code);
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
                                                      decoration: BoxDecoration(
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
                                                                        shippingMethod[index].id == 'free_shipping' &&
                                                                            cartController.total >= 300) {
                                                                      return Column(
                                                                        children: [
                                                                          Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              Radio(
                                                                                activeColor: Theme.of(context).primaryColor,
                                                                                value: index,
                                                                                groupValue: shippingGroupValue,
                                                                                onChanged: (value) async {
                                                                                  print(index);
                                                                                  setState(() {
                                                                                    shippingGroupValue = index;
                                                                                    selectedAddress = shippingMethod[index].id;
                                                                                    selectedAddressName =
                                                                                        shippingMethod[index].title;

                                                                                    print(selectedAddress);
                                                                                    print(selectedAddressName);
                                                                                  });

                                                                                  if (selectedAddress ==
                                                                                      'redbox_pickup_delivery') {
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
                                                                                    border: Border.all(
                                                                                        width: 1.0, color: AppColors.greyBorder),
                                                                                  ),
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              crossAxisAlignment:
                                                                                                  CrossAxisAlignment.start,
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
                                                                                                        'from_the_market_value'
                                                                                                            .tr,
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
                                                                                      shippingGroupValue == index &&
                                                                                              selectedAddress ==
                                                                                                  'redbox_pickup_delivery' &&
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
                                                                                                        appController
                                                                                                                .myMarker
                                                                                                                ?.point
                                                                                                                ?.address
                                                                                                                ?.street ??
                                                                                                            '',
                                                                                                        fontSize: 13.sp,
                                                                                                      ),
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      width: 10.w,
                                                                                                    ),
                                                                                                    GestureDetector(
                                                                                                      onTap: () {
                                                                                                        appController
                                                                                                            .updateMyMarker(null);
                                                                                                        Get.to(
                                                                                                            RedBoxLocationsInMapScreen(
                                                                                                          listPoints: redBox!,
                                                                                                        ));
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        padding:
                                                                                                            EdgeInsets.all(6.w),
                                                                                                        decoration: BoxDecoration(
                                                                                                            color: AppColors
                                                                                                                .primaryColor,
                                                                                                            borderRadius:
                                                                                                                BorderRadius
                                                                                                                    .circular(
                                                                                                                        5.r)),
                                                                                                        child: CustomText(
                                                                                                          'edit_location_value'
                                                                                                              .tr,
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
                                                      decoration: BoxDecoration(
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
                                                                    childAspectRatio:
                                                                        1.0.h, // width to height ratio of each child
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
                                                                        setState(() {
                                                                          selectedPaymentMethods = payment[index].id;
                                                                          selectedPaymentMethodsTitle = payment[index].title;
                                                                          print(selectedPaymentMethods);
                                                                          print(selectedPaymentMethodsTitle);
                                                                        });
                                                                      },
                                                                      child: Stack(
                                                                        alignment: AlignmentDirectional.topStart,
                                                                        children: [
                                                                          Container(
                                                                            height: 130.h,
                                                                            padding: EdgeInsets.all(15.w),
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                border: Border.all(
                                                                                    color: selectedPaymentMethods ==
                                                                                            payment[index].id
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
                                                                                payment[index].id == 'cod'?Column(
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
                                                                                ):SizedBox()
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Visibility(
                                                                            visible: selectedPaymentMethods == payment[index].id,
                                                                            child: Container(
                                                                              height: 25.h,
                                                                              width: 20.w,
                                                                              decoration: BoxDecoration(
                                                                                  color: Colors.black,
                                                                                  borderRadius: BorderRadiusDirectional.only(
                                                                                      bottomEnd: Radius.circular(30.r),
                                                                                      topEnd: Radius.circular(10.r))),
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
                                                          if (selectedCountries != null &&
                                                              cartController.items.isNotEmpty &&
                                                              address1Controller.text.isNotEmpty &&
                                                              address2Controller.text.isNotEmpty &&
                                                              cityController.text.isNotEmpty &&
                                                              emailController.text.isNotEmpty &&
                                                              phoneController.text.replaceAll(' ', '').isNotEmpty &&
                                                              firstNameController.text.isNotEmpty &&
                                                              lastNameController.text.isNotEmpty &&
                                                              postcodeController.text.isNotEmpty &&
                                                              selectedPaymentMethods != null &&
                                                              selectedPaymentMethodsTitle != null &&
                                                              selectedAddress != null &&
                                                              selectedAddressName != null &&
                                                              emailRegex.hasMatch(emailController.text.replaceAll(' ', ''))) {
                                                            if (selectedCountries?.code == 'SA') {
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
                                                                            phone: selectedCountries?.code == 'SA'
                                                                                ? '+966${phoneController.text.replaceAll(' ', '')}'
                                                                                : phoneController.text.replaceAll(' ', ''),
                                                                            pinCode: currentPin.toString())
                                                                        .then((value) {
                                                                          print(value.toString());
                                                                          value.data['code'] == '1' ?CustomBottomSheet.customBottomSheet
                                                                          .showMessageBottomSheet(
                                                                          pinController: pinController,
                                                                          onTapSend: () {
                                                                            if (currentPin.toString() ==
                                                                                pinController.text) {
                                                                              print('sucess');
                                                                              Get.back();
                                                                              SVProgressHUD.showSuccess(
                                                                                  status: 'تم التحقق بنجاح');
                                                                              setState(() => currentStepperIndex = 2);
                                                                            } else {
                                                                              SVProgressHUD.showError(
                                                                                  status: 'الرجاء التحقق من الكود المدخل');
                                                                            }
                                                                          }):null;
                                                                    });
                                                                  },
                                                                  phone: selectedCountries?.code == 'SA'
                                                                      ? '+966${phoneController.text.replaceAll(' ', '')}'
                                                                      : phoneController.text.replaceAll(' ', ''));
                                                            } else {
                                                              setState(() => currentStepperIndex = 2);
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
                                                              'pay_value'.tr +
                                                                  '${cartController.total.toStringAsFixed(2)}' +
                                                                  'sar_value'.tr,
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
                                                )
                                              : Column(
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
                                                                selectedCountries?.name,
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
                                                                    selectedPaymentMethodsTitle,
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
                                                                      selectedAddressName,
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
                                                                      selectedAddress == 'redbox_pickup_delivery'&&selectedPaymentMethods == 'cod'
                                                                          ? '${17+17}'
                                                                          : selectedAddress == 'naqel_shipping'&&selectedPaymentMethods == 'cod'
                                                                          ? '${30+17}'
                                                                         :selectedPaymentMethods == 'cod'? '17'
                                                                          : selectedAddress == 'redbox_pickup_delivery'
                                                                          ? '17'
                                                                          : selectedAddress == 'naqel_shipping'
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
                                                                      selectedAddress == 'redbox_pickup_delivery'&&selectedPaymentMethods == 'cod'
                                                                          ? (cartController.totalAfterDiscount + 17 + 17).toStringAsFixed(2)
                                                                          : selectedAddress == 'naqel_shipping'&&selectedPaymentMethods == 'cod'
                                                                          ? (cartController.totalAfterDiscount + 30 + 17).toStringAsFixed(2)
                                                                          :selectedPaymentMethods == 'cod'? (cartController.totalAfterDiscount + 17).toStringAsFixed(2)
                                                                          : selectedAddress == 'redbox_pickup_delivery' ? (cartController.totalAfterDiscount + 17).toStringAsFixed(2)
                                                                          : selectedAddress == 'naqel_shipping' ? (cartController.totalAfterDiscount + 30).toStringAsFixed(2)
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
                                                                  controller: couponController,
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
                                                                              .checkCoupon(coupon: couponController.text)
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
                                                                  controller: pointController,
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
                                                                          int points = int.tryParse(pointController.text) ?? 0;
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
                                                          if (selectedPaymentMethods == 'tabby_credit_card_installments') {
                                                            session == null && _status == 'pending'
                                                                ? null
                                                                : await createSession(tabby.Payment(
                                                                    currency: tabby.Currency.sar,
                                                                    amount: cartController.totalAfterDiscount.toString(),
                                                                    buyer: Buyer(
                                                                      email: emailController.text.replaceAll(' ', ''),
                                                                      phone: selectedCountries?.code == 'SA'
                                                                          ? '+966${phoneController.text.replaceAll(' ', '')}'
                                                                          : phoneController.text.replaceAll(' ', ''),
                                                                      name:
                                                                          '${firstNameController.text} ${lastNameController.text}' ??
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
                                                                      city: selectedCountries?.name ?? '',
                                                                      address:
                                                                          'address1: ${address1Controller.text} / address2: ${address2Controller.text}',
                                                                      zip: postcodeController.text,
                                                                    ),
                                                                  ));

                                                            openInAppBrowser(() {
                                                              OrderApies.orderApies
                                                                  .createOrder2(
                                                                customer_id: SPHelper.spHelper.getUserId(),
                                                                payment_method: selectedPaymentMethods!,
                                                                payment_method_title: selectedPaymentMethodsTitle!,
                                                                firstName: firstNameController.text,
                                                                lastName: lastNameController.text,
                                                                addressOne: address1Controller.text,
                                                                addressTwo: address2Controller.text,
                                                                city: cityController.text,
                                                                country: selectedCountries?.code,
                                                                state: "",
                                                                postcode: postcodeController.text,
                                                                email: emailController.text.replaceAll(' ', ''),
                                                                phone: selectedCountries?.code == 'SA'
                                                                    ? '+966${phoneController.text.replaceAll(' ', '')}'
                                                                    : phoneController.text.replaceAll(' ', ''),
                                                                total: cartController.totalAfterDiscount.toString(),
                                                                listProduct: getCartItem(),
                                                                setPaid: true,
                                                                couponCode: couponController.text,
                                                                listShipment: [
                                                                  {
                                                                    "method_id": selectedAddress,
                                                                    "method_title": selectedAddressName,
                                                                    "total": selectedAddress == 'redbox_pickup_delivery'&&selectedPaymentMethods == 'cod'
                                                                        ? '${17+17}'
                                                                        : selectedAddress == 'naqel_shipping'&&selectedPaymentMethods == 'cod'
                                                                        ? '${30+17}'
                                                                        :selectedPaymentMethods == 'cod'? '17'
                                                                        : selectedAddress == 'redbox_pickup_delivery'
                                                                        ? '17'
                                                                        : selectedAddress == 'naqel_shipping'
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
                                                                            '${firstNameController.text} - ${lastNameController.text}',
                                                                        customer_email: emailController.text.replaceAll(' ', ''),
                                                                        customer_phone: selectedCountries?.code == 'SA'
                                                                            ? '+966${phoneController.text.replaceAll(' ', '')}'
                                                                            : phoneController.text.replaceAll(' ', ''),
                                                                        customer_address:
                                                                            '${address1Controller.text} - ${address2Controller.text}',
                                                                        cod_currency: 'SAR',
                                                                        cod_amount: cartController.totalAfterDiscount.toString(),
                                                                        nameOfPackage: 'nameOfPackage')
                                                                    : print('my Marker not Selected');
                                                              });
                                                            });
                                                          } else if (selectedPaymentMethods == 'cod') {
                                                            OrderApies.orderApies
                                                                .createOrder2(
                                                              customer_id: SPHelper.spHelper.getUserId(),
                                                              payment_method: selectedPaymentMethods!,
                                                              payment_method_title: selectedPaymentMethodsTitle!,
                                                              firstName: firstNameController.text,
                                                              lastName: lastNameController.text,
                                                              addressOne: address1Controller.text,
                                                              addressTwo: address2Controller.text,
                                                              city: cityController.text,
                                                              country: selectedCountries?.code,
                                                              state: "",
                                                              postcode: postcodeController.text,
                                                              email: emailController.text.replaceAll(' ', ''),
                                                              phone: selectedCountries?.code == 'SA'
                                                                  ? '+966${phoneController.text.replaceAll(' ', '')}'
                                                                  : phoneController.text.replaceAll(' ', ''),
                                                              total: cartController.totalAfterDiscount.toString(),
                                                              listProduct: getCartItem(),
                                                              setPaid: false,
                                                              couponCode: couponController.text,
                                                              listShipment: [
                                                                {
                                                                  "method_id": selectedAddress,
                                                                  "method_title": selectedAddressName,
                                                                  "total": selectedAddress == 'redbox_pickup_delivery'&&selectedPaymentMethods == 'cod'
                                                                      ? '${17+17}'
                                                                      : selectedAddress == 'naqel_shipping'&&selectedPaymentMethods == 'cod'
                                                                      ? '${30+17}'
                                                                      :selectedPaymentMethods == 'cod'? '17'
                                                                      : selectedAddress == 'redbox_pickup_delivery'
                                                                      ? '17'
                                                                      : selectedAddress == 'naqel_shipping'
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
                                                                          '${firstNameController.text} - ${lastNameController.text}',
                                                                      customer_email: emailController.text.replaceAll(' ', ''),
                                                                      customer_phone: selectedCountries?.code == 'SA'
                                                                          ? '+966${phoneController.text.replaceAll(' ', '')}'
                                                                          : phoneController.text.replaceAll(' ', ''),
                                                                      customer_address:
                                                                          '${address1Controller.text} - ${address2Controller.text}',
                                                                      cod_currency: 'SAR',
                                                                      cod_amount: cartController.totalAfterDiscount.toString(),
                                                                      nameOfPackage: 'nameOfPackage')
                                                                  : print('my Marker not Selected');
                                                            });
                                                          }
                                                          else if (selectedPaymentMethods == 'paytabs_all') {
                                                            payPressed(
                                                                generateConfig: generateConfig(),
                                                                createOrder: () {
                                                                  OrderApies.orderApies
                                                                      .createOrder2(
                                                                    customer_id: SPHelper.spHelper.getUserId(),
                                                                    payment_method: selectedPaymentMethods!,
                                                                    payment_method_title: selectedPaymentMethodsTitle!,
                                                                    firstName: firstNameController.text,
                                                                    lastName: lastNameController.text,
                                                                    addressOne: address1Controller.text,
                                                                    addressTwo: address2Controller.text,
                                                                    city: cityController.text,
                                                                    country: selectedCountries?.code,
                                                                    state: "",
                                                                    postcode: postcodeController.text,
                                                                    email: emailController.text.replaceAll(' ', ''),
                                                                    phone: selectedCountries?.code == 'SA'
                                                                        ? '+966${phoneController.text.replaceAll(' ', '')}'
                                                                        : phoneController.text.replaceAll(' ', ''),
                                                                    total: cartController.totalAfterDiscount.toString(),
                                                                    listProduct: getCartItem(),
                                                                    setPaid: false,
                                                                    couponCode: couponController.text,
                                                                    listShipment: [
                                                                      {
                                                                        "method_id": selectedAddress,
                                                                        "method_title": selectedAddressName,
                                                                        "total": selectedAddress == 'redbox_pickup_delivery'&&selectedPaymentMethods == 'cod'
                                                                            ? '${17+17}'
                                                                            : selectedAddress == 'naqel_shipping'&&selectedPaymentMethods == 'cod'
                                                                            ? '${30+17}'
                                                                            :selectedPaymentMethods == 'cod'? '17'
                                                                            : selectedAddress == 'redbox_pickup_delivery'
                                                                            ? '17'
                                                                            : selectedAddress == 'naqel_shipping'
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
                                                                                '${firstNameController.text} - ${lastNameController.text}',
                                                                            customer_email: emailController.text.replaceAll(' ', ''),
                                                                            customer_phone: selectedCountries?.code == 'SA'
                                                                                ? '+966${phoneController.text.replaceAll(' ', '')}'
                                                                                : phoneController.text.replaceAll(' ', ''),
                                                                            customer_address:
                                                                                '${address1Controller.text} - ${address2Controller.text}',
                                                                            cod_currency: 'SAR',
                                                                            cod_amount:
                                                                                cartController.totalAfterDiscount.toString(),
                                                                            nameOfPackage: 'nameOfPackage')
                                                                        : print('my Marker not Selected');
                                                                  });
                                                                });
                                                          }
                                                          else if (selectedPaymentMethods == 'paytabs_stcpay' ||
                                                              selectedPaymentMethods == 'paytabs_mada' ||
                                                              selectedPaymentMethods == 'paytabs_creditcard' ||
                                                              selectedPaymentMethods == 'paytabs_sadad' ||
                                                              selectedPaymentMethods == 'paytabs_amex' ||
                                                              selectedPaymentMethods == 'paytabs_urpay') {
                                                            apmsPayPressed(
                                                                generateConfig: generateConfig(),
                                                                createOrder: () {
                                                                  OrderApies.orderApies
                                                                      .createOrder2(
                                                                    customer_id: SPHelper.spHelper.getUserId(),
                                                                    payment_method: selectedPaymentMethods!,
                                                                    payment_method_title: selectedPaymentMethodsTitle!,
                                                                    firstName: firstNameController.text,
                                                                    lastName: lastNameController.text,
                                                                    addressOne: address1Controller.text,
                                                                    addressTwo: address2Controller.text,
                                                                    city: cityController.text,
                                                                    country: selectedCountries?.code,
                                                                    state: "",
                                                                    postcode: postcodeController.text,
                                                                    email: emailController.text.replaceAll(' ', ''),
                                                                    phone: selectedCountries?.code == 'SA'
                                                                        ? '+966${phoneController.text.replaceAll(' ', '')}'
                                                                        : phoneController.text.replaceAll(' ', ''),
                                                                    total: cartController.totalAfterDiscount.toString(),
                                                                    listProduct: getCartItem(),
                                                                    setPaid: false,
                                                                    couponCode: couponController.text,
                                                                    listShipment: [
                                                                      {
                                                                        "method_id": selectedAddress,
                                                                        "method_title": selectedAddressName,
                                                                        "total": selectedAddress == 'redbox_pickup_delivery'&&selectedPaymentMethods == 'cod'
                                                                            ? '${17+17}'
                                                                            : selectedAddress == 'naqel_shipping'&&selectedPaymentMethods == 'cod'
                                                                            ? '${30+17}'
                                                                            :selectedPaymentMethods == 'cod'? '17'
                                                                            : selectedAddress == 'redbox_pickup_delivery'
                                                                            ? '17'
                                                                            : selectedAddress == 'naqel_shipping'
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
                                                                                '${firstNameController.text} - ${lastNameController.text}',
                                                                            customer_email: emailController.text.replaceAll(' ', ''),
                                                                            customer_phone: selectedCountries?.code == 'SA'
                                                                                ? '+966${phoneController.text.replaceAll(' ', '')}'
                                                                                : phoneController.text.replaceAll(' ', ''),
                                                                            customer_address:
                                                                                '${address1Controller.text} - ${address2Controller.text}',
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
                  );
                },
              ),
            ),
          ],
        );
      },
    ));
  }

  Widget addRadioButtonPayment(
      {required int btnValue,
      required int groupValue,
      required String title,
      required List<PaymentMethodsResponse> lst,
      required void Function(PaymentMethodsResponse?)? onChange}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: lst[btnValue],
          groupValue: lst[groupValue],
          onChanged: onChange,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(width: 1.0, color: AppColors.greyBorder),
            ),
            child: CustomText(
              title,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        )
      ],
    );
  }

  // ------------------------ Giedea Payment ---------------------------
  // String truncate(String text, {length: 200, omission: '...'}) {
  //   if (length >= text.length) {
  //     return text;
  //   }
  //   return text.replaceRange(length, text.length, omission);
  // }
  //
  // _updateStatus(String? reference, String? message) {
  //   _showMessage('Reference: $reference \n Response: $message', const Duration(seconds: 7));
  // }
  //
  // _showMessage(String message, [Duration duration = const Duration(seconds: 4)]) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(message),
  //     duration: duration,
  //     action: SnackBarAction(label: 'CLOSE', onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar()),
  //   ));
  // }

  // _handleCheckout({required BuildContext context, required checkoutOptions, required Function createOrder}) async {
  //   setState(() => _checkoutInProgress = true);
  //   try {
  //     OrderApiResponse response = await plugin.checkout(context: context, checkoutOptions: checkoutOptions).then((value) {
  //       value.responseCode == '000' && value.order?.status == 'Success' ? createOrder() : print('failed');
  //       return value;
  //     });
  //     print('Response = ${response.responseCode}');
  //     print('Response = ${response.order?.status}');
  //     print('Response = ${response.order?.detailedStatus}');
  //     setState(() => _checkoutInProgress = false);
  //
  //     // _updateStatus(
  //     //     response.detailedResponseMessage, truncate(response.toString()));
  //     // if(response.responseCode == '000'&&response.order?.status == 'Success'&&response.order?.detailedStatus == 'Paid'){
  //     //
  //     // }
  //   } catch (e) {
  //     setState(() => _checkoutInProgress = false);
  //     _showMessage(e.toString());
  //     //rethrow;
  //   }
  // }

  Widget _getPlatformButton(String string, Function() function, bool active) {
    // is still in progress
    Widget widget;
    if (Platform.isIOS) {
      widget = CupertinoButton(
        onPressed: function,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        color: active ? CupertinoColors.activeBlue : CupertinoColors.inactiveGray,
        child: Text(
          string,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      widget = ElevatedButton(
        onPressed: active ? function : null,
        child: Text(
          string.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
        style: ButtonStyle(
            backgroundColor: active ? MaterialStateProperty.all(Colors.lightBlue) : MaterialStateProperty.all(Colors.grey)),
      );
    }
    return widget;
  }
}
