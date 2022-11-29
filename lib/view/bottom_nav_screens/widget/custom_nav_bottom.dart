


import 'package:flutter_svg/flutter_svg.dart';

import '../../../controller/app_controller.dart';
import '../../../services/app_imports.dart';

class CustomNavBottom extends StatelessWidget {
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
          onTap:(value){
            controller.setIndexScreen(value);
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
              activeIcon: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/cart.svg',
                    color: AppColors.greenText,
                    fit: BoxFit.contain,
                  ),
                  CustomText('السلة',fontSize: 12.sp,color: AppColors.greenText,)
                ],
              ),
              icon:  Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/cart.svg',
                    color: AppColors.blackColor,
                    fit: BoxFit.contain,
                  ),
                  CustomText('السلة',fontSize: 12.sp,fontWeight: FontWeight.normal,)
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
