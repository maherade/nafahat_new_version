import 'package:lottie/lottie.dart';
import 'package:perfume_store_mobile_app/controller/cart_controller.dart';
import 'package:perfume_store_mobile_app/view/bottom_nav_screens/screens/nav_bar_screen.dart';
import 'package:perfume_store_mobile_app/view/cart/screen/cart_screen.dart';
import 'package:perfume_store_mobile_app/view/my_order/screen/my_order_screen.dart';

import '../../controller/app_controller.dart';
import '../../services/app_imports.dart';
import '../../services/sp_helper.dart';
import '../auth/screens/login_screen.dart';

class CustomDialog {
  CustomDialog._();

  static CustomDialog customDialog = CustomDialog._();

  showCartDialog() {
    Get.defaultDialog(
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomText(
            "add_successful_to_cart_value".tr,
            fontSize: 16,
            color: AppColors.primaryColor,
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 20,
            thickness: 2,
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: CustomText(
                    "continue_buy_value".tr,
                    fontSize: 14.sp,
                  ),
                ),
                const VerticalDivider(width: 20, thickness: 2),
                GetBuilder<AppController>(
                  builder: (controller) {
                    return TextButton(
                      onPressed: () {
                        Get.back();
                        Get.to(() => const CartScreen());
                      },
                      child: CustomText(
                        "go_to_cart_value".tr,
                        fontSize: 14.sp,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showDeleteAccountDialog() {
    Get.defaultDialog(
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomText(
            "are_you_sure_delete_account_value".tr,
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            "deleted_dialog_value".tr,
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 20,
            thickness: 2,
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    SPHelper.spHelper.removeToken();
                    Get.offAll(() => const LoginScreen());
                  },
                  child: CustomText(
                    "delete_account_value".tr,
                    fontSize: 14.sp,
                    color: Colors.red,
                  ),
                ),
                const VerticalDivider(width: 20, thickness: 2),
                GetBuilder<AppController>(
                  init: AppController(),
                  builder: (controller) {
                    return TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: CustomText(
                        "cancel_value".tr,
                        fontSize: 14.sp,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showOrderDoneDialog() {
    Get.defaultDialog(
      titleStyle: const TextStyle(fontSize: 0),
      content: GetBuilder<CartController>(
        init: CartController(),
        builder: (cart) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //   child: Row(
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           // cart.clear();
              //           Get.back();
              //         },
              //         child: Icon(Icons.close),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: OverflowBox(
                  minHeight: 170,
                  maxHeight: 170,
                  child: Lottie.asset(
                    'assets/order_complete.json',
                    animate: true,
                    repeat: false,
                    fit: BoxFit
                        .contain, // fit the animation within the container
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomText(
                "your_order_complete_value".tr,
                fontSize: 16,
                color: const Color(0xff30bb3a),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 20,
                thickness: 2,
              ),
              GetBuilder<AppController>(
                init: AppController(),
                builder: (controller) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            cart.clear();
                            controller.setIndexScreen(0);
                            Get.offAll(const NavBarScreen());
                          },
                          child: CustomText(
                            "go_home_value".tr,
                            fontSize: 13.sp,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                            Get.off(const MyOrderScreen());
                            cart.clear();
                          },
                          child: CustomText(
                            "go_order_screen_value".tr,
                            fontSize: 13.sp,
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  showCancelOrderDialog({VoidCallback? onTap}) {
    Get.defaultDialog(
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            child: OverflowBox(
              minHeight: 50,
              maxHeight: 50,
              child: Lottie.asset(
                'assets/cancel.json',
                animate: true,
                repeat: false,
                fit: BoxFit.contain, // fit the animation within the container
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomText(
            "are_you_sure_cancel_order_value".tr,
            fontSize: 16,
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 20,
            thickness: 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: CustomText(
                    "back_value".tr,
                    fontSize: 14.sp,
                  ),
                ),
                TextButton(
                  onPressed: onTap,
                  child: CustomText(
                    "cancel_order_value".tr,
                    fontSize: 14.sp,
                    color: const Color(0xffd8322c),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  showConfirmReOrderDialog({VoidCallback? onTap}) {
    Get.defaultDialog(
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomText(
            "repeat_order_value".tr,
            fontSize: 16,
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 20,
            thickness: 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: CustomText(
                    "back_value".tr,
                    fontSize: 14.sp,
                  ),
                ),
                TextButton(
                  onPressed: onTap,
                  child: CustomText(
                    "re_order_value".tr,
                    fontSize: 14.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  showConfirmSendMessageDialog({VoidCallback? onTap, String? phone}) {
    Get.defaultDialog(
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomText(
            "${"send_message_value".tr} $phone",
            fontSize: 16,
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 20,
            thickness: 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: CustomText(
                    "back_value".tr,
                    fontSize: 14.sp,
                  ),
                ),
                TextButton(
                  onPressed: onTap,
                  child: CustomText(
                    "send_value".tr,
                    fontSize: 14.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
