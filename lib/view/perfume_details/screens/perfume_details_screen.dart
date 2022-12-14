import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:perfume_store_mobile_app/apies/product_apies.dart';
import 'package:perfume_store_mobile_app/controller/auth_controller.dart';
import 'package:perfume_store_mobile_app/controller/product_controller.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_rate_write_bar.dart';

import '../../../apies/review_apies.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/review_controller.dart';
import '../../../services/app_imports.dart';
import '../../bottom_nav_screens/widget/perfume_product_item.dart';
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

  int currentIndex = 0;
  int overviewAndRatingToggle = 0;

  double selectedRate = 0.0;

  getData() async {
    ProductApies.productApies.getProductDetailData(widget.productId.toString());
    ReviewApies.reviewApies.getReviewData(widget.productId.toString());
    ProductApies.productApies.getLastViewProduct();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          var product = productController.getProductDetailResponseData?.value;
          var review = reviewController.getReviewData?.value.listReviewResponse;
          var lastViewedProduct = productController.getLastViewedProduct!.value.listLastViewedProductResponse;
          var auth = authController.getUserData?.value;
          var cart = cartController;
          return product!.id == null
              ? LoadingPerfumeDetail()
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 21.w),
                      child: CustomText(
                        'الرئيسية/البيع بالجملة/قسم المكياج/تفاصيل المنتج',
                        color: const Color(0xff707070),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PerfumeDetailsItem(
                              imgUrl: product.images?[0].src ?? '',
                              brandName:
                                  product.brands != null && product.brands!.isNotEmpty ? product.brands![0].name : '',
                              perfumeName: product.name ?? '',
                              perfumeRate: double.parse(product.averageRating ?? '0.0'),
                              rateCount: product.ratingCount.toString() ?? '0',
                              priceBeforeDiscount: product.regularPrice ?? '',
                              priceAfterDiscount: product.salePrice ?? '',
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              height: 30.h,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: listColor.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() => currentIndex = index);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                                            height: 24.h,
                                            width: 24.w,
                                            decoration: BoxDecoration(
                                                color: listColor[index],
                                                shape: BoxShape.circle,
                                                border: currentIndex == index
                                                    ? Border.all(color: AppColors.primaryColor, width: 5)
                                                    : null),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 17.h,
                            ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                            //   child: SizedBox(
                            //     width: 245.w,
                            //     child: CustomText(
                            //       parse(product.description!).documentElement!.text,
                            //       fontSize: 14.sp,
                            //       fontWeight: FontWeight.normal,
                            //       color: const Color(0xff707070),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.w),
                              child: CustomButton(
                                onTap: () {
                                  bool added = cart.addItem(
                                    imgurl: product.images?[0].src ?? '',
                                    name: product.name ?? '',
                                    price: double.parse(product.salePrice == '' || product.salePrice == null
                                        ? '0.0'
                                        : product.salePrice!),
                                    quantitiy: 1,
                                    pdtid: product.id.toString() ?? '',
                                  );
                                  if (added) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(content: Text('تمت الإضافة إلى السلة بنجاح')));
                                  }
                                },
                                height: 50.h,
                                radious: 6.r,
                                widget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/cart.svg',
                                      color: AppColors.whiteColor,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    CustomText(
                                      'أضف الى السلة',
                                      fontSize: 16.sp,
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.normal,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 14.h),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  width: 1.0,
                                  color: AppColors.greyBorder,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() => overviewAndRatingToggle = 0);
                                    },
                                    child: CustomText(
                                      'نظرة عامة',
                                      fontSize: 16.sp,
                                      color:
                                          overviewAndRatingToggle == 0 ? AppColors.primaryColor : AppColors.blackColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() => overviewAndRatingToggle = 1);
                                    },
                                    child: CustomText(
                                      'التقييمات',
                                      fontSize: 16.sp,
                                      color:
                                          overviewAndRatingToggle == 1 ? AppColors.primaryColor : AppColors.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 19.h,
                            ),
                            overviewAndRatingToggle == 0
                                ? OverviewItem(
                                    // title : parse(product.description!).documentElement!.text,
                                     advantages: parse(product.description!).documentElement!.text,
                                    )
                                : Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: CustomTextFormField(
                                              hintText: 'أضف تعليق',
                                              controller: addCommentController,
                                              prefixIcon: Padding(
                                                padding: const EdgeInsets.all(15),
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
                                                dialogType: DialogType.question,
                                                showCloseIcon: true,
                                                btnOkOnPress: () {
                                                  ReviewApies.reviewApies.postComment(
                                                      productId: widget.productId,
                                                      userEmail: auth?.userEmail,
                                                      userName: auth?.userDisplayName,
                                                      rate: selectedRate.toInt(),
                                                      reviewContent: addCommentController.text
                                                  );
                                                },
                                                btnOkIcon: Icons.rate_review,
                                                  btnOkText: 'أضف تقييم',
                                                  btnOkColor: Colors.deepOrange,
                                                body: Column(
                                                  children: [
                                                    CustomText('كم تقييمك للمنتج'),
                                                    CustomRateWrite(
                                                      size: 30.w,
                                                      onRatingChanged: (rate){
                                                        print(rate);
                                                        setState(() => selectedRate = rate);
                                                      },
                                                    ),
                                                  ],
                                                )
                                              ).show();

                                            },
                                            title: 'أضف تعليق',
                                          )),
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
                                                  'لا توجد تعليقات',
                                                  fontSize: 15.sp,
                                                )
                                              : ListView.builder(
                                                  itemCount: review.length,
                                                  padding: EdgeInsets.zero,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder: (context, index) {
                                                    return RatingItem(
                                                      imgUrl: review[index].reviewerAvatarUrls?.s24 ?? '',
                                                      name: review[index].reviewer ?? '',
                                                      date: DateFormat('dd-MM-yyyy').format(
                                                          DateFormat('yyyy-MM-dd').parse(review[index].dateCreated!)),
                                                      rate: review[index].rating?.toDouble() ?? 0.0,
                                                      comment: parse(review[index].review).documentElement?.text ?? '',
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
                                        'أخر المشاهدات',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ],
                                  ),
                                  lastViewedProduct == null ? LoadingProduct(2) :  GridView.builder(
                                    itemCount: lastViewedProduct.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.52.h,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 11.w,
                                      mainAxisSpacing: 16.h,
                                    ),
                                    itemBuilder: (_, index) {
                                      return PerfumeProductItem(
                                        imgUrl: lastViewedProduct[index].images?[0].src??'',
                                        brandName: lastViewedProduct[index].brands!.isNotEmpty ? lastViewedProduct[index].brands != null ? lastViewedProduct[index].brands![0].name : '' : '',
                                        perfumeName: lastViewedProduct[index].name??'',
                                        perfumeRate:  double.parse(lastViewedProduct[index].averageRating??'0.0'),
                                        rateCount: lastViewedProduct[index].ratingCount.toString()?? '0',
                                        priceBeforeDiscount: lastViewedProduct[index].regularPrice??'',
                                        priceAfterDiscount:  lastViewedProduct[index].salePrice??'',
                                        onTapBuy: (){
                                          print(lastViewedProduct[index].id.toString());
                                          Get.to(()=>PerfumeDetailsScreen(productId: lastViewedProduct[index].id.toString(),));
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
