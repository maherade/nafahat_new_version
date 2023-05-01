
import '../../../services/app_imports.dart';

class StepperRealEstates extends StatelessWidget {
  final int index;
  List<String> titles = [
    'cart_value'.tr,
    "confirm_value".tr,
    "complete_buy_process_value".tr,
  ];

  //todo:two list: icons and text ;
  StepperRealEstates(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          titles.length,
          (i) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                titles[i],
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(
                height: 6.h,
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index >= i
                          ? AppColors.primaryColor
                          : Colors.grey,
                    ),
                    child: CustomText((i+1).toString(),fontSize: 7.sp,color: AppColors.whiteColor,fontWeight: FontWeight.normal,),
                  ),
                  i == 2
                      ? SizedBox()
                      : Container(
                        width: 100.5.w,
                        height: 3.h,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(2100),
                          color: index >= i
                              ? AppColors.primaryColor
                              : AppColors.itemGrey,
                        ),
                      ),
                ],
              ),

            ],
          )),
    );
  }
}
