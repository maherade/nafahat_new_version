import 'dart:convert';

import '../../../apies/auth_apies.dart';
import '../../../apies/product_apies.dart';
import '../../../controller/app_controller.dart';
import '../../../model/decode_token_response.dart';
import '../../../services/app_imports.dart';
import '../../../services/sp_helper.dart';
import '../widget/custom_nav_bottom.dart';
import 'category_screen.dart';
import 'gift_screen.dart';
import 'home_screen.dart';
import 'my_account.dart';
import 'show_all_brand_screen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String decryptToken(token) {
    final encodedPayload = token.split('.')[1];
    final payloadData =
        utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    debugPrint(payloadData);
    final payload = DecodeTokenResponse.fromJson(jsonDecode(payloadData));
    return payload.data!.user!.id!;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SPHelper.spHelper.getToken() != null
          ? AuthApis.authApis.getCustomerInformation(
              decryptToken(SPHelper.spHelper.getToken()),
            )
          : debugPrint('null Token');

      ProductApies.productApies.getAds();
      ProductApies.productApies.getFamousBrandAds();
    });
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
          bottomNavigationBar: CustomNavBottom(),
        );
      },
    );
  }
}

class PageNav {
  static List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    const CategoryScreen(),
    ShowAllBrandScreen(),
    const GiftScreen(),
    const MyAccount(),
  ];
}
