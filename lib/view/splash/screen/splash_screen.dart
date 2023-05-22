


import '../../../apies/auth_apies.dart';
import '../../../apies/brand_apies.dart';
import '../../../apies/category_apies.dart';
import '../../../apies/posts_apies.dart';
import '../../../apies/product_apies.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // home screen request

      BrandApies.brandApies.getBrandData();
      CategoryApies.categoryApies.getCategoryData('0');
      PostsApies.postsApies.getPostsData();

      ProductApies.productApies.getGiftPackageProductData(pageNumber: '1');
      ProductApies.productApies.getFamousProductData(category: "27");
      ProductApies.productApies.getWholeSaleProductData(onSale: true);
      ProductApies.productApies.getOffersProductData();
      ProductApies.productApies.getLessThanPriceProductResponseData(order: 'asc', orderBy: 'price', lessThan: '20', pageNumber: '1');
      ProductApies.productApies.getCareProductData( pageNumber: '1');
      ProductApies.productApies.getRecentlyAddedProductData(pageNumber: '1');
      //
      ProductApies.productApies.getRamadanProductData();
      ProductApies.productApies.getLensesProductData();
      ProductApies.productApies.getRamadanOffersProductData();
      ProductApies.productApies.getTopMakeupProductData();
      ProductApies.productApies.getTopDevicesProductData();
      ProductApies.productApies.getTopNailsProductData();
      ProductApies.productApies.getTopPerfumeProductData();
      // category requests page
      // CategoryApies.categoryApies.getCategoryData('0');
      CategoryApies.categoryApies.getSubCategoryData('24');
      ProductApies.productApies.getProductData(pageNumber: '1', category: '27');
      // BrandApies.brandApies.getBrandData(categoryID: '24');
      // giftpackages page
      // ProductApies.productApies.getGiftPackageProductData(
      //   pageNumber: '1',
      // );
      ProductApies.productApies.getLastViewProduct();
      //brand Page
      // BrandApies.brandApies.getBrandData();

    });
    AuthApis.authApis.getAdminToken().then((value) {

      Get.offAll(()=>NavBarScreen());
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
