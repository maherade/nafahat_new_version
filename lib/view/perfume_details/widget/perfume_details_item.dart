import 'package:perfume_store_mobile_app/controller/cart_controller.dart';
import 'package:perfume_store_mobile_app/controller/favourite_controller.dart';
import 'package:perfume_store_mobile_app/view/perfume_details/widget/header_row.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/order_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../controller/review_controller.dart';
import '../../../model/product_detail_response.dart';
import '../../../services/app_imports.dart';
import '../../../services/sp_helper.dart';
import '../../auth/screens/login_screen.dart';
import '../../custom_widget/custom_dialog.dart';
import '../../custom_widget/custom_rate_write_bar.dart';
import '../../search/screen/search_screen.dart';

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
  ProductController productController = Get.find();
  OrderController orderController = Get.find();
  CartController cartController = Get.find();
  ReviewController reviewController = Get.find();
  AuthController authController = Get.find();
  TextEditingController addCommentController = TextEditingController();

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
    var product = productController.getProductDetailResponseData?.value.data;
    var review = reviewController.getReviewData?.value.listReviewResponse;
    var relatedProduct =
        productController.getRelatedProductData!.value.listRelatedProductModel;
    var auth = authController.getCustomerInformationData?.value.data;
    var cart = cartController;
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 400.h,
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.grey.withOpacity(.1),
                                )
                              ]),
                          height: 300.h,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.greyBorder,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  HeaderRow(
                                    imagePath:
                                    'assets/images/cart_img.png',
                                    onTap: () {
                                      if (SPHelper.spHelper.getToken() ==
                                          null) {
                                        Get.offAll(
                                              () => const LoginScreen(),
                                        );
                                      } else {
                                        bool added = cart.addItem(
                                          imgurl: cart.variations != null
                                              ? cart
                                              .variations?.image?.url
                                              : product?[0]
                                              .images?[0]
                                              .src ??
                                              '',
                                          name: cart.variations != null
                                              ? "${product?[0].title} ${cart.variations?.attributes?.attributePaD8A7D984D8AdD8AcD985}"
                                              : product?[0].title ?? '',
                                          price: cart.variations != null
                                              ? cart.variations
                                              ?.displayPrice
                                              : double.parse(
                                            product?[0].salePrice ==
                                                '' ||
                                                product?[0]
                                                    .salePrice ==
                                                    null
                                                ? '0.0'
                                                : product![0]
                                                .salePrice!,
                                          ),
                                          quantitiy: controller.quantitiy,
                                          pdtid: cart.variations != null
                                              ? cart
                                              .variations?.variationId
                                              .toString()
                                              : product?[0].id.toString(),
                                        );
                                        if (added) {
                                          CustomDialog.customDialog
                                              .showCartDialog();
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(const SnackBar(content: Text('تمت الإضافة إلى السلة بنجاح')));
                                        }
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  HeaderRow(
                                    imagePath: "assets/images/search.png",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const SearchScreen(),
                                        ),);
                                    },
                                  ),
                                ],),
                              ),
                              Expanded(
                                child: CachedNetworkImageShare(
                                  urlImage: widget.imgUrl?[index].src,
                                  fit: BoxFit.contain,
                                  heigthNumber: 233.h,
                                  widthNumber: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                                  HeaderRow(
                                    imagePath: 'assets/images/share.png',
                                    onTap: () {},
                                  ),
                                  const Spacer(),
                                  HeaderRow(
                                    imagePath: 'assets/images/heart.png',
                                    onTap: () {},
                                  ),
                                ]),
                              ),
                            ],
                          ),
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color:
                                AppColors.blackColor.withOpacity(.1),
                              ),
                            ],
                          ),
                          height: 300.h,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.greyBorder,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  HeaderRow(
                                    imagePath:
                                    'assets/images/cart_img.png',
                                    onTap: () {
                                      if (SPHelper.spHelper.getToken() ==
                                          null) {
                                        Get.offAll(
                                              () => const LoginScreen(),
                                        );
                                      } else {
                                        bool added = cart.addItem(
                                          imgurl: cart.variations != null
                                              ? cart
                                              .variations?.image?.url
                                              : product?[0]
                                              .images?[0]
                                              .src ??
                                              '',
                                          name: cart.variations != null
                                              ? "${product?[0].title} ${cart.variations?.attributes?.attributePaD8A7D984D8AdD8AcD985}"
                                              : product?[0].title ?? '',
                                          price: cart.variations != null
                                              ? cart.variations
                                              ?.displayPrice
                                              : double.parse(
                                            product?[0].salePrice ==
                                                '' ||
                                                product?[0]
                                                    .salePrice ==
                                                    null
                                                ? '0.0'
                                                : product![0]
                                                .salePrice!,
                                          ),
                                          quantitiy: controller.quantitiy,
                                          pdtid: cart.variations != null
                                              ? cart
                                              .variations?.variationId
                                              .toString()
                                              : product?[0].id.toString(),
                                        );
                                        if (added) {
                                          CustomDialog.customDialog
                                              .showCartDialog();
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(const SnackBar(content: Text('تمت الإضافة إلى السلة بنجاح')));
                                        }
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  HeaderRow(
                                    imagePath: 'assets/images/Search.png',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const SearchScreen(),
                                        ),);
                                    },
                                  ),
                                ]),
                              ),
                              Expanded(
                                child: CachedNetworkImageShare(
                                  urlImage: widget.imgUrl?[index].src,
                                  fit: BoxFit.contain,
                                  heigthNumber: 233.h,
                                  widthNumber: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                                  HeaderRow(
                                    imagePath: 'assets/images/share.png',
                                    onTap: () {},
                                  ),
                                  const Spacer(),
                                  GetBuilder<FavoriteController>(
                                    init: FavoriteController(),
                                    builder: (favourite) {
                                      return HeaderRow(
                                        imagePath: 'assets/images/heart.png',
                                        onTap: () {
                                          if (SPHelper.spHelper.getToken() ==
                                              null) {
                                            Get.offAll(
                                                  () => const LoginScreen(),
                                            );
                                          } else {
                                            if (favourite.items.containsKey(
                                              product?[0].id.toString(),
                                            )) {
                                              bool removed =
                                              favourite.removeItem(
                                                product![0].id.toString(),
                                              );
                                              if (removed) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'remove_from_favourite_value'
                                                          .tr,
                                                    ),
                                                    duration: const Duration(
                                                      milliseconds: 300,
                                                    ),
                                                    backgroundColor:
                                                    AppColors.primaryColor,
                                                  ),
                                                );
                                              }
                                            } else {
                                              bool added = favourite.addItem(
                                                imgUrl:
                                                product?[0].images?[0].src ??
                                                    '',
                                                brandName: product?[0].brands !=
                                                    null &&
                                                    product![0]
                                                        .brands!
                                                        .isNotEmpty
                                                    ? product[0].brands![0].name
                                                    : '',
                                                pdtid: product?[0].id.toString(),
                                                perfumeName:
                                                product?[0].title ?? '',
                                                perfumeRate: double.parse(
                                                  product?[0].averageRating ??
                                                      '0.0',
                                                ),
                                                rateCount: product?[0]
                                                    .ratingCount
                                                    .toString(),
                                                priceBeforeDiscount: (product?[0]
                                                    .regularPrice ==
                                                    null ||
                                                    product?[0]
                                                        .regularPrice ==
                                                        '0.00')
                                                    ? product![0].price
                                                    : product?[0].regularPrice,
                                                priceAfterDiscount: (product?[0]
                                                    .salePrice ==
                                                    null ||
                                                    product?[0].salePrice ==
                                                        '0.00')
                                                    ? product![0].price
                                                    : product?[0].salePrice,
                                              );
                                              if (added) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'add_from_favourite_value'
                                                          .tr,
                                                    ),
                                                    duration: const Duration(
                                                      milliseconds: 300,
                                                    ),
                                                    backgroundColor:
                                                    AppColors.primaryColor,
                                                  ),
                                                );
                                              }
                                            }
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // Align(
                  //   alignment: AlignmentDirectional.centerEnd,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       _controller.nextPage(
                  //           duration: Duration(milliseconds: 400),
                  //           curve: Curves.easeIn);
                  //     },
                  //     child: Container(
                  //       margin: EdgeInsets.symmetric(horizontal: 15.w),
                  //       padding: EdgeInsets.all(3.w),
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         shape: BoxShape.circle,
                  //         border: Border.all(),
                  //       ),
                  //       child: Icon(
                  //         Icons.arrow_back_ios_new,
                  //         size: 15.w,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Align(
                  //   alignment: AlignmentDirectional.centerStart,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       _controller.previousPage(
                  //           duration: Duration(milliseconds: 400),
                  //           curve: Curves.easeIn);
                  //     },
                  //     child: Container(
                  //       margin: EdgeInsets.symmetric(horizontal: 15.w),
                  //       padding: EdgeInsets.all(3.w),
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         shape: BoxShape.circle,
                  //         border: Border.all(),
                  //       ),
                  //       child: Directionality(
                  //           textDirection: TextDirection.ltr,
                  //           child: Icon(
                  //             Icons.arrow_forward_ios_rounded,
                  //             size: 15.w,
                  //           )),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                'موديلات المنتج',fontSize: 12.sp,color: AppColors.blackColor,
              ),
            ),
            SizedBox(
              height: 10.h,
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
                                  BorderRadius.circular(10.r),
                                  border: Border.all(
                                      color: _current == index
                                          ? AppColors.primaryColor
                                          : Colors.transparent)),
                              child: CachedNetworkImageShare(
                                urlImage: widget
                                    .variations?[index].image?.url ??
                                    '',
                                fit: BoxFit.cover,
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
              height: 100.h,
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
                          height: 120.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: AppColors.whiteColor.withOpacity(.5),
                              border: Border.all(
                                  color: _current == index
                                      ? AppColors.primaryColor
                                      : AppColors.greyBorder)),
                          child: CachedNetworkImageShare(
                            urlImage: widget.imgUrl?[index].src,
                            fit: BoxFit.contain,
                            heigthNumber: 100.h,
                            widthNumber: 80.w,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: widget.onTapBrand,
                    child: CustomText(
                      widget.perfumeName,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(
                  //   height: 5.h,
                  // ),
                  // CustomText(
                  //   widget.perfumeName,
                  //   fontSize: 14.sp,
                  // ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Row(
                  //   children: [
                  //     CustomRateRead(
                  //       size: 15.w,
                  //       rate: widget.perfumeRate,
                  //     ),
                  //     SizedBox(
                  //       width: 4.w,
                  //     ),
                  //     CustomText(
                  //       widget.rateCount,
                  //       color: AppColors.itemGrey,
                  //       fontSize: 12.sp,
                  //       fontWeight: FontWeight.normal,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 5.h,
                  // ),
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
                          CustomText('ريال',
                              color: AppColors.priceBrownColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal),
                        ],
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

                            CustomText(
                              'تخفيض 15 %',
                              fontSize: 10.sp,
                              color: AppColors.primaryColor,
                            )
                          ],
                        ),
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
                            'ريال',
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
                          CustomText(
                            widget.priceAfterDiscount,
                            color: AppColors.greenText,
                            fontSize: 20.sp,
                          ),
                          SizedBox(width: 5.w ,),

                          CustomText(
                            'ريال',
                            color: AppColors.greenText,
                            fontSize: 16.sp,
                          ),
                        ],
                      ),
                      SizedBox(
                        width:15.w,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.primaryColor,
                            )
                        ),
                        child: Row(
                          children: [

                            CustomText(
                              'تخفيض 15 %',
                              fontSize: 10.sp,
                              color: AppColors.primaryColor,
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        width: 23.h,
                      ),

                      Row(
                        children: [
                          CustomText(widget.priceBeforeDiscount,
                              color: AppColors.priceBrownColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              underline: true),
                          SizedBox(width: 5.w ,),
                          CustomText('ريال',
                              color: AppColors.priceBrownColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal),
                        ],
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
