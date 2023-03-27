import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geideapay/api/response/order_api_response.dart';
import 'package:geideapay/common/geidea.dart';
import 'package:geideapay/models/address.dart';
import 'package:geideapay/widgets/checkout/checkout_options.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perfume_store_mobile_app/controller/auth_controller.dart';
import 'package:perfume_store_mobile_app/model/order.dart' as order_model;
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';
import 'package:perfume_store_mobile_app/view/payment/payment_screen.dart';
import '../../../apies/order_apies.dart';
import '../../../controller/app_controller.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/order_controller.dart';
import '../../../model/countries_response.dart';
import '../../../model/my_marker.dart';
import '../../../model/payment_method_response.dart';
import '../../../services/app_imports.dart';
import '../../../services/helper.dart';
import '../../../services/sp_helper.dart';

import '../../../services/src/models/models.dart';
import '../../auth/screens/login_screen.dart';
import '../../custom_widget/custom_text_form_field.dart';
import '../widget/custom_cart_product_item.dart';
import '../../red_box/screen/red_box_lat_long_screen.dart';
import '../widget/stepper.dart';

import 'package:flutter/scheduler.dart';
import 'package:perfume_store_mobile_app/services/tabby_flutter_inapp_sdk.dart' as tabby;

class CartScreen extends StatefulWidget {
  Function(MyMarker)? onFinish;

  CartScreen({this.onFinish});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController cart = Get.find();
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
  CountriesResponse? selectedCountries;
  String? selectedCountriesName;
  String? selectedCountriesCod;
  CountriesResponse? selectedCountriesState;
  String? selectedAddress;
  String? selectedAddressName;
  String? selectedPaymentMethods;
  String? selectedPaymentMethodsTitle;

  int currentStepperIndex = 0;

//----------------- Giedea Payment----------------
  bool _checkoutInProgress = false;
  final plugin = GeideapayPlugin();

  String geideaPublicKey = 'e4d809d6-6a55-4627-bcb9-6628fe4f6171';//nafahat
  String geideaApiPassword = '6686ecfb-2db6-4b73-9ab2-9c9f6c776efc';//nafahat

  // String geideaPublicKey = 'f7bdf1db-f67e-409b-8fe7-f7ecf9634f70'; // egypt test
  // String geideaApiPassword = '0c9b36c1-3410-4b96-878a-dbd54ace4e9a'; // egypt test

//----------------- Tabby ----------------
  tabby.WebViewResult? tabbyResultCode;

//-----------------confirm Page ----------------

  int? shippingGroupValue;

  int? paymentGroupValue;

  MyMarker? myMarker;

