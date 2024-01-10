import 'package:flutter_svg/flutter_svg.dart';

import '../../../controller/app_controller.dart';
import '../../../services/app_imports.dart';

class CustomNavBottom extends StatefulWidget {
  const CustomNavBottom({super.key});

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
                    color: AppColors.primaryColor,
                    fit: BoxFit.contain,
                  ),
                  CustomText(
                    'bottom_nav_home_value'.tr,
                    fontSize: 10.sp,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
              icon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/home.svg',
                    color: AppColors.grey,
                    fit: BoxFit.contain,
                  ),
                  CustomText(
                    'bottom_nav_home_value'.tr,
                    fontSize: 10.sp,
                    color: AppColors.grey,
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
                  SvgPicture.asset(
                    'assets/svg/cart.svg',
                    color: AppColors.primaryColor,
                    fit: BoxFit.contain,
                    height: 24.h,
                    width: 24.w,
                  ),
                  CustomText(
                    'cart'.tr,
                    fontSize: 10.sp,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
              icon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/cart.svg',
                    color: AppColors.grey,
                    fit: BoxFit.contain,
                    height: 24.h,
                    width: 24.w,
                  ),
                  CustomText(
                    'cart'.tr,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.grey,
                  )
                ],
              ),
              label: "",
            ),
//------------------------- Nav 3 -------------------------------------
            BottomNavigationBarItem(
              activeIcon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/love.svg',
                    color: AppColors.primaryColor,
                    fit: BoxFit.contain,
                    height: 25.h,
                    width: 25.w,
                  ),
                  CustomText(
                    'favourite_value'.tr,
                    fontSize: 10.sp,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
              icon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/love.svg',
                    color: AppColors.grey,
                    fit: BoxFit.contain,
                    height: 25.h,
                    width: 25.w,
                  ),
                  CustomText(
                    'favourite_value'.tr,
                    fontSize: 10.sp,
                    color: AppColors.grey,
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
                    'assets/svg/Search.svg',
                    color: AppColors.primaryColor,
                    fit: BoxFit.contain,
                  ),
                  CustomText(
                    'search'.tr,
                    fontSize: 10.sp,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
              icon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/Search.svg',
                    color: AppColors.grey,
                    fit: BoxFit.contain,
                  ),
                  CustomText(
                    'search'.tr,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.grey,

                  )
                ],
              ),
              label: "",
            ),

//------------------------- Nav 6 -------------------------------------
            BottomNavigationBarItem(
              activeIcon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/profile.svg',
                    color: AppColors.primaryColor,
                    fit: BoxFit.contain,
                  ),
                  CustomText(
                    'bottom_nav_account_value'.tr,
                    fontSize: 10.sp,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
              icon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/profile.svg',
                    color: AppColors.grey,
                    fit: BoxFit.contain,
                  ),
                  CustomText(
                    'bottom_nav_account_value'.tr,
                    fontSize: 10.sp,
                    color: AppColors.grey,
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
