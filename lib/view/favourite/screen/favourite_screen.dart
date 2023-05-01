import 'package:perfume_store_mobile_app/controller/app_controller.dart';
import 'package:perfume_store_mobile_app/controller/favourite_controller.dart';
import 'package:perfume_store_mobile_app/view/perfume_details/screens/perfume_details_screen.dart';
import 'package:perfume_store_mobile_app/view/search/screen/search_screen.dart';

import '../../../services/app_imports.dart';
import '../../bottom_nav_screens/screens/nav_bar_screen.dart';
import '../../bottom_nav_screens/widget/perfume_product_item.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FavouriteController>(
        init: FavouriteController(),
        builder: (favourite) {
           favourite.loadItemsFromPrefs();

          return Column(
            children: [
              SizedBox(height: 60.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: Row(
                  children: [
                    IconButton(onPressed: (){Get.back();},icon: Icon(Icons.arrow_back)),
                    CustomText('favourite_value'.tr,fontSize: 15.sp,),
                    Spacer(),
                    GestureDetector(onTap: (){
                      Get.to(()=>SearchScreen());
                    },child: Icon(Icons.search)),
                    SizedBox(width: 20.w,)
                  ],
                ),
              ),
             Expanded(child:  favourite.items.isEmpty
                 ? Column(
               mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Image.asset('assets/images/no_favourite.png'),
                     SizedBox(height: 10.h,),
                     CustomText(
               'no_favourite_value'.tr,
               fontSize: 15.sp,
             ),
                     SizedBox(height: 10.h,),
                     CustomText(
                       'you_dont_have_favorite_yet_value'.tr,
                       fontSize: 14.sp,
                       color: AppColors.grey,
                       fontWeight: FontWeight.normal,
                     ),
                     SizedBox(height: 10.h,),
                   GetBuilder<AppController>(
                     init: AppController(),
                     builder: (controller) {
                     return  GestureDetector(
                       onTap: (){
                         controller.setIndexScreen(0);
                         Get.offAll(NavBarScreen());
                       },
                       child: Container(
                         padding: EdgeInsets.all(10.w),
                         decoration: BoxDecoration(
                             color: AppColors.primaryColor,
                             borderRadius: BorderRadius.circular(5.r)
                         ),
                         child: CustomText(
                           'back_to_store_value'.tr,
                           color: Colors.white,
                           fontSize: 14.sp,
                         ),
                       ),
                     );
                   },)
                   ],
                 )
                 :  Padding(
                   padding:  EdgeInsets.symmetric(horizontal: 18.0),
                   child: GridView.builder(
               itemCount: favourite.items.length,
               gridDelegate:
               SliverGridDelegateWithFixedCrossAxisCount(
                   childAspectRatio: 0.45.h,
                   crossAxisCount: 2,
                   crossAxisSpacing: 11.w,
                   mainAxisSpacing: 16.h,
               ),
               itemBuilder: (_, index) {
                   final FavouriteItem item = favourite.items.values.elementAt(index);

                   return PerfumeProductItem(
                     id: item.id,
                     imgUrl: item.imgUrl,
                     brandName: item.brandName,
                     perfumeName: item.perfumeName,
                     perfumeRate: double.parse(item.rateCount ?? '0.0'),
                     rateCount: item.rateCount ?? '0',
                     priceBeforeDiscount: item.priceBeforeDiscount ?? '',
                     priceAfterDiscount:item.priceAfterDiscount ?? '',
                    onTapBuy: (){
                       Get.to(()=>PerfumeDetailsScreen(productId: item.id,));
                    },
                   );
               },
             ),
                 ))
            ],
          );
        },
      ),
    );
  }
}