  @override
  void initState() {
    plugin.initialize(
      publicKey: geideaPublicKey,
      apiPassword: geideaApiPassword,
    );

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SchedulerBinding.instance.addPostFrameCallback((_) => getCurrentLang());

    OrderApies.orderApies.getShippingMethods();
    OrderApies.orderApies.getCountries();
    OrderApies.orderApies.getPaymentMethods();
    OrderApies.orderApies.getRedBoxPlaces(lat: '24.608318', long: '46.710571', distance: '5000');
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
    return Obx(
      () {
        var shippingMethod = orderController.getShippingMethodsData!.value.listShippingMethodsResponse;
        var countries = orderController.getCountriesData!.value.listCountriesResponse;
        var payment = orderController.getPaymentMethodsData!.value.listPaymentMethodsResponse;
        var auth = authController.getCustomerInformationData!.value.data;
        var redBox = orderController.getRedBoxData!.value.points;

        double totalPrice() {
          double total = 0;
          cart.items.forEach((key, value) {
            total += (value.price! * value.quantity!);
          });
          return total;
        }

        List<Map<String, dynamic>> getCartItem() {
          List<Map<String, dynamic>> list = [];
          cart.items.forEach((key, value) {
            list.add({
              'product_id': value.id,
              'quantity': value.quantity!.toInt(),
            });
          });
          return list;
        }

        List<OrderItem> getTabbyCartItem() {
          List<OrderItem> list = [];
          cart.items.forEach((key, value) {
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

        return GetBuilder<AppController>(
          init: AppController(),
          builder: (appController) {
            return Column(
              children: [
                SizedBox(
                  height: 50.h,
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
                            title: 'السابق',
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
                                      'المنتجات',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.whiteColor,
                                    ),
                                    CustomText(
                                      'السعر',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.whiteColor,
                                    ),
                                    CustomText(
                                      'الكمية',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.whiteColor,
                                    ),
                                    CustomText(
                                      'المجموع',
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
                              GetBuilder<CartController>(
                                init: CartController(),
                                builder: (controller) {
                                  return controller.items.isEmpty
                                      ? CustomText(
                                          'لم تقم بإضافة عناصر إلى السلة',
                                          fontSize: 15.sp,
                                        )
                                      : ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: cart.items.length,
                                          itemBuilder: (context, index) {
                                            return CustomCartProductItem(
                                              imgUrl: cart.items.values.toList()[index].imgurl,
                                              price: cart.items.values.toList()[index].price.toString(),
                                              quantity: cart.items.values.toList()[index].quantity.toString(),
                                              total: (cart.items.values.toList()[index].quantity! *
                                                      cart.items.values.toList()[index].price!)
                                                  .toString(),
                                              onTapTrash: () {
                                                cart.removeItem(cart.items.values.toList()[index].id!);
                                              },
                                              onTapIncrease: () {
                                                cart.addItem(pdtid: cart.items.values.toList()[index].id.toString());
                                              },
                                              onTapDecrease: () {
                                                cart.removeSingleItem(cart.items.values.toList()[index].id.toString());
                                              },
                                            );
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
                                    borderRadius: BorderRadius.circular(8.r), border: Border.all(color: AppColors.greyBorder)),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(12.w),
                                      decoration:
                                          BoxDecoration(color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            'المجموع الكلي',
                                            fontSize: 16.sp,
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          CustomText(
                                            'انت تمتلك ${cart.items.length} منتجات بالسلة',
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
                                        if (cart.items.isNotEmpty) {
                                          setState(() => currentStepperIndex = 1);
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('يرجى إدخال منتجات إلى السلة للمتابعة'),
                                            ),
                                          );
                                        }
                                      },
                                      height: 40.h,
                                      widget: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            'تأكيد',
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
                                      title: 'استمرار عملية الشراء',
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
                                                  color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                              child: CustomText(
                                                'عنوان التسليم',
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 17.h,
                                            ),
                                            CustomTextFormField(
                                              controller: firstNameController,
                                              hintText: 'الإسم الأول',
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            CustomTextFormField(
                                              controller: lastNameController,
                                              hintText: 'الإسم الأخير',
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            CustomTextFormField(
                                              controller: emailController,
                                              hintText: 'البريد الإلكتروني',
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            CustomTextFormField(
                                              controller: phoneController,
                                              hintText: 'رقم الهاتف',
                                              inputType: TextInputType.phone,
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            CustomTextFormField(
                                              controller: address1Controller,
                                              hintText: 'عنوان ١',
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            CustomTextFormField(
                                              controller: address2Controller,
                                              hintText: 'عنوان ٢',
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            CustomTextFormField(
                                              controller: postcodeController,
                                              hintText: 'الرمز البريدي',
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
                                                    'اختر الدولة',
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
                                                            return DropdownMenuItem<CountriesResponse>(
                                                              value: value,
                                                              child: CustomText(
                                                                value.name,
                                                                fontSize: 9.sp,
                                                              ),
                                                            );
                                                          }).toList(),
                                                          hint: CustomText(
                                                            "اختر الدولة",
                                                            fontSize: 10.sp,
                                                          ),
                                                          onChanged: (CountriesResponse? value) {
                                                            setState(() {
                                                              selectedCountries = value;
                                                              selectedCountriesName = value?.name;
                                                              selectedCountriesCod = value?.code;
                                                            });
                                                            print(selectedCountriesName);
                                                            print(selectedCountriesCod);
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
                                              hintText: 'المدينة',
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
                                                  color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                              child: CustomText(
                                                'طريقة التوصيل',
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 17.h,
                                            ),
                                            shippingMethod == null
                                                ? const SizedBox()
                                                : GetBuilder<CartController>(
                                                    init: CartController(),
                                                    builder: (controller) {
                                                      return ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemCount: shippingMethod.length,
                                                        itemBuilder: (context, index) {
                                                          if (shippingMethod[index].id == 'naqel_shipping' ||
                                                              shippingMethod[index].id == 'redbox_pickup_delivery' ||
                                                              shippingMethod[index].id == 'free_shipping' &&
                                                                  totalPrice() >= 300) {
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
                                                                          selectedAddressName = shippingMethod[index].title;

                                                                          print(selectedAddress);
                                                                          print(selectedAddressName);
                                                                        });

                                                                        if (selectedAddress == 'redbox_pickup_delivery') {
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
                                                                          border:
                                                                              Border.all(width: 1.0, color: AppColors.greyBorder),
                                                                        ),
                                                                        child: Column(
                                                                          children: [
                                                                            CustomText(
                                                                              shippingMethod[index].title!,
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                            shippingGroupValue == index &&
                                                                                    selectedAddress == 'redbox_pickup_delivery' &&
                                                                                    appController.myMarker != null
                                                                                ? Column(
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      Divider(),
                                                                                      Row(
                                                                                        children: [
                                                                                          Flexible(
                                                                                            child: CustomText(
                                                                                              appController.myMarker?.point
                                                                                                      ?.address?.street ??
                                                                                                  '',
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
                                                                                                  borderRadius:
                                                                                                      BorderRadius.circular(5.r)),
                                                                                              child: CustomText(
                                                                                                'تعديل العنوان',
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
                                                      );
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
                                                  color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                              child: CustomText(
                                                'طريقة الدفع',
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 17.h,
                                            ),
                                            payment == null
                                                ? const SizedBox()
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemCount: payment.length,
                                                    itemBuilder: (context, index) {
                                                      if (payment[index].id == 'cod' ||
                                                          payment[index].id == 'geidea' ||
                                                          payment[index].id == 'tabby_credit_card_installments') {
                                                        return Column(
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Radio(
                                                                    activeColor: Theme.of(context).primaryColor,
                                                                    value: index,
                                                                    groupValue: paymentGroupValue,
                                                                    onChanged: (value) {
                                                                      setState(() {
                                                                        paymentGroupValue = value;
                                                                        selectedPaymentMethods = payment[index].id;
                                                                        selectedPaymentMethodsTitle = payment[index].title;
                                                                        print(selectedPaymentMethods);
                                                                        print(selectedPaymentMethodsTitle);
                                                                      });
                                                                    }),
                                                                Expanded(
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(18.w),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                      border: Border.all(width: 1.0, color: AppColors.greyBorder),
                                                                    ),
                                                                    child: CustomText(
                                                                      payment[index].title!,
                                                                      fontSize: 14.sp,
                                                                      fontWeight: FontWeight.normal,
                                                                    ),
                                                                  ),
                                                                )
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
                                        height: 32.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 19.0.w),
                                        child: CustomButton(
                                          onTap: () {
                                            if (selectedCountriesName != null &&
                                                cart.items.isNotEmpty &&
                                                address1Controller.text.isNotEmpty &&
                                                address2Controller.text.isNotEmpty &&
                                                cityController.text.isNotEmpty &&
                                                emailController.text.isNotEmpty &&
                                                phoneController.text.isNotEmpty &&
                                                firstNameController.text.isNotEmpty &&
                                                lastNameController.text.isNotEmpty &&
                                                postcodeController.text.isNotEmpty &&
                                                selectedPaymentMethods != null &&
                                                selectedPaymentMethodsTitle != null &&
                                                selectedCountriesCod != null &&
                                                selectedAddress != null &&
                                                selectedAddressName != null &&
                                                emailRegex.hasMatch(emailController.text)) {
                                              setState(() => currentStepperIndex = 2);
                                            } else {
                                              if (!emailRegex.hasMatch(emailController.text)) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('البريد الالكتروني غير صالح'),
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('يرجى إدخال كافة المعلومات'),
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
                                                'دفع ${totalPrice()} ر.س',
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
                                                  'المنتجات',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14.sp,
                                                ),
                                                SizedBox(
                                                  width: 22.w,
                                                ),
                                                CustomText(
                                                  cart.items.length.toString(),
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12.sp,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  'القيمة النهائية',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14.sp,
                                                ),
                                                SizedBox(
                                                  width: 22.w,
                                                ),
                                                CustomText(
                                                  totalPrice().toString(),
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
                                                  color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    'عنوان التسليم',
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
                                                  'عنوان التسليم',
                                                  fontSize: 14.sp,
                                                  color: const Color(0xff6C6C6C),
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                CustomText(
                                                  selectedCountriesName,
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
                                                  color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    'طريقة الدفع',
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
                                                  'طريقة الدفع',
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
                                                  color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    'طريقة  التوصيل',
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
                                                  'طريقة  التوصيل',
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
                                                      amount: totalPrice().toString(),
                                                      buyer: Buyer(
                                                        email: emailController.text ?? '',
                                                        phone: phoneController.text ?? '',
                                                        name: '${firstNameController.text} ${lastNameController.text}' ?? '',
                                                        dob: '2019-08-24',
                                                      ),
                                                      buyerHistory: BuyerHistory(
                                                        loyaltyLevel: 0,
                                                        registeredSince: '2019-08-24T14:15:22Z',
                                                        wishlistCount: 0,
                                                      ),
                                                      order: tabby.Order(referenceId: 'id123', items: getTabbyCartItem()),
                                                      orderHistory: [],
                                                      shippingAddress: ShippingAddress(
                                                        city: selectedCountriesName ?? '',
                                                        address:
                                                            'address1: ${address1Controller.text} / address2: ${address2Controller.text}',
                                                        zip: postcodeController.text,
                                                      ),
                                                    ));

                                              openInAppBrowser(() {
                                                OrderApies.orderApies
                                                    .createOrder2(
                                                  customer_id: auth?.id.toString(),
                                                  payment_method: selectedPaymentMethods!,
                                                  payment_method_title: selectedPaymentMethodsTitle!,
                                                  firstName: firstNameController.text,
                                                  lastName: lastNameController.text,
                                                  addressOne: address1Controller.text,
                                                  addressTwo: address2Controller.text,
                                                  city: cityController.text,
                                                  country: selectedCountriesCod!,
                                                  state: "",
                                                  postcode: postcodeController.text,
                                                  email: emailController.text,
                                                  phone: phoneController.text,
                                                  total: totalPrice().toString(),
                                                  listProduct: getCartItem(),
                                                  setPaid: true,
                                                  listShipment: [
                                                    {
                                                      "method_id": selectedAddress,
                                                      "method_title": selectedAddressName,
                                                      "total": selectedAddress == 'redbox_pickup_delivery'
                                                          ? '17'
                                                          : selectedAddress == 'naqel_shipping'
                                                              ? "30.00"
                                                              : '0'
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
                                                  Timer(
                                                    Duration(milliseconds: 500),
                                                    () {
                                                      cart.clear();
                                                      appController.setIndexScreen(0);
                                                    },
                                                  );
                                                });
                                              });
                                            } else if (selectedPaymentMethods == 'cod') {
                                              OrderApies.orderApies
                                                  .createOrder2(
                                                customer_id: auth?.id.toString(),
                                                payment_method: selectedPaymentMethods!,
                                                payment_method_title: selectedPaymentMethodsTitle!,
                                                firstName: firstNameController.text,
                                                lastName: lastNameController.text,
                                                addressOne: address1Controller.text,
                                                addressTwo: address2Controller.text,
                                                city: cityController.text,
                                                country: selectedCountriesCod!,
                                                state: "",
                                                postcode: postcodeController.text,
                                                email: emailController.text,
                                                phone: phoneController.text,
                                                total: totalPrice().toString(),
                                                listProduct: getCartItem(),
                                                setPaid: false,
                                                listShipment: [
                                                  {
                                                    "method_id": selectedAddress,
                                                    "method_title": selectedAddressName,
                                                    "total": selectedAddress == 'redbox_pickup_delivery'
                                                        ? '17'
                                                        : selectedAddress == 'naqel_shipping'
                                                            ? "30.00"
                                                            : '0'
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
                                                cart.clear();
                                                appController.setIndexScreen(0);
                                              });
                                            } else if (selectedPaymentMethods == 'geidea') {
                                              _handleCheckout(
                                                  context: context,
                                                  checkoutOptions: CheckoutOptions(
                                                    totalPrice().toString(), 'SAR', //SAR //EGP
                                                    callbackUrl: '',
                                                    lang: 'EN',
                                                    // billingAddress: Address(city: cityController.text, countryCode: selectedCountriesName, street: address1Controller.text, postCode: postcodeController.text),
                                                    // shippingAddress: Address(city: cityController.text, countryCode: selectedCountriesName, street: address1Controller.text, postCode: postcodeController.text),
                                                    customerEmail: emailController.text,
                                                    merchantReferenceID: '',
                                                    paymentIntentId: '',
                                                    paymentOperation: 'Default (merchant configuration)',
                                                    showShipping: false,
                                                    showBilling: false,
                                                    showSaveCard: false,
                                                  ),
                                                  createOrder: () {
                                                    OrderApies.orderApies
                                                        .createOrder2(
                                                      customer_id: auth?.id.toString(),
                                                      payment_method: selectedPaymentMethods!,
                                                      payment_method_title: selectedPaymentMethodsTitle!,
                                                      firstName: firstNameController.text,
                                                      lastName: lastNameController.text,
                                                      addressOne: address1Controller.text,
                                                      addressTwo: address2Controller.text,
                                                      city: cityController.text,
                                                      country: selectedCountriesCod!,
                                                      state: "",
                                                      postcode: postcodeController.text,
                                                      email: emailController.text,
                                                      phone: phoneController.text,
                                                      total: totalPrice().toString(),
                                                      listProduct: getCartItem(),
                                                      setPaid: true,
                                                      listShipment: [
                                                        {
                                                          "method_id": selectedAddress,
                                                          "method_title": selectedAddressName,
                                                          "total": selectedAddress == 'redbox_pickup_delivery'
                                                              ? '17'
                                                              : selectedAddress == 'naqel_shipping'
                                                                  ? "30.00"
                                                                  : '0'
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
                                                      Timer(
                                                        Duration(milliseconds: 500),
                                                        () {
                                                          cart.clear();
                                                          appController.setIndexScreen(0);
                                                        },
                                                      );
                                                    });
                                                  });
                                            }
                                          },
                                          height: 40.h,
                                          widget: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                'طلب',
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
            );
          },
        );
      },
    );
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
  String truncate(String text, {length: 200, omission: '...'}) {
    if (length >= text.length) {
      return text;
    }
    return text.replaceRange(length, text.length, omission);
  }

  _updateStatus(String? reference, String? message) {
    _showMessage('Reference: $reference \n Response: $message', const Duration(seconds: 7));
  }

  _showMessage(String message, [Duration duration = const Duration(seconds: 4)]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: duration,
      action: SnackBarAction(label: 'CLOSE', onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar()),
    ));
  }

  _handleCheckout({required BuildContext context, required checkoutOptions, required Function createOrder}) async {
    setState(() => _checkoutInProgress = true);
    try {
      OrderApiResponse response = await plugin.checkout(context: context, checkoutOptions: checkoutOptions).then((value) {
        value.responseCode == '000' && value.order?.status == 'Success' ? createOrder() : print('failed');
        return value;
      });
      print('Response = ${response.responseCode}');
      print('Response = ${response.order?.status}');
      print('Response = ${response.order?.detailedStatus}');
      setState(() => _checkoutInProgress = false);

      // _updateStatus(
      //     response.detailedResponseMessage, truncate(response.toString()));
      // if(response.responseCode == '000'&&response.order?.status == 'Success'&&response.order?.detailedStatus == 'Paid'){
      //
      // }
    } catch (e) {
      setState(() => _checkoutInProgress = false);
      _showMessage(e.toString());
      //rethrow;
    }
  }

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
