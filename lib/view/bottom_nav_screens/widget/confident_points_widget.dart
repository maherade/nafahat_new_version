import 'package:flutter/material.dart';
import 'package:perfume_store_mobile_app/services/app_imports.dart';

class ConfidentPoints extends StatelessWidget {
  String image;
  String title;
  String description;
  String restDescription;
    ConfidentPoints({required this.image, required this.description,required this.restDescription,required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.grey.withOpacity(.2)),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 70.h,
              width: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0XFFFAEBEE),
              ),
              child:Image(
                image: AssetImage(image,),
                height: 80.h,
                width: 80.w,
              ) ,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp),),

                SizedBox(
                  height: 5.h,
                ),

                Text(description,style:  TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
