import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geideapay/geideapay.dart';
import 'package:geideapay/widgets/checkout/checkout_options.dart';
import 'package:location/location.dart';
import 'package:perfume_store_mobile_app/services/Settingss.dart';
import 'package:perfume_store_mobile_app/services/helper.dart';
import 'package:perfume_store_mobile_app/services/sp_helper.dart';
import 'package:perfume_store_mobile_app/services/src/internal/tabby_sdk.dart';
import 'package:perfume_store_mobile_app/view/geidea_payy/screen/apiFlow.dart';
import 'package:perfume_store_mobile_app/view/geidea_payy/screen/checkoutFlow.dart';
import 'package:permission_handler/permission_handler.dart';
import 'controller/app_controller.dart';
import 'controller/auth_controller.dart';
import 'controller/brand_controller.dart';
import 'controller/cart_controller.dart';
import 'controller/category_controller.dart';
import 'controller/contact_us_controller.dart';
import 'controller/order_controller.dart';
import 'controller/posts_controller.dart';
import 'controller/product_controller.dart';
import 'controller/review_controller.dart';
import 'services/app_imports.dart';
import 'services/firebase_notification.dart';
import 'view/splash/screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TabbySDK().setup(
    withApiKey: 'pk_test_ba5ec72a-3026-41f5-bc3a-881f21b9614a', // Put here your Api key
    // environment: Environment.production, // Or use Environment.stage
  );
  Firebase.initializeApp();
  await SPHelper.spHelper.initSharedPrefrences();
  await Settingss.settings.initDio();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryColor,
  ));
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
      AndroidServiceWorkerController.instance();

      serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      );
    }
  }
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
    NotificationHelper().initialNotification();
    Location.instance.requestPermission();
    requestMapPermission();
    super.initState();
  }
 requestMapPermission() async {
   await [Permission.location,Permission.locationAlways,Permission.locationWhenInUse].request();
}
  @override
  Widget build(BuildContext context) {
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
          locale: const Locale('ar'),
          fallbackLocale: const Locale('ar'),
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
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
            return widget!;
          },
          supportedLocales: const [
            Locale('ar', 'AE'),
          ],
          home: SplashScreen() ,
        );
      },
    );
  }
}
class TestGGG extends StatefulWidget {
  const TestGGG({Key? key}) : super(key: key);

  @override
  State<TestGGG> createState() => _TestGGGState();
}

