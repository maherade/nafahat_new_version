
import '../../../controller/app_controller.dart';
import '../../../services/app_imports.dart';
import '../widget/custom_nav_bottom.dart';
import 'cart_screen.dart';
import 'gift_screen.dart';
import 'home_screen.dart';
import 'product_screen.dart';
import 'wholesale_screen.dart';

class NavBarScreen extends StatelessWidget {
   NavBarScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<AppController>(
      init: AppController(),
      builder: (controller) {
        return Scaffold(
            key: _scaffoldKey,
            body: PageNav.widgetOptions[controller.indexScreen],
            bottomNavigationBar: CustomNavBottom());
      },
    );
  }
}
class PageNav {
  static List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    ProductScreen(),
    WholeSalesScreen(),
    GiftScreen(),
    CartScreen(),

  ];
}