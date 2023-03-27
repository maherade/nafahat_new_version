import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart' as location;
import 'package:location/location.dart';
import 'package:perfume_store_mobile_app/controller/app_controller.dart';

import '../../../model/my_marker.dart';
import '../../../model/red_box_response.dart';
import '../widget/map_item_detail.dart';


class RedBoxLocationsInMapScreen extends StatefulWidget {
  List<Points> listPoints;
  // Function(MyMarker) onFinish;

  RedBoxLocationsInMapScreen({Key? key,required this.listPoints,}) : super(key: key);

  @override
  State<RedBoxLocationsInMapScreen> createState() => _RedBoxLocationsInMapScreenState();
}

class _RedBoxLocationsInMapScreenState extends State<RedBoxLocationsInMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> marker = <Marker>{};
  // MyMarker? myMarker;
AppController appController = Get.find();
  Future<void> iniMarker() async {
    for (var element in widget.listPoints) {
      marker.add(Marker(
          markerId: MarkerId(element.id.toString()),
          position: LatLng(
              element.location!.lat! ?? 0.0 , element.location!.lng ?? 0.0),
          onTap: (){
            debugPrint('pressed on Marker');
            debugPrint(element.location!.lat.toString());
            appController.updateMyMarker(MyMarker(point: element));
            // setState(() {
            //   myMarker = MyMarker(
            //     point: element
            //   );
            // });
          }

      ));
      setState(() {

      });
    }
  }
  @override
  void initState() {
     iniMarker();
    print(widget.listPoints.toString());
    log('testtttttt'+appController.myMarker.toString());
    location.Location.instance.requestPermission();
    super.initState();
  }
  @override
  void dispose() {
    // widget.onFinish(appController.myMarker!);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AppController>(
        init: AppController(),
        builder: (appController) {
          return FutureBuilder(
            future: location.Location.instance.getLocation(),
            builder: (context , snapshot){
              if(!snapshot.hasData){
                return const Center(child: CupertinoActivityIndicator());
              }else{
                return Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(snapshot.data?.latitude ?? 0.0,snapshot.data!.longitude!),
                        zoom: 19,
                      ),
                      myLocationEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      markers: marker,
                      onTap: (latlng){
                        setState((){appController.myMarker=null;});
                      },
                    ),
                    appController.myMarker!=null?Positioned(
                      left: 0,
                      right: 0,
                      bottom:100,
                      height: MediaQuery.of(context).size.height *0.42,
                      child: MapItemDetails(
                        // myMarker: appController.myMarker!,
                        // onFinish: (v){
                        //   print(v.point!.address!.street.toString());
                        // },
                      ),
                    ):const SizedBox(),
                  ],
                );
              }
            },
          );
        },
      ),

    );
  }
}
