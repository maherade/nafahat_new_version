


import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../controller/app_controller.dart';
import '../../../controller/cart_controller.dart';
import '../../../services/app_imports.dart';
import 'package:badges/badges.dart' as badges;

class CustomNavBottom extends StatefulWidget {
  @override
  State<CustomNavBottom> createState() => _CustomNavBottomState();
}

class _CustomNavBottomState extends State<CustomNavBottom> {
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      init: AppController(),
      builder: (controller) => SizedBox(
        height: 80.h,
        child: BottomNavigationBar(
          elevation: 0,
          // backgroundColor: Colors.white,
          currentIndex: controller.indexScreen,
          onTap:(value) async {
            controller.setIndexScreen(value);
            if(value == 0 ){

            }else if (value == 1){

            }
            else if (value == 2){

            }
          },
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: [
//------------------------- Nav 1 -------------------------------------
            BottomNavigationBarItem(
              activeIcon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/home.svg',
                    color: AppColors.greenText,
                    fit: BoxFit.contain,
                  ),
                  CustomText('الرئيسية',fontSize: 12.sp,color: AppColors.greenText,)
                ],
              ),
              icon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/home.svg',
                    color: AppColors.blackColor,
                    fit: BoxFit.contain,
                  ),
                  CustomText('الرئيسية',fontSize: 12.sp,fontWeight: FontWeight.normal,)
                ],
              ),
              label: "",
            ),
//------------------------- Nav 2 -------------------------------------
            BottomNavigationBarItem(
              activeIcon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/products.svg',
                    color: AppColors.greenText,
                    fit: BoxFit.contain,
                  ),
                  CustomText('المنتجات',fontSize: 12.sp,color: AppColors.greenText,)

                ],
              ),
              icon:  Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/products.svg',
                    color: AppColors.blackColor,
                    fit: BoxFit.contain,
                  ),
                  CustomText('المنتجات',fontSize: 12.sp,fontWeight: FontWeight.normal,)

                ],
              ),
              label: "",
            ),
//------------------------- Nav 3 -------------------------------------
            BottomNavigationBarItem(
              activeIcon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/wholesale.svg',
                    color: AppColors.greenText,
                    fit: BoxFit.contain,
                  ),
                  CustomText('البيع بالجملة',fontSize: 12.sp,color: AppColors.greenText,)
                ],
              ),
              icon:  Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/wholesale.svg',
                    color: AppColors.blackColor,
                    fit: BoxFit.contain,
                  ),
                  CustomText('البيع بالجملة',fontSize: 12.sp,fontWeight: FontWeight.normal,)
                ],
              ),
              label: "",
            ),
//------------------------- Nav 4 -------------------------------------
            BottomNavigationBarItem(
              activeIcon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/gift.svg',
                    color: AppColors.greenText,
                    fit: BoxFit.contain,
                  ),
                  CustomText('بكجات الهدايا',fontSize: 12.sp,color: AppColors.greenText,)
                ],
              ),
              icon:  Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/gift.svg',
                    color: AppColors.blackColor,
                    fit: BoxFit.contain,
                  ),
                  CustomText('بكجات الهدايا',fontSize: 12.sp,fontWeight: FontWeight.normal,)
                ],
              ),
              label: "",
            ),
//------------------------- Nav 5 -------------------------------------
            BottomNavigationBarItem(
              activeIcon: GetBuilder<CartController>(
                init: CartController(),
                builder: (controller) {
                  return badges.Badge(
                    showBadge: cartController.items.isNotEmpty ? true :false,
                    position: badges.BadgePosition.topEnd(),
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.circle,
                      borderRadius: BorderRadius.circular(12.r),
                      badgeColor: AppColors.primaryColor,
                    ),

                    badgeContent: CustomText(
                      controller.items.length.toString(),
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp,
                      textAlign: TextAlign.center,
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/cart.svg',
                          color: AppColors.greenText,
                          fit: BoxFit.contain,
                        ),
                        CustomText('السلة',fontSize: 12.sp,color: AppColors.greenText,)
                      ],
                    ),
                  );
                },
              ),
              icon:  GetBuilder<CartController>(
                init: CartController(),
                builder: (controller) {
                  return badges.Badge(
                    showBadge: cartController.items.isNotEmpty ? true :false,
                    position: badges.BadgePosition.topEnd(),
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.circle,
                      borderRadius: BorderRadius.circular(12.r),
                      badgeColor: AppColors.primaryColor,
                    ),

                    badgeContent: CustomText(
                      controller.items.length.toString(),
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp,
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/cart.svg',
                          color: AppColors.blackColor,
                          fit: BoxFit.contain,
                        ),
                        CustomText('السلة',fontSize: 12.sp,fontWeight: FontWeight.normal,)
                      ],
                    ),
                  );
                },
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