class _TestGGGState extends State<TestGGG> {
  bool _checkoutInProgress = false;
  final plugin = GeideapayPlugin();
  String geideaPublicKey = 'f7bdf1db-f67e-409b-8fe7-f7ecf9634f70';
  String geideaApiPassword = '0c9b36c1-3410-4b96-878a-dbd54ace4e9a';
  @override
  void initState() {
    plugin.initialize(publicKey: geideaPublicKey, apiPassword: geideaApiPassword );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getPlatformButton(
                'Checkout',
                    () => _handleCheckout(context,CheckoutOptions(
                  '100', 'EGP',
                  callbackUrl: '',
                  lang: 'EN',
                  customerEmail: '',
                  merchantReferenceID: '',
                  paymentIntentId: '',
                  paymentOperation: 'Default (merchant configuration)',
                  showShipping: false,
                  showBilling: false,
                  showSaveCard: false,
                )),
                true
            ),
          ],
        ),
      ),
    );
  }

  String truncate(String text, { length: 200, omission: '...' }) {
    if (length >= text.length) {
      return text;
    }
    return text.replaceRange(length, text.length, omission);
  }
  _handleCheckout(BuildContext context,checkoutOptions) async {

    setState(() => _checkoutInProgress = true);
    try {
      OrderApiResponse response =
      await plugin.checkout(
          context: context, checkoutOptions: checkoutOptions);
      print('Response = $response');
      setState(() => _checkoutInProgress = false);

      _updateStatus(
          response.detailedResponseMessage, truncate(response.toString()));
    } catch (e) {
      setState(() => _checkoutInProgress = false);
      _showMessage(e.toString());
      //rethrow;
    }

  }
  _updateStatus(String? reference, String? message) {
    _showMessage('Reference: $reference \n Response: $message',
        const Duration(seconds: 7));
  }

  _showMessage(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: duration,
      action: SnackBarAction(
          label: 'CLOSE',
          onPressed: () =>
              ScaffoldMessenger.of(context).removeCurrentSnackBar()),
    ));
  }
  Widget _getPlatformButton(String string, Function() function, bool active) {
    // is still in progress
    Widget widget;
    if (Platform.isIOS) {
      widget = CupertinoButton(
        onPressed: function,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        color: active? CupertinoColors.activeBlue : CupertinoColors.inactiveGray,
        child: Text(
          string,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      widget = ElevatedButton(
        onPressed: active? function : null,
        child: Text(
          string.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
        style: ButtonStyle(
            backgroundColor: active? MaterialStateProperty.all(Colors.lightBlue) : MaterialStateProperty.all(Colors.grey)),
      );
    }
    return widget;
  }
}

class TestGeidea extends StatefulWidget {
  @override
  State<TestGeidea> createState() => _TestGeideaState();
}

class _TestGeideaState extends State<TestGeidea> {
  String geideaPublicKey = '';

  String geideaApiPassword = '';

  var publicKeyTxt = TextEditingController();

  var apiPasswordTxt = TextEditingController();

  @override
  void initState() {
    publicKeyTxt.text = geideaPublicKey = 'f7bdf1db-f67e-409b-8fe7-f7ecf9634f70';
    apiPasswordTxt.text = geideaApiPassword = '0c9b36c1-3410-4b96-878a-dbd54ace4e9a';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                child: SingleChildScrollView(
                    child: ListBody(
                        children: <Widget>[
                          TextField(
                            controller: publicKeyTxt,
                            onChanged: (value) {
                              setState(() {
                                geideaPublicKey = value;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Public Key',
                              labelText: 'Public Key',
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(1.0)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: apiPasswordTxt,
                            onChanged: (value) {
                              setState(() {
                                geideaApiPassword = value;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Api Password',
                              labelText: 'Api Password',
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(1.0)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: _getPlatformButton(
                                      'Checkout Flow',
                                          () => _handleCheckout(context),
                                      (geideaApiPassword != '' && geideaPublicKey != '') ?  true : false
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: _getPlatformButton(
                                      'API Flow',
                                          () => _handleApi(context),
                                      (geideaApiPassword != '' && geideaPublicKey != '') ?  true : false
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                    )
                )
            )
        )
    );
  }
  _handleCheckout(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckoutFlow(geideaPublicKey, geideaApiPassword)),
    );
  }

  _handleApi(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApiFlow(geideaPublicKey, geideaApiPassword)),
    );
  }

  Widget _getPlatformButton(String string, Function() function, bool active) {
    // is still in progress
    Widget widget;
    if (Platform.isIOS) {
      widget = CupertinoButton(
        onPressed: function,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        color: active? CupertinoColors.activeBlue : CupertinoColors.inactiveGray,
        child: Text(
          string,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      widget = ElevatedButton(
        onPressed: active? function : null,
        child: Text(
          string.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
        style: ButtonStyle(
            backgroundColor: active? MaterialStateProperty.all(Colors.lightBlue) : MaterialStateProperty.all(Colors.grey)),
      );
    }
    return widget;
  }
}


//yehyâaaaaa
// class Tesstt extends StatelessWidget {
//   const Tesstt({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           Order order = await OrderApies.orderApies.createOrder2(payment_method: 'bacs',
//               payment_method_title: "Direct Bank Transfer",
//               firstName: "bawaseem",
//               lastName: "shawwa",
//               addressOne: "969 Market",
//               addressTwo: "",
//               city:"San Francisco",
//               country: "US",
//               state:"CA",
//               postcode:  "94103",
//               email: "john.doe@example.com",
//               phone: "(555) 555-5555",
//               total: '500',
//               product_id: 1023,
//               quantity: 1);
//           print(order);
//         },
//       ),
//     );
//   }
// }

