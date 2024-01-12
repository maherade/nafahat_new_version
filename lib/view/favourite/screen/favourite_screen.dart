import 'package:perfume_store_mobile_app/controller/app_controller.dart';
import 'package:perfume_store_mobile_app/controller/favourite_controller.dart';
import 'package:perfume_store_mobile_app/view/perfume_details/screens/perfume_details_screen.dart';
import 'package:perfume_store_mobile_app/view/search/screen/search_screen.dart';

import '../../../services/app_imports.dart';
import '../../bottom_nav_screens/screens/nav_bar_screen.dart';
import '../../bottom_nav_screens/widget/perfume_product_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size dSize = MediaQuery.of(context).size;

    return Scaffold(
      body: GetBuilder<FavoriteController>(
        init: FavoriteController(),
        builder: (favorite) {
          favorite.loadItemsFromPrefs();

          return Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [

                    const Image(
                      image: AssetImage(
                        'assets/images/Notification.png',
                      ),
                    ),


                    Spacer(),

                    CustomText('favourite_value'.tr,
                        fontSize: 17.sp,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.normal,
                    ),

                    Spacer(),

                    Container(
                      height: 45.h,
                      width: 45.w,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: favorite.items.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/no_favourite.png'),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomText(
                            'no_favourite_value'.tr,
                            fontSize: 15.sp,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomText(
                            'you_dont_have_favorite_yet_value'.tr,
                            fontSize: 14.sp,
                            color: AppColors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GetBuilder<AppController>(
                            init: AppController(),
                            builder: (controller) {
                              return GestureDetector(
                                onTap: () {
                                  controller.setIndexScreen(0);
                                  Get.offAll(const NavBarScreen());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: CustomText(
                                    'back_to_store_value'.tr,
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: GridView.builder(
                          itemCount: favorite.items.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: dSize.width > 400 &&
                                    dSize.width <= 500
                                ? 0.6
                                : dSize.width > 500 && dSize.width <= 600
                                    ? 0.7.h
                                    : dSize.width > 600 && dSize.width <= 700
                                        ? 0.8.h
                                        : dSize.width > 700 &&
                                                dSize.width <= 800
                                            ? 0.9.h
                                            : dSize.width > 800 &&
                                                    dSize.width <= 900
                                                ? 1
                                                : 1.1,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 15,
                          ),
                          itemBuilder: (_, index) {
                            final FavouriteItem item =
                                favorite.items.values.elementAt(index);

                            return PerfumeProductItem(
                              id: item.id,
                              imgUrl: item.imgUrl,
                              brandName: item.brandName,
                              perfumeName: item.perfumeName,
                              perfumeRate:
                                  double.parse(item.rateCount ?? '0.0'),
                              rateCount: item.rateCount ?? '0',
                              priceBeforeDiscount:
                                  item.priceBeforeDiscount ?? '',
                              priceAfterDiscount: item.priceAfterDiscount ?? '',
                              onTapBuy: () {
                                Get.to(
                                  () => PerfumeDetailsScreen(
                                    productId: item.id,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
              )
            ],
          );
        },
      ),
    );
  }
}
