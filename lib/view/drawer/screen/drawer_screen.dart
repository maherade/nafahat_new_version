

import '../../../services/app_imports.dart';
import '../../articles/screen/article_screen.dart';
import '../../help_and_support/screen/help_and_support_screen.dart';
import '../../send_request/screen/send_request_screen.dart';
import '../widget/drawer_item.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            SizedBox(
              height: 200.h,
            ),
            DrawerItem(
              title: 'المقالات',
              onTap: (){Get.to(()=>const ArticlesScreen());},
            ),
           DrawerItem(
             title: 'الأسئلة الشائعة',
             onTap: (){Get.to(()=>HelpAndSupportScreen());},
           ),
            DrawerItem(
             title: 'تواصل معنا',
              onTap: (){Get.to(()=>SendRequestScreen());},
           ),

          ],
        ),
      ),
    );
  }
}
