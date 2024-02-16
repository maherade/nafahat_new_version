import 'package:flutter_svg/svg.dart';
import 'package:perfume_store_mobile_app/controller/favourite_controller.dart';
import 'package:perfume_store_mobile_app/view/auth/screens/login_screen.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_dialog.dart';

import '../../../controller/cart_controller.dart';
import '../../../services/app_imports.dart';
import '../../../services/sp_helper.dart';
import '../../custom_widget/custom_rate_write_bar.dart';

class PerfumeProductItem extends StatelessWidget {
  final String? id;
  final String? imgUrl;
  final String? brandName;
  final String? perfumeName;
  final double? perfumeRate;
  final String? rateCount;
  final String? priceBeforeDiscount;
  final String? priceAfterDiscount;
  final VoidCallback? onTapBuy;
  final List<dynamic>? variations;

  const PerfumeProductItem({
    super.key,
    required this.id,
    this.imgUrl,
    this.brandName,
    this.perfumeName,
    this.perfumeRate,
    this.rateCount,
    this.priceBeforeDiscount,
    this.priceAfterDiscount,
    this.onTapBuy,
    this.variations,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder<FavoriteController>(
          init: FavoriteController(),
          builder: (favourite) {
            return Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                GestureDetector(
                  onTap: onTapBuy,
                  child: Container(
                    width: 162.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.greyBorder, width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CachedNetworkImageShare(
                                urlImage: imgUrl,
                                fit: BoxFit.contain,
                                heigthNumber: 100.h,
                                widthNumber: 130.w,
                                borderRadious: 10.r,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'العطور',
                              color: AppColors.grey.withOpacity(.5),
                              fontSize: 14.sp,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.greyBorder,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  const Image(
                                    image: AssetImage('assets/images/fire.png'),
                                  ),
                                  const SizedBox(width: 5,),
                                  CustomText(
                                    'الاكثر مبيعا',
                                    fontSize: 11.sp,
                                    color: AppColors.grey,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),

                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Expanded(
                        //       child: SizedBox(
                        //         height: 120.h,
                        //         child: FadeInImage.memoryNetwork(
                        //           image: imgUrl ?? '',
                        //           placeholder: kTransparentImage,
                        //           imageCacheHeight: 200,
                        //           imageCacheWidth: 200,
                        //           fit: BoxFit.fill,
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                          SizedBox(
                          height: 10.h,
                        ),
                        CustomText(
                          brandName,
                          color: AppColors.itemGrey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),

                        CustomText(
                          perfumeName,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        // Rate
                        Row(
                          children: [
                            CustomRateRead(
                              size: 20.sp,
                              rate: perfumeRate,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            CustomText(
                              rateCount,
                              color: AppColors.itemGrey,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        // Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Row(
                              children: [
                                CustomText(
                                  priceAfterDiscount,
                                  color: AppColors.greenText,
                                  fontSize: 14.sp,
                                ),
                                CustomText(
                                  'sar_value'.tr,
                                  color: AppColors.greenText,
                                  fontSize: 14.sp,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CustomText(
                                  priceBeforeDiscount,
                                  color: AppColors.grey,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.normal,
                                  underline: true,
                                ),
                                CustomText(
                                  'sar_value'.tr,
                                  color: AppColors.grey,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // discount
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.greyContainer,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColors.primaryColor,
                          )
                      ),
                      child: Row(
                        children: [
                          CustomText(
                            'خصم 50 %',
                            fontSize: 11.sp,
                            color: AppColors.primaryColor,
                          )
                        ],
                      ),
                    ),

                    SizedBox(width: 35.h,),

                    GestureDetector(
                      onTap: () {
                        if (SPHelper.spHelper.getToken() == null) {
                          Get.offAll(() => const LoginScreen());
                        } else {
                          if (favourite.items.containsKey(id)) {
                            bool removed = favourite.removeItem(id!);
                            if (removed) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(' تمت الحذف من المفضلة بنجاح'),
                                  duration: Duration(milliseconds: 300),
                                  backgroundColor: AppColors.primaryColor,
                                ),
                              );
                            }
                          } else {
                            bool added = favourite.addItem(
                              brandName: brandName,
                              imgUrl: imgUrl,
                              pdtid: id,
                              perfumeName: perfumeName,
                              perfumeRate: double.parse(rateCount ?? '0.0'),
                              priceAfterDiscount: priceAfterDiscount,
                              priceBeforeDiscount: priceBeforeDiscount,
                              rateCount: rateCount,
                            );
                            if (added) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(' تمت الإضافة إلى المفضلة بنجاح'),
                                  duration: Duration(milliseconds: 300),
                                  backgroundColor: AppColors.primaryColor,
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: favourite.items.containsKey(id)
                            ? const Icon(
                                Icons.favorite_outlined,
                                color: Colors.redAccent,
                              )
                            : const Icon(Icons.favorite_border,color: AppColors.grey,),
                      ),
                    ),

                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
