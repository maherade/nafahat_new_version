import 'dart:async';
import 'dart:developer';
import 'dart:io' show Platform;


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSDKQueryConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSDKSavedCardInfo.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';

import 'dart:io';
import 'package:flutter/services.dart';

import 'package:location/location.dart';
import 'package:perfume_store_mobile_app/services/Settingss.dart';
import 'package:perfume_store_mobile_app/services/locale.dart';
import 'package:perfume_store_mobile_app/services/locale_controller.dart';
import 'package:perfume_store_mobile_app/services/sp_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'apies/auth_apies.dart';
import 'apies/product_apies.dart';
import 'controller/app_controller.dart';
import 'controller/auth_controller.dart';
import 'controller/brand_controller.dart';
import 'controller/cart_controller.dart';
import 'controller/category_controller.dart';
import 'controller/contact_us_controller.dart';
import 'controller/favourite_controller.dart';
import 'controller/order_controller.dart';
import 'controller/posts_controller.dart';
import 'controller/product_controller.dart';
import 'controller/review_controller.dart';
import 'services/app_imports.dart';
import 'services/firebase_notification.dart';
import 'services/tabby_flutter_inapp_sdk.dart';
import 'view/splash/screen/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart' as premession;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SPHelper.spHelper.initSharedPrefrences();
  await Settingss.settings.initDio();
  TabbySDK().setup(
    withApiKey: 'pk_ad7698e9-0586-4af9-8db5-3d41ac039436', // Put here your Api key
     environment: Environment.production, // Or use Environment.stage
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryColor,
  ));

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    NotificationHelper.notificationHelper.initialNotification();
    log("User Token${SPHelper.spHelper.getToken()}");
    Location.instance.requestPermission();
    requestMapPermission();
    super.initState();
  }
 requestMapPermission() async {
   await [Permission.location,Permission.locationAlways,Permission.locationWhenInUse].request();
}
  @override
  Widget build(BuildContext context) {
    MyLocaleController controller = Get.put(MyLocaleController());

    return ScreenUtilInit(
      designSize: const Size(375, 853),
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            primaryColor: AppColors.primaryColor,
          ),
          title: 'متجر نفحات',
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 300),
          debugShowCheckedModeBanner: false,
           // locale: Locale('ar'),
           locale: controller.initialLang,
          translations: MyLocale(),
          builder: (context, widget) {
            Get.put(AppController());
            Get.put(CategoryController());
            Get.put(BrandController());
            Get.put(ProductController());
            Get.put(CartController());
            Get.put(PostsController());
            Get.put(ReviewController());
            Get.put(AuthController());
            Get.put(OrderController());
            Get.put(ContactUsController());
            Get.put(FavouriteController());
            return widget!;
          },
          home: SplashScreen() ,
        );
      },
    );
  }
}



class Bannders extends StatefulWidget {
  const Bannders({Key? key}) : super(key: key);

  @override
  State<Bannders> createState() => _BanndersState();
}

class _BanndersState extends State<Bannders> {
  ProductController productController = Get.find();

  @override
  void initState() {
    ProductApies.productApies.getAds();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () {
          var ads = productController.getAdsData?.value.listAdsResponse;
          return ListView.builder(
            itemCount: ads?.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  CustomText(index.toString()),
                  Image.network(ads?[index].image??'',width: 300,height: 70,fit: BoxFit.fill,)
                ],
              );
            },);
        },
      ),
    );
  }
}


class TestPay extends StatefulWidget {
  @override
  _TestPayState createState() => _TestPayState();
}

class _TestPayState extends State<TestPay> {
  String _instructions = 'Tap on "Pay" Button to try PayTabs plugin';

  @override
  void initState() {
    super.initState();
  }

