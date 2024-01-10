import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:perfume_store_mobile_app/apies/order_apies.dart';
import 'package:perfume_store_mobile_app/apies/product_apies.dart';
import 'package:perfume_store_mobile_app/controller/auth_controller.dart';
import 'package:perfume_store_mobile_app/controller/favourite_controller.dart';
import 'package:perfume_store_mobile_app/controller/order_controller.dart';
import 'package:perfume_store_mobile_app/controller/product_controller.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_rate_write_bar.dart';
import 'package:perfume_store_mobile_app/view/shop_by_brand/screen/shop_by_brand_screen.dart';

import '../../../apies/review_apies.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/review_controller.dart';
import '../../../services/app_imports.dart';
import '../../../services/sp_helper.dart';
import '../../auth/screens/login_screen.dart';
import '../../bottom_nav_screens/widget/perfume_product_item.dart';
import '../../custom_widget/custom_dialog.dart';
import '../../custom_widget/custom_text_form_field.dart';
import '../../custom_widget/loading_efffect/loading_perfume_dettail.dart';
import '../../custom_widget/loading_efffect/loading_product.dart';
import '../widget/overview_item.dart';
import '../widget/perfume_details_item.dart';
import '../widget/rating_item.dart';

class PerfumeDetailsScreen extends StatefulWidget {
  final String? productId;

  const PerfumeDetailsScreen({super.key, this.productId});

  @override
  State<PerfumeDetailsScreen> createState() => _PerfumeDetailsScreenState();
}

class _PerfumeDetailsScreenState extends State<PerfumeDetailsScreen> {
  ProductController productController = Get.find();
  OrderController orderController = Get.find();
  CartController cartController = Get.find();
  ReviewController reviewController = Get.find();
  AuthController authController = Get.find();
  TextEditingController addCommentController = TextEditingController();

  String parseHtml(String paragraph, String start, String end) {
    final startIndex = paragraph.indexOf(start);
    final endIndex = paragraph.indexOf(end, startIndex + start.length);
    return paragraph.substring(startIndex + start.length, endIndex);
  }

  List<Color> listColor = [
    AppColors.priceBrownColor,
    AppColors.starYellowColor,
    AppColors.blackColor,
    AppColors.greenText,
    AppColors.priceBrownColor,
  ];
  int selectedIndex = 0;

  int currentIndex = 0;
  int overviewAndRatingToggle = 0;

  double selectedRate = 0.0;

  getData() async {
    ProductApies.productApies.getProductDetailData(widget.productId.toString());
    ReviewApies.reviewApies.getReviewData(widget.productId.toString());
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OrderApies.orderApies.getTheEstimateDeliveryTime();
      getData();
      cartController.quantitiy = 1;
      debugPrint(widget.productId);
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => cartController.setVariations(null));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size dSize = MediaQuery.of(context).size;
    // Current date and time
    DateTime now = DateTime.now();

    // Estimated delivery time in hours (based on the JSON response)
    double deliveryTimeHours =
        orderController.getDeliveryTimeData?.value.deliveryTime ?? 0.0;

    // Calculate the delivery date and time
    DateTime deliveryTime = now.add(Duration(hours: deliveryTimeHours.toInt()));

    // Format the delivery date and time as a string
    String deliveryTimeString =
        "${deliveryTime.month}/${deliveryTime.day}/${deliveryTime.year} ";

