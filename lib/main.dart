import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:perfume_store_mobile_app/apies/order_apies.dart';
import 'package:perfume_store_mobile_app/services/Settingss.dart';
import 'package:perfume_store_mobile_app/services/sp_helper.dart';
import 'package:perfume_store_mobile_app/view/bottom_nav_screens/screens/nav_bar_screen.dart';
import 'package:perfume_store_mobile_app/view/help_and_support/screen/help_and_support_screen.dart';

import 'controller/app_controller.dart';
import 'controller/auth_controller.dart';
import 'controller/brand_controller.dart';
import 'controller/cart_controller.dart';
import 'controller/category_controller.dart';
import 'controller/order_controller.dart';
import 'controller/posts_controller.dart';
import 'controller/product_controller.dart';
import 'controller/review_controller.dart';
import 'services/app_imports.dart';
import 'services/firebase_notification.dart';
import 'view/auth/screens/login_screen.dart';
import 'view/splash/screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    super.initState();
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

