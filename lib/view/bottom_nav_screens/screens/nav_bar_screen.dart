import 'package:perfume_store_mobile_app/apies/brand_apies.dart';

import '../../../apies/category_apies.dart';
import '../../../apies/product_apies.dart';
import '../../../controller/app_controller.dart';
import '../../../services/app_imports.dart';
import '../../drawer/screen/drawer_screen.dart';
import '../../send_request/screen/send_request_screen.dart';
import '../widget/custom_nav_bottom.dart';
import 'cart_screen.dart';
import 'gift_screen.dart';
import 'home_screen.dart';
import 'product_screen.dart';
import 'wholesale_screen.dart';

class NavBarScreen extends StatefulWidget {
  NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
@override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      init: AppController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
            key: _scaffoldKey,
            // drawer: DrawerScreen(),
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   elevation: 0,
            //   foregroundColor: Colors.black,
            // ),
            body: PageNav.widgetOptions[controller.indexScreen],
            bottomNavigationBar: CustomNavBottom(controller.inAppWebViewController));
      },
    );
  }
}

class PageNav {
  static List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    ProductScreen(),
    WholeSaleScreen(),
    GiftScreen(),
    CartScreen(),
  ];
}
