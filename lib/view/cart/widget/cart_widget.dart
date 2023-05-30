import 'package:perfume_store_mobile_app/controller/app_controller.dart';
import 'package:perfume_store_mobile_app/controller/cart_controller.dart';

import '../../../services/app_imports.dart';
import '../../custom_widget/custom_button.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      init: AppController(),
      builder: (appController) {
        return GetBuilder<CartController>(
          init: CartController(),
          builder: (cartController) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.greyBorder)),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                        color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'total_price_value'.tr,
                          fontSize: 16.sp,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomText(
                          'you_have_value'.tr +
                              '${cartController.items.length}' +
                              'item_in_cart_value'.tr,
                          fontSize: 14.sp,
                          color: AppColors.hintGrey,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  CustomButton(
                    onTap: () {
                      if (cartController.items.isNotEmpty) {
                        appController.updateCurrentStepperIndex(1);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('please_add_item_in_cart_value'.tr),
                          ),
                        );
                      }
                    },
                    height: 40.h,
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          'confirm_value'.tr,
                          fontWeight: FontWeight.normal,
                          color: AppColors.whiteColor,
                          fontSize: 16.sp,
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: AppColors.whiteColor,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomButton(
                    onTap: () {
                      appController.setIndexScreen(0);
                    },
                    height: 40.h,
                    title: 'continue_buy_process_value'.tr,
                    titleColor: AppColors.hintGrey,
                    color: AppColors.whiteColor,
                    borderColor: AppColors.hintGrey,
                  ),
                ],
              ),
            );
          },

        );
      },

    );
  }
}
