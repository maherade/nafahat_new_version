import 'package:flutter_svg/svg.dart';

import '../../../services/app_imports.dart';

class CustomCartProductItem extends StatelessWidget {
final String? imgUrl;
final String? price;
final String? quantity;
final VoidCallback? onTapIncrease;
final VoidCallback? onTapDecrease;
final String? total;
final VoidCallback? onTapTrash;

  const CustomCartProductItem({super.key, this.imgUrl, this.price, this.quantity, this.onTapIncrease, this.onTapDecrease, this.total, this.onTapTrash});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CachedNetworkImageShare(
              urlImage:imgUrl,
              fit: BoxFit.contain,
              heigthNumber: 40.h,
              widthNumber: 40.w,
            ),
            Row(
              children: [
                SizedBox(width: 18.w,),
                CustomText(price,fontSize: 14.sp,fontWeight: FontWeight.normal,color: AppColors.greenText,),
                CustomText(' ر.س',fontSize: 14.sp,fontWeight: FontWeight.normal,color: AppColors.greenText,),
              ],
            ),
            Container(
              width:  90.w,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: const Color(0x2ed4d1d2),
                borderRadius: BorderRadius.circular(4.0.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: onTapIncrease, child:const Icon(Icons.add,color: Color(0xff2C3E50),)),
                  CustomText(quantity,fontSize: 11.sp,fontWeight: FontWeight.normal,),
                  InkWell(onTap: onTapDecrease, child:const Icon(Icons.remove,color: Color(0xff2C3E50),)),
                ],
              ),
            ),
            Row(
              children: [
                CustomText(total,fontSize: 14.sp,fontWeight: FontWeight.normal,color: AppColors.greenText,),
                CustomText(' ر.س',fontSize: 14.sp,fontWeight: FontWeight.normal,color: AppColors.greenText,),
              ],
            ),
            InkWell(
              onTap: onTapTrash,
              child: SvgPicture.asset(
                'assets/svg/trash.svg',
                fit: BoxFit.contain,
              ),
            ),

          ],
        ),
        Divider(height: 26.h,)
      ],
    );
  }
}
