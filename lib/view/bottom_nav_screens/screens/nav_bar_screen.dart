import '../../../controller/app_controller.dart';
import '../../../services/app_imports.dart';
import '../../send_request/screen/send_request_screen.dart';
import '../widget/custom_nav_bottom.dart';
import 'cart_screen.dart';
import 'gift_screen.dart';
import 'home_screen.dart';
import 'product_screen.dart';

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
    SendRequestScreen(),
    GiftScreen(),
    CartScreen(),
  ];
}
