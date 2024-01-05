import '../../../services/app_imports.dart';
import '../widget/sent_gift_item.dart';

class GiftCard extends StatefulWidget {
  const GiftCard({Key? key}) : super(key: key);

  @override
  State<GiftCard> createState() => _GiftCardState();
}

class _GiftCardState extends State<GiftCard> {
  String selectGiftType = 'send_gift_card';
  List test = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  'giftt_card_value'.tr,
                  fontSize: 15.sp,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 50.h,
            margin: EdgeInsets.symmetric(horizontal: 18.w),
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(color: const Color(0xffdcd9da)),
            ),
            child: Row(
              children: [
                selectGiftType == 'send_gift_card'
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                            'send_credit_value'.tr,
                            fontSize: 14.sp,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: 90.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          )
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            selectGiftType = 'send_gift_card';
                          });
                        },
                        child: CustomText(
                          'send_credit_value'.tr,
                          fontSize: 14.sp,
                        ),
                      ),
                const Spacer(),
                selectGiftType == 'sent_gift'
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                            'sended_gift_value'.tr,
                            fontSize: 14.sp,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: 90.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          )
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            selectGiftType = 'sent_gift';
                          });
                        },
                        child: CustomText(
                          'sended_gift_value'.tr,
                          fontSize: 14.sp,
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          selectGiftType == 'send_gift_card'
              ? const SentGiftItem()
              : Expanded(
                  child: test.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/no_gift.png'),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomText(
                              'no_gift_value'.tr,
                              fontSize: 15.sp,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomText(
                              'no_gift_found_yet_value'.tr,
                              fontSize: 14.sp,
                              color: AppColors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectGiftType = 'send_gift_card';
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: CustomText(
                                  'send_first_gift_value'.tr,
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            )
                          ],
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const SentGiftItem();
                          },
                        ),
                )
        ],
      ),
    );
  }
}