  PaymentSdkConfigurationDetails generateConfig() {
    var billingDetails = BillingDetails("John Smith", "email@domain.com",
        "+97311111111", "st. 12", "eg", "dubai", "dubai", "12345");
    var shippingDetails = ShippingDetails("John Smith", "email@domain.com",
        "+97311111111", "st. 12", "eg", "dubai", "dubai", "12345");
    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.STC_PAY);
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "63904",
        serverKey: "STJNNNTDKB-JBKWMD9Z9R-LKLNZBJLG2",
        clientKey: "CHKMMD-6MQ962-KVNDP9-NVRM92",
        cartId: "12433",
        cartDescription: "Flowers",
        merchantName: "Flowers Store",
        screentTitle: "Pay with Card",
        amount: 20.0,
        showBillingInfo: true,
        forceShippingInfo: false,
        currencyCode: "EGP",
        merchantCountryCode: "EG",
        billingDetails: billingDetails,
        shippingDetails: shippingDetails,
        alternativePaymentMethods: apms,
        linkBillingNameWithCardHolderName: true);

    var theme = IOSThemeConfigurations();

    theme.logoImage = "assets/images/logo.png";

    configuration.iOSThemeConfigurations = theme;
    configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    return configuration;
  }

  Future<void> payPressed() async {
    FlutterPaytabsBridge.startCardPayment(generateConfig(), (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            print("failed transaction");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Future<void> payWithTokenPressed() async {
    FlutterPaytabsBridge.startTokenizedCardPayment(
        generateConfig(), "*Token*", "*TransactionReference*", (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            print("failed transaction");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Future<void> payWith3ds() async {
    FlutterPaytabsBridge.start3DSecureTokenizedCardPayment(
        generateConfig(),
        PaymentSDKSavedCardInfo("4111 11## #### 1111", "visa"),
        "*Token*", (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            print("failed transaction");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Future<void> payWithSavedCards() async {
    FlutterPaytabsBridge.startPaymentWithSavedCards(generateConfig(), false,
            (event) {
          setState(() {
            if (event["status"] == "success") {
              // Handle transaction details here.
              var transactionDetails = event["data"];
              print(transactionDetails);
              if (transactionDetails["isSuccess"]) {
                print("successful transaction");
                if (transactionDetails["isPending"]) {
                  print("transaction pending");
                }
              } else {
                print("failed transaction");
              }

              // print(transactionDetails["isSuccess"]);
            } else if (event["status"] == "error") {
              // Handle error here.
            } else if (event["status"] == "event") {
              // Handle events here.
            }
          });
        });
  }

  Future<void> apmsPayPressed() async {
    FlutterPaytabsBridge.startAlternativePaymentMethod(await generateConfig(),
            (event) {
          setState(() {
            if (event["status"] == "success") {
              // Handle transaction details here.
              var transactionDetails = event["data"];
              print(transactionDetails);
            } else if (event["status"] == "error") {
              // Handle error here.
            } else if (event["status"] == "event") {
              // Handle events here.
            }
          });
        });
  }

  Future<void> queryPressed() async {
    FlutterPaytabsBridge.queryTransaction(
        generateConfig(), generateQueryConfig(), (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Future<void> applePayPressed() async {
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "*Profile id*",
        serverKey: "*server key*",
        clientKey: "*client key*",
        cartId: "12433",
        cartDescription: "Flowers",
        merchantName: "Flowers Store",
        amount: 20.0,
        currencyCode: "AED",
        merchantCountryCode: "ae",
        merchantApplePayIndentifier: "merchant.com.bunldeId",
        simplifyApplePayValidation: true);
    FlutterPaytabsBridge.startApplePayPayment(configuration, (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Widget applePayButton() {
    if (Platform.isIOS) {
      return TextButton(
        onPressed: () {
          applePayPressed();
        },
        child: Text('Pay with Apple Pay'),
      );
    }
    return SizedBox(height: 0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PayTabs Plugin Example App'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('$_instructions'),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      payPressed();
                    },
                    child: Text('Pay with Card'),
                  ),
                  TextButton(
                    onPressed: () {
                      payWithTokenPressed();
                    },
                    child: Text('Pay with Token'),
                  ),
                  TextButton(
                    onPressed: () {
                      payWith3ds();
                    },
                    child: Text('Pay with 3ds'),
                  ),
                  TextButton(
                    onPressed: () {
                      payWithSavedCards();
                    },
                    child: Text('Pay with saved cards'),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      apmsPayPressed();
                    },
                    child: Text('Pay with Alternative payment methods'),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      queryPressed();
                    },
                    child: Text('Query transaction'),
                  ),
                  SizedBox(height: 16),
                  applePayButton()
                ])),
      ),
    );
  }

  PaymentSDKQueryConfiguration generateQueryConfig() {
    return new PaymentSDKQueryConfiguration("ServerKey", "ClientKey",
        "Country Iso 2", "Profile Id", "Transaction Reference");
  }
}









