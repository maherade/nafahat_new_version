import 'package:perfume_store_mobile_app/controller/cart_controller.dart';

import '../../../model/product_detail_response.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/custom_rate_write_bar.dart';

class PerfumeDetailsItem extends StatefulWidget {
  final List? imgUrl;
  final List<Variations>? variations;
  final List<VariationsAttributes>? variationsAttributes;
  final String? brandName;
  final String? perfumeName;
  final double? perfumeRate;
  final String? rateCount;
  final String? priceBeforeDiscount;
  final String? priceAfterDiscount;
  final VoidCallback? onTapBrand;

  const PerfumeDetailsItem({
    super.key,
    this.imgUrl,
    this.variations,
    this.variationsAttributes,
    this.brandName,
    this.perfumeName,
    this.perfumeRate,
    this.rateCount,
    this.priceBeforeDiscount,
    this.priceAfterDiscount,
    this.onTapBrand,
  });

  @override
  State<PerfumeDetailsItem> createState() => _PerfumeDetailsItemState();
}

class _PerfumeDetailsItemState extends State<PerfumeDetailsItem> {
  CartController cartController = Get.find();
  int _current = 0;
  PageController _controller = PageController();

  setPrice() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartController.setVariations(widget.variations![0]);
    });
  }

  @override
  void initState() {
    widget.variations != null ? setPrice() : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 233.h,
              width: double.infinity,
              child: Stack(
                children: [
                  widget.variations != null
                      ? PageView.builder(
                          controller: _controller,
                          onPageChanged: (index) {
                            setState(() => _current = index);
                            controller.setVariations(widget.variations![index]);
                            debugPrint(
                                controller.variations?.variationId.toString());
                            // controller.setPriceBeforeDiscountVariations( widget.variations?[index].displayRegularPrice.toString());
                            // controller.setPriceAfterDiscountVariations( widget.variations?[index].displayPrice.toString());
                          },
                          itemCount: widget.variations?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: AppColors.whiteColor),
                              height: 233.h,
                              width: double.infinity,
                              child: CachedNetworkImageShare(
                                urlImage:
                                    widget.variations?[index].image?.url ?? '',
                                fit: BoxFit.contain,
                                heigthNumber: 233.h,
                                widthNumber: double.infinity,
                              ),
                            );
                          },
                        )
                      : PageView.builder(
                          controller: _controller,
                          onPageChanged: (index) {
                            setState(() => _current = index);
                          },
                          itemCount: widget.imgUrl?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: AppColors.whiteColor),
                              height: 233.h,
                              width: double.infinity,
                              child: CachedNetworkImageShare(
                                urlImage: widget.imgUrl?[index].src,
                                fit: BoxFit.contain,
                                heigthNumber: 233.h,
                                widthNumber: double.infinity,
                              ),
                            );
                          },
                        ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.w),
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 15.w,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: GestureDetector(
                      onTap: () {
                        _controller.previousPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.w),
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(),
                        ),
                        child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15.w,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            widget.variations != null
                ? SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                      itemCount: widget.variations?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller
                                    .setVariations(widget.variations![index]);
                                _controller.jumpToPage(index);
                                setState(() {});
                              },
                              child: Column(
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        border: Border.all(
                                            color: _current == index
                                                ? AppColors.primaryColor
                                                : Colors.transparent)),
                                    child: CachedNetworkImageShare(
                                      urlImage: widget
                                              .variations?[index].image?.url ??
                                          '',
                                      fit: BoxFit.contain,
                                      heigthNumber: 50.h,
                                      widthNumber: 50.w,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  CustomText(
                                    widget.variationsAttributes?[0]
                                            .options?[index] ??
                                        '',
                                    fontSize: 11,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      itemCount: widget.imgUrl?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                _controller.jumpToPage(index);
                                setState(() {});
                              },
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(
                                        color: _current == index
                                            ? AppColors.primaryColor
                                            : Colors.transparent)),
                                child: CachedNetworkImageShare(
                                  urlImage: widget.imgUrl?[index].src,
                                  fit: BoxFit.contain,
                                  heigthNumber: 50.h,
                                  widthNumber: 50.w,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: widget.onTapBrand,
                    child: CustomText(
                      widget.brandName,
                      color: const Color(0xff678185),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomText(
                    widget.perfumeName,
                    fontSize: 14.sp,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      CustomRateRead(
                        size: 15.w,
                        rate: widget.perfumeRate,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      CustomText(
                        widget.rateCount,
                        color: AppColors.itemGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  widget.variations != null
                      ? Row(
                          children: [
                            Row(
                              children: [
                                CustomText(
                                    controller.variations?.displayRegularPrice
                                        .toString(),
                                    color: AppColors.priceBrownColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    underline: true),
                                CustomText('sar_value'.tr,
                                    color: AppColors.priceBrownColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ],
                            ),
                            SizedBox(
                              width: 83.w,
                            ),
                            Row(
                              children: [
                                CustomText(
                                  controller.variations?.displayPrice
                                      .toString(),
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
                          ],
                        )
                      : Row(
                          children: [
                            Row(
                              children: [
                                CustomText(widget.priceBeforeDiscount,
                                    color: AppColors.priceBrownColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    underline: true),
                                CustomText('sar_value'.tr,
                                    color: AppColors.priceBrownColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal),
                              ],
                            ),
                            SizedBox(
                              width: 83.w,
                            ),
                            Row(
                              children: [
                                CustomText(
                                  widget.priceAfterDiscount,
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
                          ],
                        ),
                  SizedBox(
                    height: 23.h,
                  ),
                  Row(
                    children: [
                      CustomText(
                        'count_value'.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      SizedBox(
                        width: 21.w,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 7.sp),
                        decoration: BoxDecoration(
                            color: AppColors.itemGrey,
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller.increaseQuentity();
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Color(0xff2C3E50),
                                )),
                            SizedBox(
                              width: 10.w,
                            ),
                            CustomText(
                              controller.quantitiy.toStringAsFixed(0),
                              fontSize: 16.sp,
                              color: Color(0xff2C3E50),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            IconButton(
                                onPressed: () {
                                  controller.decreaseQuentity();
                                },
                                icon: Icon(
                                  Icons.remove,
                                  color: Color(0xff2C3E50),
                                )),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
