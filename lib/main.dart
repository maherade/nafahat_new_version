import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:perfume_store_mobile_app/services/sp_helper.dart';
import 'package:perfume_store_mobile_app/view/help_and_support/screen/help_and_support_screen.dart';

import 'controller/app_controller.dart';
import 'services/app_imports.dart';
import 'view/auth/screens/login_screen.dart';
import 'view/bottom_nav_screens/screens/nav_bar_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPHelper.spHelper.initSharedPrefrences();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryColor,
  ));

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
            return widget!;
          },
          supportedLocales: const [
            Locale('ar', 'AE'),
          ],
          home: HelpAndSupportScreen(),
        );
      },
    );
  }
}
