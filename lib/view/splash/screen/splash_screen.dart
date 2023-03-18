


import '../../../services/app_imports.dart';
import '../../../services/sp_helper.dart';
import '../../auth/screens/login_screen.dart';
import '../../bottom_nav_screens/screens/nav_bar_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var delay =const Duration(seconds: 3);

    Future.delayed(delay, () {
      Get.to(()=>NavBarScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:const Color(0xfff7f7f7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png',fit: BoxFit.cover,),
            SizedBox(height: 30.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText('نفحــــــــــات',fontSize: 30.sp,fontWeight: FontWeight.bold,),
                CustomText('NAFAHAT',fontSize: 30.sp,fontWeight: FontWeight.bold,),
              ],
            ),
          ],
        ),
      )
    );
  }
}
