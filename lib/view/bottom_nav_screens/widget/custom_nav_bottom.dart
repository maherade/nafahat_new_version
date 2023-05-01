import 'package:flutter_svg/flutter_svg.dart';

import '../../../controller/app_controller.dart';
import '../../../services/app_imports.dart';

class CustomNavBottom extends StatefulWidget {
  @override
  State<CustomNavBottom> createState() => _CustomNavBottomState();
}

class _CustomNavBottomState extends State<CustomNavBottom> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      init: AppController(),
      builder: (controller) => SizedBox(
        height: 85.h,
        child: BottomNavigationBar(
          elevation: 0,
          // backgroundColor: Colors.white,
          currentIndex: controller.indexScreen,
          onTap: (value) async {
            controller.setIndexScreen(value);
            if (value == 0) {
            } else if (value == 1) {
            } else if (value == 2) {
            } else if (value == 3) {
            } else if (value == 4) {
            } else if (value == 5) {}
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
                  CustomText(
                    'bottom_nav_home_value'.tr,
                    fontSize: 12.sp,
                    color: AppColors.greenText,
                  )
                ],
              ),
              icon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/home.svg',
                    color: AppColors.blackColor,
                    fit: BoxFit.contain,
                  ),
                  CustomText(
                    'bottom_nav_home_value'.tr,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  )
                ],
              ),
              label: "",
            ),
//------------------------- Nav 2 -------------------------------------
            BottomNavigationBarItem(
              activeIcon: Column(
                children: [
                  Image.asset(
                    'assets/images/category.png',
                    color: AppColors.green,
                    fit: BoxFit.contain,
                    height: 24.h,
                    width: 24.w,
                  ),
                  CustomText(
                    'bottom_nav_category_value'.tr,
                    fontSize: 12.sp,
                    color: AppColors.green,
                  )
                ],
              ),
              icon: Column(
                children: [
                  Image.asset(
                    'assets/images/category.png',
                    color: AppColors.blackColor,
                    fit: BoxFit.contain,
                    height: 24.h,
                    width: 24.w,
                  ),
                  CustomText(
                    'bottom_nav_category_value'.tr,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.blackColor,

                  )
                ],
              ),
              label: "",
            ),
//------------------------- Nav 3 -------------------------------------
            BottomNavigationBarItem(
              activeIcon: Column(
                children: [
                  Image.asset(
                    'assets/images/brand.png',
                    color: AppColors.blackColor,
                    fit: BoxFit.contain,
                    height: 25.h,
                    width: 25.w,
                  ),
                  CustomText(
                    'bottom_nav_brand_value'.tr,
                    fontSize: 12.sp,
                    color: AppColors.greenText,
                  )
                ],
              ),
              icon: Column(
                children: [
                  Image.asset(
                    'assets/images/brand.png',
                    color: AppColors.blackColor,
                    fit: BoxFit.contain,
                    height: 25.h,
                    width: 25.w,
                  ),
                  CustomText(
                    'bottom_nav_brand_value'.tr,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  )
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
                  CustomText(
                    'bottom_nav_gift_package_value'.tr,
                    fontSize: 12.sp,
                    color: AppColors.greenText,
                  )
                ],
              ),
              icon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/gift.svg',
                    color: AppColors.blackColor,
                    fit: BoxFit.contain,
                  ),
                  CustomText(
                    'bottom_nav_gift_package_value'.tr,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  )
                ],
              ),
              label: "",
            ),

//------------------------- Nav 6 -------------------------------------
            BottomNavigationBarItem(
              activeIcon: Column(
                children: [
                  Image.asset(
                    'assets/images/profilee.png',
                    color: AppColors.greenText,
                    fit: BoxFit.contain,
                  ),
                  CustomText(
                    'bottom_nav_account_value'.tr,
                    fontSize: 12.sp,
                    color: AppColors.greenText,
                  )
                ],
              ),
              icon: Column(
                children: [
                  Image.asset(
                    'assets/images/profilee.png',
                    color: AppColors.blackColor,
                    fit: BoxFit.contain,
                  ),
                  CustomText(
                    'bottom_nav_account_value'.tr,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  )
                ],
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
