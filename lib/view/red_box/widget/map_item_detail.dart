import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perfume_store_mobile_app/controller/app_controller.dart';
import 'package:perfume_store_mobile_app/services/app_imports.dart';

import '../../../model/my_marker.dart';

class MapItemDetails extends StatefulWidget {
  // MyMarker myMarker;
  // Function(MyMarker) onFinish;
  //
  // MapItemDetails({Key? key, required this.myMarker, required this.onFinish}) : super(key: key);

  @override
  State<MapItemDetails> createState() => _MapItemDetailsState();
}

class _MapItemDetailsState extends State<MapItemDetails> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      init: AppController(),
      builder: (appController) {
      return Stack(children: [
        Container(
          margin: const EdgeInsets.only(top: 45, left: 20, right: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('host_value'.tr),
                      Text(appController.myMarker?.point?.hostNameAr ?? ''),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('street_value'.tr),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(child: Text(appController.myMarker?.point?.address?.street ?? '')),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('city_value'.tr),
                      Text(appController.myMarker?.point?.city?.ar ?? '--'),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('point_name_value'.tr),
                      Text(appController.myMarker?.point?.pointName ?? ''),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('details_value'.tr),
                      SizedBox(width: 15,),
                      Flexible(child: Text(appController.myMarker?.point?.description ?? '')),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: CustomText(
                        'select_point_value'.tr,
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment.topCenter,
        //   child:  Container(
        //     width: 75.0,
        //     height: 75.0,
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       image: DecorationImage(
        //         image: widget.myMarker.gender == 'female'
        //             ? const AssetImage('assets/images/teacher.png')
        //             : const AssetImage('assets/images/66.png'),
        //         fit: BoxFit.cover,
        //       ),
        //       borderRadius: BorderRadius.all( Radius.circular(50.0)),
        //       border: Border.all(
        //         color: Colors.red,
        //         width: 2.5,
        //       ),
        //     ),
        //   ),
        // ),
      ]);
    },);
  }
}
