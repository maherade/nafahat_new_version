

import 'package:perfume_store_mobile_app/view/bottom_nav_screens/screens/nav_bar_screen.dart';

import '../../../controller/app_controller.dart';
import '../../../services/app_imports.dart';

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
              "تمت إضافة المنتج إلى السلة",fontSize: 16,color: Colors.green,),
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
}