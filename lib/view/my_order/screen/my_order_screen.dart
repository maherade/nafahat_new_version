import 'dart:async';
import 'dart:math';

import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSDKQueryConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSDKSavedCardInfo.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:geideapay/geideapay.dart';
import 'package:geideapay/widgets/checkout/checkout_options.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perfume_store_mobile_app/apies/order_apies.dart';
import 'package:perfume_store_mobile_app/controller/order_controller.dart';
import 'package:perfume_store_mobile_app/services/sp_helper.dart';

import '../../../services/app_imports.dart';
import '../../../services/src/models/models.dart';
import '../../custom_widget/custom_dialog.dart';
import '../widget/current_order_item.dart';
import '../widget/previous_order_item.dart';
import 'package:perfume_store_mobile_app/services/tabby_flutter_inapp_sdk.dart' as tabby;

class MyOrderScreen extends StatefulWidget {
  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  OrderController orderController = Get.find();
  String selectOrderList = 'current';

  //----------------- Giedea Payment----------------
  bool _checkoutInProgress = false;
  final plugin = GeideapayPlugin();

  String geideaPublicKey = 'e4d809d6-6a55-4627-bcb9-6628fe4f6171'; //nafahat
  String geideaApiPassword = '6686ecfb-2db6-4b73-9ab2-9c9f6c776efc'; //nafahat
//----------------- Tabby ----------------
  tabby.WebViewResult? tabbyResultCode;

////
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

/////
  Future<void> payPressed({createOrder,required PaymentSdkConfigurationDetails? generateConfig}) async {
    FlutterPaytabsBridge.startCardPayment(generateConfig!, (event) {
      setState(() {
        print('yehya'+event.toString());
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
            ScaffoldMessenger.of(context)
                .showSnackBar( SnackBar(content: Text(transactionDetails["paymentResult"]["responseMessage"].toString()),duration: Duration(milliseconds: 900),backgroundColor: Colors.red));
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

/////
  @override
  void initState() {
    plugin.initialize(
      publicKey: geideaPublicKey,
      apiPassword: geideaApiPassword,
    );
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getCurrentLang();
    });
    OrderApies.orderApies.getTheEstimateDeliveryTime();

    OrderApies.orderApies.getOrderList(
        customerID: SPHelper.spHelper.getUserId(), status: 'pending,processing,on-hold,refunded,failed,checkout-draft');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Current date and time
    DateTime now = DateTime.now();

    // Estimated delivery time in hours (based on the JSON response)
    double deliveryTimeHours = orderController.getDeliveryTimeData?.value.deliveryTime??0.0;

    // Calculate the delivery date and time
    DateTime deliveryTime = now.add(Duration(hours: deliveryTimeHours.toInt()));

    // Format the delivery date and time as a string
    String deliveryDateString = "${deliveryTime.month}/${deliveryTime.day}/${deliveryTime.year} ";
    String deliveryTimeString = "${deliveryTime.hour}:${deliveryTime.minute.toString().padLeft(2, '0')}";

    return Scaffold(
      body: Obx(
        () {
          var order = orderController.getOrderListData?.value.listOrderListResponse;
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
                      'my_orders'.tr,
                      fontSize: 15.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                height: 50.h,
                margin: EdgeInsets.symmetric(horizontal: 18.w),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), border: Border.all(color: Color(0xffdcd9da))),
                child: Row(
                  children: [
                    selectOrderList == 'current'
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                'current_orders'.tr,
                                fontSize: 14.sp,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                width: 90.w,
                                height: 3.h,
                                decoration:
                                    BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(5.r)),
                              )
                            ],
                          )
                        : GestureDetector(
                            onTap: () {
                              OrderApies.orderApies.getOrderList(
                                  customerID: SPHelper.spHelper.getUserId(),
                                  status: 'pending,processing,on-hold,refunded,failed,checkout-draft');
                              setState(() {
                                selectOrderList = 'current';
                              });
                            },
                            child: CustomText(
                              'current_orders'.tr,
                              fontSize: 14.sp,
                            ),
                          ),
                    Spacer(),
                    selectOrderList == 'previous'
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                'previous_orders'.tr,
                                fontSize: 14.sp,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                width: 90.w,
                                height: 3.h,
                                decoration:
                                    BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(5.r)),
                              )
                            ],
                          )
                        : GestureDetector(
                            onTap: () {
                              OrderApies.orderApies
                                  .getOrderList(customerID: SPHelper.spHelper.getUserId(), status: 'completed,cancelled');
                              setState(() {
                                selectOrderList = 'previous';
                              });
                            },
                            child: CustomText(
                              'previous_orders'.tr,
                              fontSize: 14.sp,
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              if (order != null) ...{
                if (order.isEmpty) ...{
                  CustomText(
                    'no_orders_available'.tr,
                    fontSize: 14.sp,
                  )
                } else ...{
                  selectOrderList == 'current'
                      ? Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: order.length,
                            itemBuilder: (context, index) {
                              List<String> items = [];
                              for (var element in order[index].lineItems!) {
                                items.add(element.name ?? '');
                              }
                              return CurrentOrderItem(
                                orderId: order[index].id.toString(),
                                orderStatus: order[index].status,
                                productName: items.join(),
                                productPrice: order[index].total,
                                deliveryLocation: order[index].shipping?.city ?? '',
                                deliveryDate: deliveryDateString,
                                deliveryTime: deliveryTimeString,
                                paymentMethod: order[index].paymentMethodTitle,
                                imgUrls: order[index].lineItems,
                                onTapCancelOrder: () {
                                  CustomDialog.customDialog.showCancelOrderDialog(onTap: () {
                                    Get.back();
                                    OrderApies.orderApies.cancelOrder(orderID: order[index].id.toString());
                                  });
                                },
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: order.length,
                            itemBuilder: (context, index) {
                              List<Map<String, dynamic>> getCartItem() {
                                List<Map<String, dynamic>> list = [];
                                order[index].lineItems?.forEach((value) {
                                  list.add({
                                    'product_id': value.productId,
                                    'quantity': value.quantity!.toInt(),
                                  });
                                });
                                return list;
                              }

                              List<OrderItem> getTabbyCartItem() {
                                List<OrderItem> list = [];
                                order[index].lineItems?.forEach((value) {
                                  list.add(OrderItem(
                                    title: value.name ?? '',
                                    description: value.name ?? '',
                                    quantity: value.quantity?.toInt() ?? 0,
                                    unitPrice: value.price.toString(),
                                    referenceId: value.id.toString(),
                                    productUrl: '',
                                    category: '',
                                  ));
                                });
                                return list;
                              }

                              List<Map<String, dynamic>> getRedboxCartItem() {
                                List<Map<String, dynamic>> list = [];
                                order[index].lineItems?.forEach((value) {
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

                              List<String> items = [];
                              for (var element in order[index].lineItems!) {
                                items.add(element.name ?? '');
                              }

                              // payTaps Start
                              PaymentSdkConfigurationDetails generateConfig() {
                                var billingDetails = BillingDetails("${order[index].billing?.firstName} ${order[index].billing?.lastName} ", order[index].billing?.email,
                                    order[index].billing?.phone, order[index].billing?.address1, order[index].billing?.country, order[index].billing?.city, order[index].billing?.address2, order[index].billing?.postcode);
                                var shippingDetails = ShippingDetails("${order[index].billing?.firstName} ${order[index].billing?.lastName} ", order[index].billing?.email,
                                    order[index].billing?.phone, order[index].billing?.address1, order[index].billing?.country, order[index].billing?.city, order[index].billing?.address2, order[index].billing?.postcode);
                                List<PaymentSdkAPms> apms = [];
                                apms.add(PaymentSdkAPms.STC_PAY);
                                var configuration = PaymentSdkConfigurationDetails(
                                    profileId: "98726",
                                    serverKey: "S9JN2KT6Z2-J6DTGKDT96-D66WKJZ9J6",
                                    clientKey: "CRKMQV-6KK96G-D7TKD7-HMRDKT",
                                    cartId: Random().nextInt(100).toString(),
                                    cartDescription: getTabbyCartItem().toString(),
                                    merchantName: "شركة الجمال والصحة للتجارة",
                                    screentTitle: "",
                                    amount: order[index].total,
                                    showBillingInfo: true,
                                    forceShippingInfo: false,
                                    currencyCode: "SAR",//"EGP",//SAR
                                    merchantCountryCode:"SA",// "EG",//""
                                    billingDetails: billingDetails,
                                    shippingDetails: shippingDetails,
                                    alternativePaymentMethods: apms,
                                    locale: PaymentSdkLocale.AR,
                                    hideCardScanner: true,

                                    linkBillingNameWithCardHolderName: true);

                                var theme = IOSThemeConfigurations(
                                  buttonColor:"#C9415E",
                                  titleFontColor: "#C9415E",
                                  secondaryFontColor: "#C9415E",
                                  secondaryColor:  "#C9415E",
                                );

                                theme.logoImage = "assets/images/logo.png";

                                configuration.iOSThemeConfigurations = theme;
                                configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
                                configuration.showShippingInfo = true;

                                return configuration;
                              }
                              // payTaps End
                              return PreviousOrderItem(
                                orderId: order[index].id.toString(),
                                orderStatus: order[index].status,
                                productName: items.join(),
                                productPrice: order[index].total,
                                deliveryLocation: order[index].shipping?.city ?? '',
                                deliveryDate: order[index].dateCompleted,
                                deliveryTime: order[index].dateCompleted,
                                paymentMethod: order[index].paymentMethodTitle,
                                imgUrls: order[index].lineItems,
                                onTapReOrder: ()  {
                                  print(getCartItem());
                                  CustomDialog.customDialog.showConfirmReOrderDialog(
                                    onTap: () async {
                                      Get.back();
                                      if (order[index].paymentMethod == 'tabby_credit_card_installments') {
                                        session == null && _status == 'pending'
                                            ? null
                                            : await createSession(tabby.Payment(
                                          currency: tabby.Currency.sar,
                                          amount: order[index].total.toString(),
                                          buyer: Buyer(
                                            email: order[index].billing?.email ?? '',
                                            phone: order[index].billing?.phone ?? '',
                                            name: '${order[index].billing?.firstName} ${order[index].billing?.lastName}' ?? '',
                                            dob: '2019-08-24',
                                          ),
                                          buyerHistory: BuyerHistory(
                                            loyaltyLevel: 0,
                                            registeredSince: '2019-08-24T14:15:22Z',
                                            wishlistCount: 0,
                                          ),
                                          order:
                                          tabby.Order(referenceId: order[index].id.toString(), items: getTabbyCartItem()),
                                          orderHistory: [],
                                          shippingAddress: ShippingAddress(
                                            city: order[index].billing?.city ?? '',
                                            address:
                                            'address1: ${order[index].billing?.address1} / address2: ${order[index].billing?.address2}',
                                            zip: order[index].billing?.postcode,
                                          ),
                                        ));

                                        openInAppBrowser(() {
                                          OrderApies.orderApies
                                              .createOrder2(
                                            customer_id: SPHelper.spHelper.getUserId(),
                                            payment_method: order[index].paymentMethod,
                                            payment_method_title: order[index].paymentMethodTitle,
                                            firstName: order[index].billing?.firstName,
                                            lastName: order[index].billing?.lastName,
                                            addressOne: order[index].billing?.address1,
                                            addressTwo: order[index].billing?.address2,
                                            city: order[index].billing?.city,
                                            country: order[index].billing?.country,
                                            state: "",
                                            postcode: order[index].billing?.postcode,
                                            email: order[index].billing?.email,
                                            phone: order[index].billing?.phone,
                                            total: order[index].total,
                                            listProduct: getCartItem(),
                                            setPaid: true,
                                            listShipment: [
                                              {
                                                "method_id": order[index].shippingLines?[0].methodId,
                                                "method_title": order[index].shippingLines?[0].methodTitle,
                                                "total": order[index].shippingLines?[0].methodId == 'redbox_pickup_delivery'
                                                    ? '17'
                                                    : order[index].shippingLines?[0].methodId == 'naqel_shipping'
                                                    ? "30.00"
                                                    : '0'
                                              }
                                            ],
                                            listMetaData: order[index].metaData!.isNotEmpty
                                                ? [
                                              {
                                                'key': '_redbox_point',
                                                'value': order[index].metaData?[0].value,
                                              },
                                              {
                                                'key': '_redbox_point_id',
                                                'value': order[index].metaData?[1].value,
                                              },
                                            ]
                                                : [],
                                          )
                                              .then((value) {
                                            order[index].metaData!.isNotEmpty
                                                ? OrderApies.orderApies.createRedBoxShippment(
                                                items: getRedboxCartItem(),
                                                reference: value.id.toString(),
                                                point_id: order[index].metaData?[1].value ?? '',
                                                sender_name: 'مؤسسة الجمال والصحة للتجارة',
                                                sender_email: 'info@dermarollersystemsa.com',
                                                sender_phone: '0114130336',
                                                sender_address: 'Riyadh -  - ',
                                                customer_name:
                                                '${order[index].billing?.firstName} - ${order[index].billing?.firstName}',
                                                customer_email: order[index].billing?.email,
                                                customer_phone: order[index].billing?.phone,
                                                customer_address:
                                                '${order[index].billing?.address1} - ${order[index].billing?.address2}',
                                                cod_currency: 'SAR',
                                                cod_amount: order[index].total,
                                                nameOfPackage: 'nameOfPackage')
                                                : print('my Marker not Selected');
                                          });
                                        });
                                      } else if (order[index].paymentMethod == 'cod') {
                                        OrderApies.orderApies
                                            .createOrder2(
                                          customer_id: SPHelper.spHelper.getUserId(),
                                          payment_method: order[index].paymentMethod,
                                          payment_method_title: order[index].paymentMethodTitle,
                                          firstName: order[index].billing?.firstName,
                                          lastName: order[index].billing?.lastName,
                                          addressOne: order[index].billing?.address1,
                                          addressTwo: order[index].billing?.address2,
                                          city: order[index].billing?.city,
                                          country: order[index].billing?.country,
                                          state: "",
                                          postcode: order[index].billing?.postcode,
                                          email: order[index].billing?.email,
                                          phone: order[index].billing?.phone,
                                          total: order[index].total,
                                          listProduct: getCartItem(),
                                          setPaid: false,
                                          listShipment: [
                                            {
                                              "method_id": order[index].shippingLines?[0].methodId,
                                              "method_title": order[index].shippingLines?[0].methodTitle,
                                              "total": order[index].shippingLines?[0].methodId == 'redbox_pickup_delivery'
                                                  ? '17'
                                                  : order[index].shippingLines?[0].methodId == 'naqel_shipping'
                                                  ? "30.00"
                                                  : '0'
                                            }
                                          ],
                                          listMetaData: order[index].metaData!.isNotEmpty
                                              ? [
                                            {
                                              'key': '_redbox_point',
                                              'value': order[index].metaData?[0].value,
                                            },
                                            {
                                              'key': '_redbox_point_id',
                                              'value': order[index].metaData?[1].value,
                                            },
                                          ]
                                              : [],
                                        )
                                            .then((value) {
                                          order[index].metaData!.isNotEmpty
                                              ? OrderApies.orderApies.createRedBoxShippment(
                                              items: getRedboxCartItem(),
                                              reference: value.id.toString(),
                                              point_id: order[index].metaData?[1].value ?? '',
                                              sender_name: 'مؤسسة الجمال والصحة للتجارة',
                                              sender_email: 'info@dermarollersystemsa.com',
                                              sender_phone: '0114130336',
                                              sender_address: 'Riyadh -  - ',
                                              customer_name:
                                              '${order[index].billing?.firstName} - ${order[index].billing?.firstName}',
                                              customer_email: order[index].billing?.email,
                                              customer_phone: order[index].billing?.phone,
                                              customer_address:
                                              '${order[index].billing?.address1} - ${order[index].billing?.address2}',
                                              cod_currency: 'SAR',
                                              cod_amount: order[index].total,
                                              nameOfPackage: 'nameOfPackage')
                                              : print('my Marker not Selected');
                                        });
                                      }
                                      else if (order[index].paymentMethod == 'geidea') {
                                        _handleCheckout(
                                            context: context,
                                            checkoutOptions: CheckoutOptions(
                                              order[index].total, 'SAR', //SAR //EGP
                                              callbackUrl: '',
                                              lang: 'EN',
                                              // billingAddress: Address(city: cityController.text, countryCode: selectedCountriesName, street: address1Controller.text, postCode: postcodeController.text),
                                              // shippingAddress: Address(city: cityController.text, countryCode: selectedCountriesName, street: address1Controller.text, postCode: postcodeController.text),
                                              customerEmail: order[index].billing?.email,
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
                                                customer_id: SPHelper.spHelper.getUserId(),
                                                payment_method: order[index].paymentMethod,
                                                payment_method_title: order[index].paymentMethodTitle,
                                                firstName: order[index].billing?.firstName,
                                                lastName: order[index].billing?.lastName,
                                                addressOne: order[index].billing?.address1,
                                                addressTwo: order[index].billing?.address2,
                                                city: order[index].billing?.city,
                                                country: order[index].billing?.country,
                                                state: "",
                                                postcode: order[index].billing?.postcode,
                                                email: order[index].billing?.email,
                                                phone: order[index].billing?.phone,
                                                total: order[index].total,
                                                listProduct: getCartItem(),
                                                setPaid: true,
                                                listShipment: [
                                                  {
                                                    "method_id": order[index].shippingLines?[0].methodId,
                                                    "method_title": order[index].shippingLines?[0].methodTitle,
                                                    "total": order[index].shippingLines?[0].methodId == 'redbox_pickup_delivery'
                                                        ? '17'
                                                        : order[index].shippingLines?[0].methodId == 'naqel_shipping'
                                                        ? "30.00"
                                                        : '0'
                                                  }
                                                ],
                                                listMetaData: order[index].metaData!.isNotEmpty
                                                    ? [
                                                  {
                                                    'key': '_redbox_point',
                                                    'value': order[index].metaData?[0].value,
                                                  },
                                                  {
                                                    'key': '_redbox_point_id',
                                                    'value': order[index].metaData?[1].value,
                                                  },
                                                ]
                                                    : [],
                                              )
                                                  .then((value) {
                                                order[index].metaData!.isNotEmpty
                                                    ? OrderApies.orderApies.createRedBoxShippment(
                                                    items: getRedboxCartItem(),
                                                    reference: value.id.toString(),
                                                    point_id: order[index].metaData?[1].value ?? '',
                                                    sender_name: 'مؤسسة الجمال والصحة للتجارة',
                                                    sender_email: 'info@dermarollersystemsa.com',
                                                    sender_phone: '0114130336',
                                                    sender_address: 'Riyadh -  - ',
                                                    customer_name:
                                                    '${order[index].billing?.firstName} - ${order[index].billing?.firstName}',
                                                    customer_email: order[index].billing?.email,
                                                    customer_phone: order[index].billing?.phone,
                                                    customer_address:
                                                    '${order[index].billing?.address1} - ${order[index].billing?.address2}',
                                                    cod_currency: 'SAR',
                                                    cod_amount: order[index].total,
                                                    nameOfPackage: 'nameOfPackage')
                                                    : print('my Marker not Selected');
                                              });
                                            });
                                      }
                                      else if (order[index].paymentMethod == 'paytabs_all') {
                                        payPressed(generateConfig: generateConfig(),createOrder:(){
                                          OrderApies.orderApies
                                              .createOrder2(
                                            customer_id: SPHelper.spHelper.getUserId(),
                                            payment_method: order[index].paymentMethod,
                                            payment_method_title: order[index].paymentMethodTitle,
                                            firstName: order[index].billing?.firstName,
                                            lastName: order[index].billing?.lastName,
                                            addressOne: order[index].billing?.address1,
                                            addressTwo: order[index].billing?.address2,
                                            city: order[index].billing?.city,
                                            country: order[index].billing?.country,
                                            state: "",
                                            postcode: order[index].billing?.postcode,
                                            email: order[index].billing?.email,
                                            phone: order[index].billing?.phone,
                                            total: order[index].total,
                                            listProduct: getCartItem(),
                                            setPaid: true,
                                            listShipment: [
                                              {
                                                "method_id": order[index].shippingLines?[0].methodId,
                                                "method_title": order[index].shippingLines?[0].methodTitle,
                                                "total": order[index].shippingLines?[0].methodId == 'redbox_pickup_delivery'
                                                    ? '17'
                                                    : order[index].shippingLines?[0].methodId == 'naqel_shipping'
                                                    ? "30.00"
                                                    : '0'
                                              }
                                            ],
                                            listMetaData: order[index].metaData!.isNotEmpty
                                                ? [
                                              {
                                                'key': '_redbox_point',
                                                'value': order[index].metaData?[0].value,
                                              },
                                              {
                                                'key': '_redbox_point_id',
                                                'value': order[index].metaData?[1].value,
                                              },
                                            ]
                                                : [],
                                          )
                                              .then((value) {
                                            order[index].metaData!.isNotEmpty
                                                ? OrderApies.orderApies.createRedBoxShippment(
                                                items: getRedboxCartItem(),
                                                reference: value.id.toString(),
                                                point_id: order[index].metaData?[1].value ?? '',
                                                sender_name: 'مؤسسة الجمال والصحة للتجارة',
                                                sender_email: 'info@dermarollersystemsa.com',
                                                sender_phone: '0114130336',
                                                sender_address: 'Riyadh -  - ',
                                                customer_name:
                                                '${order[index].billing?.firstName} - ${order[index].billing?.firstName}',
                                                customer_email: order[index].billing?.email,
                                                customer_phone: order[index].billing?.phone,
                                                customer_address:
                                                '${order[index].billing?.address1} - ${order[index].billing?.address2}',
                                                cod_currency: 'SAR',
                                                cod_amount: order[index].total,
                                                nameOfPackage: 'nameOfPackage')
                                                : print('my Marker not Selected');
                                          });
                                        });
                                      }
                                    }
                                  );

                                },
                              );
                            },
                          ),
                        )
                }
              } else ...{
                CupertinoActivityIndicator()
              }
            ],
          );
        },
      ),
    );
  }

  // ------------------------ Giedea Payment ---------------------------
  String truncate(String text, {length: 200, omission: '...'}) {
    if (length >= text.length) {
      return text;
    }
    return text.replaceRange(length, text.length, omission);
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
}
