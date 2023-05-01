import 'package:intl/intl.dart';
import 'package:perfume_store_mobile_app/model/order_list_response.dart';

import '../../../services/app_imports.dart';

class PreviousOrderItem extends StatelessWidget {
  final String? orderId;

  final String? orderStatus;

  final String? productName;

  final String? productPrice;

  final String? deliveryLocation;

  final String? deliveryDate;

  final String? deliveryTime;

  final String? paymentMethod;

  final List<LineItems>? imgUrls;

  final VoidCallback? onTapReOrder;

  const PreviousOrderItem(
      {super.key,
        this.orderId,
        this.orderStatus,
        this.productName,
        this.productPrice,
        this.deliveryLocation,
        this.deliveryDate,
        this.deliveryTime,
        this.paymentMethod,
        this.imgUrls,
        this.onTapReOrder});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      margin: EdgeInsets.symmetric(horizontal: 18.w,vertical: 8.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), border: Border.all(color: Color(0xffdcd9da))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                orderId,
                fontSize: 13.sp,
                color: Color(0xff6d8589),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    height: 7.h,
                    width: 7.w,
                    decoration: BoxDecoration(shape: BoxShape.circle, color:orderStatus == "completed" ?Color(0xff2ca882) :Color(0xffd8322c)),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CustomText(
                    orderStatus == "completed"
                        ? "مكتمل"
                        : orderStatus == "cancelled"
                        ? "ملغي"
                        : "",
                    fontSize: 13.sp,
                    color:orderStatus == "completed" ?Color(0xff2ca882) :Color(0xffd8322c),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'اسم المنتج',
                fontSize: 13.sp,
                color: Color(0xff828282),
              ),
              Expanded(
                child: CustomText(
                  productName,
                  fontSize: 13.sp,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                'السعر الكلي',
                fontSize: 13.sp,
                color: Color(0xff828282),
              ),
              CustomText(
                productPrice,
                fontSize: 13.sp,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                'مكان التوصيل',
                fontSize: 13.sp,
                color: Color(0xff828282),
              ),
              CustomText(
                deliveryLocation,
                fontSize: 13.sp,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                'تاريخ التوصيل',
                fontSize: 13.sp,
                color: Color(0xff828282),
              ),
              CustomText(
              deliveryDate==null? deliveryDate :DateFormat('yyyy-MM-dd').format(DateTime.parse(deliveryDate!)),
                fontSize: 13.sp,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                'وقت التوصيل',
                fontSize: 13.sp,
                color: Color(0xff828282),
              ),
              CustomText(
                deliveryTime==null? deliveryTime :DateFormat('hh:mm:ss a').format(DateTime.parse(deliveryTime!)),
                fontSize: 13.sp,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                'طريقة الدفع',
                fontSize: 13.sp,
                color: Color(0xff828282),
              ),
              CustomText(
                paymentMethod,
                fontSize: 13.sp,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 50.h,
            child: ListView.builder(
              itemCount: imgUrls?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: CachedNetworkImageShare(
                        urlImage: imgUrls?[index].image?.src ?? '',
                        fit: BoxFit.contain,
                        heigthNumber: 50.h,
                        widthNumber: 50.w,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Divider(
            height: 30.h,
            color: Color(0xffd8d4d5),
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onTapReOrder,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: CustomText(
                    'اعادة الطلب',
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
