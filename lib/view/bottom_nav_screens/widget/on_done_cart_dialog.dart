

import 'package:perfume_store_mobile_app/view/bottom_nav_screens/screens/nav_bar_screen.dart';

import '../../../controller/app_controller.dart';
import '../../../services/app_imports.dart';
import '../../../services/sp_helper.dart';
import '../../auth/screens/login_screen.dart';

class OnDoneCartDialog {
  OnDoneCartDialog._();

  static OnDoneCartDialog onDoneCartDialog = OnDoneCartDialog._();
  showCartDialog () {
    Get.defaultDialog(
        titleStyle: TextStyle(fontSize: 0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  GestureDetector(onTap: (){Get.back();},child: Icon(Icons.close),),
                ],
              ),
            ),
            SizedBox(height: 20,),

            CustomText(
              "تمت إضافة المنتج إلى السلة",fontSize: 16,color: AppColors.primaryColor,),
            SizedBox(height: 20,),

            Divider(height: 20,thickness: 2,),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(NavBarScreen());
                    },
                    child: CustomText(
                      "متابعة الشراء",
                      fontSize: 14.sp,
                    ),
                  ),
                  VerticalDivider(width: 20,thickness: 2),
                  GetBuilder<AppController>(
                    init: AppController(),
                    builder: (controller){
                      return  TextButton(
                        onPressed: () {
                          controller.setIndexScreen(4);
                          Get.to(NavBarScreen());
                        },
                        child: CustomText(
                          "الذهاب للسلة",
                          fontSize: 14.sp,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
  showDeleteAccountDialog () {
    Get.defaultDialog(
        titleStyle: TextStyle(fontSize: 0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  GestureDetector(onTap: (){Get.back();},child: Icon(Icons.close),),
                ],
              ),
            ),
            SizedBox(height: 20,),

            CustomText(
              "هل أنت متأكد من حذف الحساب؟",fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold,),
            CustomText(
              "سيتم حذف حسابك خلال ٣٠ يوم إذا لم تقم بتسجيل الدخول مرة أخرى",fontSize: 13,color: Colors.black,fontWeight: FontWeight.normal,),
            SizedBox(height: 20,),

            Divider(height: 20,thickness: 2,),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      SPHelper.spHelper.removeToken();
                      Get.offAll(() => LoginScreen());
                    },
                    child: CustomText(
                      "حذف الحساب",
                      fontSize: 14.sp,
                      color: Colors.red,
                    ),
                  ),
                  VerticalDivider(width: 20,thickness: 2),
                  GetBuilder<AppController>(
                    init: AppController(),
                    builder: (controller){
                      return  TextButton(
                        onPressed: () {
                         Get.back();
                        },
                        child: CustomText(
                          "إلغاء",
                          fontSize: 14.sp,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}