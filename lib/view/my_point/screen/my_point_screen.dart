import 'package:flutter/cupertino.dart';
import 'package:perfume_store_mobile_app/apies/order_apies.dart';
import 'package:perfume_store_mobile_app/controller/order_controller.dart';
import 'package:perfume_store_mobile_app/services/app_imports.dart';
import 'package:perfume_store_mobile_app/services/sp_helper.dart';

class MyPointScreen extends StatefulWidget {
  const MyPointScreen({Key? key}) : super(key: key);

  @override
  State<MyPointScreen> createState() => _MyPointScreenState();
}

class _MyPointScreenState extends State<MyPointScreen> {
  OrderController orderController = Get.find();
  int _selectedIndex = 0;

  final List<String> _list = [
    'all_value'.tr,
    'remaining_points_value'.tr,
    'used_points_value'.tr,
    'expired_points_value'.tr
  ];

  @override
  void initState() {
    OrderApies.orderApies
        .getPointList(customerID: SPHelper.spHelper.getUserId());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          var point = orderController.getPointsListData?.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    CustomText(
                      'my_points_value'.tr,
                      fontSize: 15.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                child: point?.status == null
                    ? const Center(child: CupertinoActivityIndicator())
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 120.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.greyBorder,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            point?.status?[0].points.toString(),
                                            color: AppColors.primaryColor,
                                            fontSize: 14.sp,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          CustomText(
                                            'total_points_value'.tr,
                                            fontSize: 14.sp,
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
                                      height: 120.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.greyBorder,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            point?.status?[4].points.toString(),
                                            color: AppColors.primaryColor,
                                            fontSize: 14.sp,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          CustomText(
                                            'expired_total_points_value'.tr,
                                            fontSize: 14.sp,
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                              child: CustomText(
                                'points_date_value'.tr,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              height: 50.h,
                              margin: EdgeInsets.symmetric(horizontal: 18.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border:
                                    Border.all(color: const Color(0xffdcd9da)),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: _list.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    Color color = _selectedIndex == index
                                        ? AppColors.primaryColor
                                        : Colors.black;

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedIndex = index;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.0.w,
                                        ),
                                        child: CustomText(
                                          entry.value,
                                          color: color,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            _selectedIndex == 0
                                ? ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: point?.status?.length,
                                    itemBuilder: (context, index) {
                                      var all = point?.status?[index];
                                      return all?.points == 0
                                          ? const SizedBox.shrink()
                                          : Container(
                                              padding: EdgeInsets.all(10.w),
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 18.w,
                                                vertical: 10.h,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10.r,
                                                ),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xffdcd9da),
                                                ),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/point.png',
                                                  ),
                                                  SizedBox(
                                                    width: 13.w,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        all?.label ==
                                                                'Total Points (All Time)'
                                                            ? Row(
                                                                children: [
                                                                  CustomText(
                                                                    'total_points_value'
                                                                        .tr,
                                                                    fontSize:
                                                                        14.sp,
                                                                  ),
                                                                  CustomText(
                                                                    all?.points
                                                                        .toString(),
                                                                    fontSize:
                                                                        14.sp,
                                                                  ),
                                                                  CustomText(
                                                                    'equal_to_value'
                                                                        .tr,
                                                                    fontSize:
                                                                        14.sp,
                                                                  ),
                                                                  CustomText(
                                                                    all?.value,
                                                                    fontSize:
                                                                        14.sp,
                                                                  ),
                                                                ],
                                                              )
                                                            : all?.label ==
                                                                    'Deducted'
                                                                ? Wrap(
                                                                    children: [
                                                                      CustomText(
                                                                        'redeemed_points_value'
                                                                            .tr,
                                                                        fontSize:
                                                                            14.sp,
                                                                      ),
                                                                      CustomText(
                                                                        all?.points
                                                                            .toString(),
                                                                        fontSize:
                                                                            14.sp,
                                                                      ),
                                                                      CustomText(
                                                                        'points_discount_value'
                                                                            .tr,
                                                                        fontSize:
                                                                            14.sp,
                                                                      ),
                                                                      CustomText(
                                                                        all?.value,
                                                                        fontSize:
                                                                            14.sp,
                                                                      ),
                                                                    ],
                                                                  )
                                                                : all?.label ==
                                                                        'Expired Points'
                                                                    ? Wrap(
                                                                        children: [
                                                                          CustomText(
                                                                            'points_expired_value'.tr,
                                                                            fontSize:
                                                                                14.sp,
                                                                          ),
                                                                          CustomText(
                                                                            all?.points.toString(),
                                                                            fontSize:
                                                                                14.sp,
                                                                          ),
                                                                          CustomText(
                                                                            'equal_to_2_value'.tr,
                                                                            fontSize:
                                                                                14.sp,
                                                                          ),
                                                                          CustomText(
                                                                            all?.value,
                                                                            fontSize:
                                                                                14.sp,
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : all?.label ==
                                                                            'Claimed Points'
                                                                        ? Wrap(
                                                                            children: [
                                                                              CustomText(
                                                                                'got_points_value'.tr,
                                                                                fontSize: 14.sp,
                                                                              ),
                                                                              CustomText(
                                                                                all?.points.toString(),
                                                                                fontSize: 14.sp,
                                                                              ),
                                                                              CustomText(
                                                                                'equal_to_2_value'.tr,
                                                                                fontSize: 14.sp,
                                                                              ),
                                                                              CustomText(
                                                                                all?.value,
                                                                                fontSize: 14.sp,
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : all?.label ==
                                                                                'Pending Points'
                                                                            ? Wrap(
                                                                                children: [
                                                                                  CustomText(
                                                                                    'pending_points_value'.tr,
                                                                                    fontSize: 14.sp,
                                                                                  ),
                                                                                  CustomText(
                                                                                    all?.points.toString(),
                                                                                    fontSize: 14.sp,
                                                                                  ),
                                                                                  CustomText(
                                                                                    'pending_equal_to_value'.tr,
                                                                                    fontSize: 14.sp,
                                                                                  ),
                                                                                  CustomText(
                                                                                    all?.value,
                                                                                    fontSize: 14.sp,
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            : all?.label == 'Unclaimed Points'
                                                                                ? Wrap(
                                                                                    children: [
                                                                                      CustomText(
                                                                                        'unclaimed_points_value'.tr,
                                                                                        fontSize: 14.sp,
                                                                                      ),
                                                                                      CustomText(
                                                                                        all?.points.toString(),
                                                                                        fontSize: 14.sp,
                                                                                      ),
                                                                                      CustomText(
                                                                                        'pending_equal_to_value'.tr,
                                                                                        fontSize: 14.sp,
                                                                                      ),
                                                                                      CustomText(
                                                                                        all?.value,
                                                                                        fontSize: 14.sp,
                                                                                      ),
                                                                                    ],
                                                                                  )
                                                                                : const SizedBox.shrink()
                                                        // SizedBox(height: 10.h,),
                                                        // CustomText('30/12/2023',fontSize: 14.sp,color: AppColors.grey,),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                    },
                                  )
                                : _selectedIndex == 1
                                    ? ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: point?.status?.length,
                                        itemBuilder: (context, index) {
                                          var all = point?.status?[index];
                                          return all?.label !=
                                                  'Unclaimed Points'
                                              ? const SizedBox.shrink()
                                              : Container(
                                                  padding: EdgeInsets.all(10.w),
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: 18.w,
                                                    vertical: 10.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10.r,
                                                    ),
                                                    border: Border.all(
                                                      color: const Color(
                                                        0xffdcd9da,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/point.png',
                                                      ),
                                                      SizedBox(
                                                        width: 13.w,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Wrap(
                                                              children: [
                                                                CustomText(
                                                                  'unclaimed_points_value'
                                                                      .tr,
                                                                  fontSize:
                                                                      14.sp,
                                                                ),
                                                                CustomText(
                                                                  all?.points
                                                                      .toString(),
                                                                  fontSize:
                                                                      14.sp,
                                                                ),
                                                                CustomText(
                                                                  'pending_equal_to_value'
                                                                      .tr,
                                                                  fontSize:
                                                                      14.sp,
                                                                ),
                                                                CustomText(
                                                                  all?.value,
                                                                  fontSize:
                                                                      14.sp,
                                                                ),
                                                              ],
                                                            )
                                                            // SizedBox(height: 10.h,),
                                                            // CustomText('30/12/2023',fontSize: 14.sp,color: AppColors.grey,),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                        },
                                      )
                                    : _selectedIndex == 2
                                        ? ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: point?.status?.length,
                                            itemBuilder: (context, index) {
                                              var all = point?.status?[index];
                                              return all?.label != 'Deducted'
                                                  ? const SizedBox.shrink()
                                                  : Container(
                                                      padding:
                                                          EdgeInsets.all(10.w),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 18.w,
                                                        vertical: 10.h,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10.r,
                                                        ),
                                                        border: Border.all(
                                                          color: const Color(
                                                            0xffdcd9da,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Image.asset(
                                                            'assets/images/point.png',
                                                          ),
                                                          SizedBox(
                                                            width: 13.w,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Wrap(
                                                                  children: [
                                                                    CustomText(
                                                                      'used_value'
                                                                          .tr,
                                                                      fontSize:
                                                                          14.sp,
                                                                    ),
                                                                    CustomText(
                                                                      all?.points
                                                                          .toString(),
                                                                      fontSize:
                                                                          14.sp,
                                                                    ),
                                                                    CustomText(
                                                                      'pending_equal_to_value'
                                                                          .tr,
                                                                      fontSize:
                                                                          14.sp,
                                                                    ),
                                                                    CustomText(
                                                                      all?.value,
                                                                      fontSize:
                                                                          14.sp,
                                                                    ),
                                                                  ],
                                                                )
                                                                // SizedBox(height: 10.h,),
                                                                // CustomText('30/12/2023',fontSize: 14.sp,color: AppColors.grey,),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                            },
                                          )
                                        : _selectedIndex == 3
                                            ? ListView.builder(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    point?.status?.length,
                                                itemBuilder: (context, index) {
                                                  var all =
                                                      point?.status?[index];
                                                  return all?.label !=
                                                          'Expired Points'
                                                      ? const SizedBox.shrink()
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                            10.w,
                                                          ),
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 18.w,
                                                            vertical: 10.h,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10.r,
                                                            ),
                                                            border: Border.all(
                                                              color:
                                                                  const Color(
                                                                0xffdcd9da,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Image.asset(
                                                                'assets/images/point.png',
                                                              ),
                                                              SizedBox(
                                                                width: 13.w,
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Wrap(
                                                                      children: [
                                                                        CustomText(
                                                                          'points_expired_value'
                                                                              .tr,
                                                                          fontSize:
                                                                              14.sp,
                                                                        ),
                                                                        CustomText(
                                                                          all?.points
                                                                              .toString(),
                                                                          fontSize:
                                                                              14.sp,
                                                                        ),
                                                                        CustomText(
                                                                          'pending_equal_to_value'
                                                                              .tr,
                                                                          fontSize:
                                                                              14.sp,
                                                                        ),
                                                                        CustomText(
                                                                          all?.value,
                                                                          fontSize:
                                                                              14.sp,
                                                                        ),
                                                                      ],
                                                                    )
                                                                    // SizedBox(height: 10.h,),
                                                                    // CustomText('30/12/2023',fontSize: 14.sp,color: AppColors.grey,),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                },
                                              )
                                            : const SizedBox.shrink()
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