    return Scaffold(
      body: Obx(
            () {
          var product =
              productController.getProductDetailResponseData?.value.data;
          var review = reviewController.getReviewData?.value.listReviewResponse;
          var relatedProduct = productController
              .getRelatedProductData!.value.listRelatedProductModel;
          var auth = authController.getCustomerInformationData?.value.data;
          var cart = cartController;
          return product == null
              ? const LoadingPerfumeDetail()
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: const BackButton(),
              ),
              SizedBox(
                height: 17.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PerfumeDetailsItem(
                        imgUrl: product[0].images,
                        variations: product[0].variations,
                        variationsAttributes: product[0].attributes,
                        brandName: product[0].brands != null &&
                            product[0].brands!.isNotEmpty
                            ? product[0].brands![0].name
                            : '',
                        onTapBrand: () {
                          Get.to(
                            ShopByBrandScreen(
                              brandId: product[0].brands?[0].id,
                              brandName: product[0].brands?[0].name,
                            ),
                          );
                        },
                        perfumeName: product[0].title ?? '',
                        perfumeRate: double.parse(
                          product[0].averageRating ?? '0.0',
                        ),
                        rateCount: product[0].ratingCount.toString(),
                        priceBeforeDiscount:
                        (product[0].regularPrice == null ||
                            product[0].regularPrice == '0.00')
                            ? product[0].price
                            : product[0].regularPrice,
                        priceAfterDiscount:
                        (product[0].salePrice == null ||
                            product[0].salePrice == '0.00')
                            ? product[0].price
                            : product[0].salePrice,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Row(
                          children: [
                            GetBuilder(
                              init: CartController(),
                              builder: (controller) {
                                return Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomButton(
                                          onTap: () {
                                            if (SPHelper.spHelper
                                                .getToken() ==
                                                null) {
                                              Get.offAll(
                                                    () => const LoginScreen(),
                                              );
                                            } else {
                                              bool added = cart.addItem(
                                                imgurl: cart
                                                    .variations !=
                                                    null
                                                    ? cart.variations
                                                    ?.image?.url
                                                    : product[0]
                                                    .images?[0]
                                                    .src ??
                                                    '',
                                                name: cart.variations !=
                                                    null
                                                    ? "${product[0].title} ${cart.variations?.attributes?.attributePaD8A7D984D8AdD8AcD985}"
                                                    : product[0].title ??
                                                    '',
                                                price: cart.variations !=
                                                    null
                                                    ? cart.variations
                                                    ?.displayPrice
                                                    : double.parse(
                                                  product[0].salePrice ==
                                                      '' ||
                                                      product[0]
                                                          .salePrice ==
                                                          null
                                                      ? '0.0'
                                                      : product[0]
                                                      .salePrice!,
                                                ),
                                                quantitiy:
                                                controller.quantitiy,
                                                pdtid: cart.variations !=
                                                    null
                                                    ? cart.variations
                                                    ?.variationId
                                                    .toString()
                                                    : product[0]
                                                    .id
                                                    .toString(),
                                              );
                                              if (added) {
                                                CustomDialog.customDialog
                                                    .showCartDialog();
                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(const SnackBar(content: Text('تمت الإضافة إلى السلة بنجاح')));
                                              }
                                            }
                                          },
                                          height: 50.h,
                                          radious: 20.r,
                                          widget: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/buy.png',
                                                color:
                                                AppColors.whiteColor,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              CustomText(
                                                'add_to_cart_value'.tr,
                                                fontSize: 16.sp,
                                                color:
                                                AppColors.whiteColor,
                                                fontWeight:
                                                FontWeight.normal,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 50.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.r,),
                                            border: Border.all(color: AppColors.grey,),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    controller
                                                        .increaseQuentity();
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: AppColors.grey,
                                                  )),
                                              CustomText(
                                                controller.quantitiy
                                                    .toStringAsFixed(0),
                                                fontSize: 16.sp,
                                                color: AppColors
                                                    .primaryColor,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    controller
                                                        .decreaseQuentity();
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    color: AppColors.grey,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            // GetBuilder<FavoriteController>(
                            //   init: FavoriteController(),
                            //   builder: (favourite) {
                            //     return GestureDetector(
                            //       onTap: () {
                            //         if (SPHelper.spHelper.getToken() ==
                            //             null) {
                            //           Get.offAll(
                            //             () => const LoginScreen(),
                            //           );
                            //         } else {
                            //           if (favourite.items.containsKey(
                            //             product[0].id.toString(),
                            //           )) {
                            //             bool removed =
                            //                 favourite.removeItem(
                            //               product[0].id.toString(),
                            //             );
                            //             if (removed) {
                            //               ScaffoldMessenger.of(context)
                            //                   .showSnackBar(
                            //                 SnackBar(
                            //                   content: Text(
                            //                     'remove_from_favourite_value'
                            //                         .tr,
                            //                   ),
                            //                   duration: const Duration(
                            //                     milliseconds: 300,
                            //                   ),
                            //                   backgroundColor:
                            //                       AppColors.primaryColor,
                            //                 ),
                            //               );
                            //             }
                            //           } else {
                            //             bool added = favourite.addItem(
                            //               imgUrl:
                            //                   product[0].images?[0].src ??
                            //                       '',
                            //               brandName: product[0].brands !=
                            //                           null &&
                            //                       product[0]
                            //                           .brands!
                            //                           .isNotEmpty
                            //                   ? product[0].brands![0].name
                            //                   : '',
                            //               pdtid: product[0].id.toString(),
                            //               perfumeName:
                            //                   product[0].title ?? '',
                            //               perfumeRate: double.parse(
                            //                 product[0].averageRating ??
                            //                     '0.0',
                            //               ),
                            //               rateCount: product[0]
                            //                   .ratingCount
                            //                   .toString(),
                            //               priceBeforeDiscount: (product[0]
                            //                               .regularPrice ==
                            //                           null ||
                            //                       product[0]
                            //                               .regularPrice ==
                            //                           '0.00')
                            //                   ? product[0].price
                            //                   : product[0].regularPrice,
                            //               priceAfterDiscount: (product[0]
                            //                               .salePrice ==
                            //                           null ||
                            //                       product[0].salePrice ==
                            //                           '0.00')
                            //                   ? product[0].price
                            //                   : product[0].salePrice,
                            //             );
                            //             if (added) {
                            //               ScaffoldMessenger.of(context)
                            //                   .showSnackBar(
                            //                 SnackBar(
                            //                   content: Text(
                            //                     'add_from_favourite_value'
                            //                         .tr,
                            //                   ),
                            //                   duration: const Duration(
                            //                     milliseconds: 300,
                            //                   ),
                            //                   backgroundColor:
                            //                       AppColors.primaryColor,
                            //                 ),
                            //               );
                            //             }
                            //           }
                            //         }
                            //       },
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(10.0),
                            //         child: Container(
                            //           width: 38.w,
                            //           height: 38.h,
                            //           decoration: BoxDecoration(
                            //             color: Colors.white,
                            //             border: Border.all(
                            //               color:
                            //                   favourite.items.containsKey(
                            //                 product[0].id.toString(),
                            //               )
                            //                       ? Colors.redAccent
                            //                       : Colors.black,
                            //             ),
                            //             shape: BoxShape.circle,
                            //           ),
                            //           child: favourite.items.containsKey(
                            //             product[0].id.toString(),
                            //           )
                            //               ? const Icon(
                            //                   Icons.favorite_outlined,
                            //                   color: Colors.redAccent,
                            //                 )
                            //               : const Icon(
                            //                   Icons.favorite_border,
                            //                 ),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       CustomText(
                      //         "${'you_will_have_value'.tr}${product[0].metaData}${"when_buy_this_product_value".tr}",
                      //         fontSize: 13.sp,
                      //       ),
                      //       Divider(
                      //         height: 30.h,
                      //       ),
                      //       Container(
                      //         width: double.infinity,
                      //         padding: EdgeInsets.all(10.w),
                      //         decoration: BoxDecoration(
                      //           color: AppColors.greyBorder,
                      //           borderRadius: BorderRadius.circular(5.r),
                      //         ),
                      //         child: Column(
                      //           crossAxisAlignment:
                      //               CrossAxisAlignment.start,
                      //           children: [
                      //             CustomText(
                      //               'free_shipping_value'.tr,
                      //               fontSize: 13.sp,
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                 horizontal: 8.0,
                      //               ),
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   CustomText(
                      //                     'free_and_fast_shipping_value'
                      //                         .tr,
                      //                     fontSize: 12.sp,
                      //                     fontWeight: FontWeight.normal,
                      //                   ),
                      //                   CustomText(
                      //                     '${'date_delivery_expected_value'.tr}$deliveryTimeString',
                      //                     fontSize: 12.sp,
                      //                     fontWeight: FontWeight.normal,
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               height: 15.h,
                      //             ),
                      //             CustomText(
                      //               'pay_on_delivery_value'.tr,
                      //               fontSize: 13.sp,
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                 horizontal: 8.0,
                      //               ),
                      //               child: CustomText(
                      //                 'know_more_value'.tr,
                      //                 fontSize: 12.sp,
                      //                 fontWeight: FontWeight.normal,
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               height: 15.h,
                      //             ),
                      //             CustomText(
                      //               'return_policy_value'.tr,
                      //               fontSize: 13.sp,
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                 horizontal: 8.0,
                      //               ),
                      //               child: CustomText(
                      //                 'cannot_return_value'.tr,
                      //                 fontSize: 12.sp,
                      //                 fontWeight: FontWeight.normal,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 24.h,
                      // ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: 30.w,
                      //     vertical: 14.h,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: AppColors.whiteColor,
                      //     borderRadius: BorderRadius.circular(8.0),
                      //     border: Border.all(
                      //       width: 1.0,
                      //       color: AppColors.greyBorder,
                      //     ),
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment:
                      //         MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       GestureDetector(
                      //         onTap: () {
                      //           setState(
                      //             () => overviewAndRatingToggle = 0,
                      //           );
                      //         },
                      //         child: CustomText(
                      //           'overview_value'.tr,
                      //           fontSize: 16.sp,
                      //           color: overviewAndRatingToggle == 0
                      //               ? AppColors.primaryColor
                      //               : AppColors.blackColor,
                      //         ),
                      //       ),
                      //       GestureDetector(
                      //         onTap: () {
                      //           setState(
                      //             () => overviewAndRatingToggle = 1,
                      //           );
                      //         },
                      //         child: CustomText(
                      //           'rating_value'.tr,
                      //           fontSize: 16.sp,
                      //           color: overviewAndRatingToggle == 1
                      //               ? AppColors.primaryColor
                      //               : AppColors.blackColor,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      DefaultTabController(
                        length: 2,
                        child: TabBar(
                          onTap: (index) {
                            setState(() {
                              selectedIndex = index;
                              print(selectedIndex);
                            });
                          },
                          indicatorColor: AppColors.primaryColor,
                          isScrollable: false,
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabAlignment: TabAlignment.fill,
                          labelColor: AppColors.primaryColor,
                          unselectedLabelColor: AppColors.grey,
                          labelStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          tabs: [
                            Tab(
                              child: CustomText(
                                'overview_value'.tr,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: selectedIndex == 0
                                    ? AppColors.primaryColor
                                    : AppColors.grey,
                              ),
                            ),
                            Tab(
                              child: CustomText(
                                'rating_value'.tr,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: selectedIndex == 1
                                    ? AppColors.primaryColor
                                    : AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 19.h,
                      ),
                      selectedIndex == 0
                          ? OverviewItem(
                        // title : parse(product.description!).documentElement!.text,
                        advantages: product[0].description!,
                      )
                          : Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: CustomTextFormField(
                                  hintText: 'add_comment_value'.tr,
                                  controller: addCommentController,
                                  prefixIcon: Padding(
                                    padding:
                                    const EdgeInsets.all(15),
                                    child: CachedNetworkImageShare(
                                      urlImage:
                                      'https://img.freepik.com/premium-photo/3d-character-male-cartoon-with-eye-glasses-yellow-orange-polo-shirt-good-profile-picture_477250-8.jpg?w=740',
                                      fit: BoxFit.contain,
                                      heigthNumber: 32.h,
                                      widthNumber: 32.w,
                                      borderRadious: 0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomButton(
                                  height: 50.h,
                                  onTap: () {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.leftSlide,
                                      headerAnimationLoop: false,
                                      dialogType:
                                      DialogType.question,
                                      showCloseIcon: true,
                                      btnOkOnPress: () {
                                        // debugPrint(widget.productId);
                                        // debugPrint(auth?.userEmail);
                                        // debugPrint(auth?.userDisplayName);
                                        // debugPrint(selectedRate.toInt());
                                        // debugPrint(addCommentController.text);
                                        ReviewApies.reviewApies
                                            .postComment(
                                          productId:
                                          widget.productId,
                                          userEmail: auth?[0]
                                              .userMainEmail ??
                                              'guest@gmail.com',
                                          userName: auth?[0]
                                              .userBillingFullname ??
                                              'guest',
                                          rate:
                                          selectedRate.toInt(),
                                          reviewContent:
                                          addCommentController
                                              .text,
                                        );
                                      },
                                      btnOkIcon: Icons.rate_review,
                                      btnOkText:
                                      'add_rate_value'.tr,
                                      btnOkColor: Colors.deepOrange,
                                      body: Column(
                                        children: [
                                          CustomText(
                                            'how_match_rate_value'
                                                .tr,
                                          ),
                                          CustomRateWrite(
                                            size: 30.w,
                                            onRatingChanged:
                                                (rate) {
                                              debugPrint(
                                                rate.toString(),
                                              );
                                              setState(
                                                    () => selectedRate =
                                                    rate,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ).show();
                                  },
                                  title: 'add_comment_value'.tr,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          review == null
                              ? const SizedBox()
                              : review.isEmpty
                              ? CustomText(
                            'no_comment_value'.tr,
                            fontSize: 15.sp,
                          )
                              : ListView.builder(
                            itemCount: review.length,
                            padding: EdgeInsets.zero,
                            physics:
                            const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder:
                                (context, index) {
                              return RatingItem(
                                imgUrl: review[index]
                                    .reviewerAvatarUrls
                                    ?.s24 ??
                                    '',
                                name: review[index]
                                    .reviewer ??
                                    '',
                                date: DateFormat(
                                  'dd-MM-yyyy',
                                ).format(
                                  DateFormat(
                                    'yyyy-MM-dd',
                                  ).parse(
                                    review[index]
                                        .dateCreated!,
                                  ),
                                ),
                                rate: review[index]
                                    .rating
                                    ?.toDouble() ??
                                    0.0,
                                comment: parse(
                                  review[index]
                                      .review,
                                )
                                    .documentElement
                                    ?.text ??
                                    '',
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CustomText(
                                  'related_product_value'.tr,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                            relatedProduct == null
                                ? const LoadingProduct(2)
                                : GridView.builder(
                              itemCount: relatedProduct.length > 2
                                  ? 2
                                  : relatedProduct.length,
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: dSize.width >
                                    400 &&
                                    dSize.width <= 500
                                    ? 0.6
                                    : dSize.width > 500 &&
                                    dSize.width <= 600
                                    ? 0.7.h
                                    : dSize.width > 600 &&
                                    dSize.width <= 700
                                    ? 0.8.h
                                    : dSize.width > 700 &&
                                    dSize.width <=
                                        800
                                    ? 0.9.h
                                    : dSize.width >
                                    800 &&
                                    dSize.width <=
                                        900
                                    ? 1
                                    : 1.1,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 15,
                              ),
                              itemBuilder: (_, index) {
                                return PerfumeProductItem(
                                  id: relatedProduct[index]
                                      .id
                                      .toString(),
                                  imgUrl: relatedProduct[index]
                                      .images?[0]
                                      .src ??
                                      '',
                                  brandName: '',
                                  perfumeName:
                                  relatedProduct[index].name ??
                                      '',
                                  perfumeRate: double.parse(
                                    relatedProduct[index]
                                        .averageRating ??
                                        '0.0',
                                  ),
                                  rateCount: relatedProduct[index]
                                      .ratingCount
                                      .toString(),
                                  priceBeforeDiscount: (product[0]
                                      .regularPrice ==
                                      null ||
                                      product[0].regularPrice ==
                                          '0.00')
                                      ? product[0].price
                                      : product[0].regularPrice,
                                  priceAfterDiscount: (product[0]
                                      .salePrice ==
                                      null ||
                                      product[0].salePrice ==
                                          '0.00')
                                      ? product[0].price
                                      : product[0].salePrice,
                                  onTapBuy: () {
                                    debugPrint(
                                      relatedProduct[index]
                                          .id
                                          .toString(),
                                    );
                                    ProductApies.productApies
                                        .getProductDetailData(
                                      relatedProduct[index]
                                          .id
                                          .toString(),
                                    );
                                    ReviewApies.reviewApies
                                        .getReviewData(
                                      relatedProduct[index]
                                          .id
                                          .toString(),
                                    );
                                    ProductApies.productApies
                                        .getLastViewProduct();
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70.h,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
