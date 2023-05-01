import 'dart:math';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:perfume_store_mobile_app/controller/favourite_controller.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_dialog.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../controller/cart_controller.dart';
import '../../../services/app_imports.dart';
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

 const PerfumeProductItem(
      {super.key,
      required this.id,
      this.imgUrl,
      this.brandName,
      this.perfumeName,
      this.perfumeRate,
      this.rateCount,
      this.priceBeforeDiscount,
      this.priceAfterDiscount,
      this.onTapBuy});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder<FavouriteController>(
          init: FavouriteController(),
          builder: (favourite) {
            return Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                GestureDetector(
                  onTap: onTapBuy,
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    width: 162.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.greyBorder, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Image.network(imgUrl??'',height: 120.h,width: 82.w,fit: BoxFit.contain,)
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CachedNetworkImageShare(
                                urlImage: imgUrl,
                                fit: BoxFit.contain,
                                heigthNumber: 120.h,
                                widthNumber: double.infinity,
                                borderRadious: 14.r,
                              ),
                            ),
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
                          height: 17.h,
                        ),
                        CustomText(
                          brandName,
                          color: AppColors.itemGrey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        CustomText(
                          perfumeName,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          maxLines: 2,
                        ),
                        Row(
                          children: [
                            CustomRateRead(
                              size: 15.w,
                              rate: perfumeRate,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            CustomText(
                              rateCount,
                              color: AppColors.itemGrey,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomText(priceBeforeDiscount,
                                color: AppColors.priceBrownColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                                underline: true),
                            CustomText('sar_value'.tr,
                                color: AppColors.priceBrownColor, fontSize: 16.sp, fontWeight: FontWeight.normal),
                          ],
                        ),
                        Row(
                          children: [
                            CustomText(
                              priceAfterDiscount,
                              color: AppColors.greenText,
                              fontSize: 16.sp,
                            ),
                            CustomText(
                              'sar_value'.tr,
                              color: AppColors.greenText,
                              fontSize: 16.sp,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GetBuilder<CartController>(
                              init: CartController(),
                              builder: (cart) {
                                return GestureDetector(
                                  onTap: () {
                                    bool added = cart.addItem(
                                      imgurl: imgUrl ?? '',
                                      name: perfumeName ?? '',
                                      price: double.parse(priceAfterDiscount ?? '0.0'),
                                      quantitiy: 1,
                                      pdtid: id ?? '',
                                    );
                                    if (added) {
                                      CustomDialog.customDialog.showCartDialog();
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    'assets/svg/buy.svg',
                                    fit: BoxFit.contain,
                                  ),
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (favourite.items.containsKey(id)) {
                      bool removed = favourite.removeItem(id!);
                      if (removed) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(' تمت الحذف من المفضلة بنجاح'),
                            duration: Duration(milliseconds: 300),
                            backgroundColor: AppColors.primaryColor));
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
                          rateCount: rateCount);
                      if (added) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(' تمت الإضافة إلى المفضلة بنجاح'),
                          duration: Duration(milliseconds: 300),
                          backgroundColor: AppColors.primaryColor,
                        ));
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: favourite.items.containsKey(id)
                        ? Icon(
                            Icons.favorite_outlined,
                            color: Colors.redAccent,
                          )
                        : Icon(Icons.favorite_border),
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
