import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart' as location;
import 'package:perfume_store_mobile_app/controller/app_controller.dart';
import '../../../colors.dart';
import '../../../model/my_marker.dart';
import '../../../model/red_box_response.dart';
import '../widget/map_item_detail.dart';

class RedBoxLocationsInMapScreen extends StatefulWidget {
  List<Points> listPoints;

  RedBoxLocationsInMapScreen({
    Key? key,
    required this.listPoints,
  }) : super(key: key);

  @override
  State<RedBoxLocationsInMapScreen> createState() => _RedBoxLocationsInMapScreenState();
}

class _RedBoxLocationsInMapScreenState extends State<RedBoxLocationsInMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> marker = <Marker>{};
  AppController appController = Get.find();

  Future<void> iniMarker() async {
    for (var element in widget.listPoints) {
      marker.add(Marker(
          markerId: MarkerId(element.id.toString()),
          position: LatLng(element.location!.lat! ?? 0.0, element.location!.lng ?? 0.0),
          onTap: () {
            debugPrint('pressed on Marker');
            debugPrint(element.location!.lat.toString());
            appController.updateMyMarker(MyMarker(point: element));
          }));
      setState(() {});
    }
  }

  Set<Marker> filteredMarkers = <Marker>{};

  void search(String query) {
    filteredMarkers.clear();
    for (var element in widget.listPoints) {
      if (element.pointName!.toLowerCase().contains(query.toLowerCase()) ||
          element.address!.street!.toLowerCase().contains(query.toLowerCase()) ||
          element.hostNameAr!.toLowerCase().contains(query.toLowerCase())) {
        print('${element.pointName}');
        filteredMarkers.add(Marker(
          markerId: MarkerId(element.id.toString()),
          position: LatLng(element.location!.lat ?? 0.0, element.location!.lng ?? 0.0),
          onTap: () {
            debugPrint('pressed on Marker');
            debugPrint(element.location!.lat.toString());
            appController.updateMyMarker(MyMarker(point: element));
          },
        ));
      }
    }
    setState(() {
      marker = filteredMarkers;
    });
  }

  @override
  void initState() {
    iniMarker();
    print(widget.listPoints.toString());
    log('testtttttt' + appController.myMarker.toString());
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
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CupertinoActivityIndicator());
              } else {
                return Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(snapshot.data?.latitude ?? 0.0, snapshot.data!.longitude!),
                        zoom: 19,
                      ),
                      myLocationEnabled: true,
                      padding: EdgeInsets.only(top: 100),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      markers: filteredMarkers.isNotEmpty ? filteredMarkers : marker,
                      onTap: (latlng) {
                        setState(() {
                          appController.myMarker = null;
                        });
                      },
                    ),
                    appController.myMarker != null
                        ? Positioned(
                            left: 0,
                            right: 0,
                            bottom: 100,
                            height: MediaQuery.of(context).size.height * 0.42,
                            child: MapItemDetails(),
                          )
                        : const SizedBox(),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 15),
                            child: TextFormField(
                              onChanged: (query) {
                                search(query);
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'search',
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, fontFamily: 'urw_din'),
                                  // filled: true,
                                  // fillColor: AppColors.whiteColor,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: AppColors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: AppColors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: AppColors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      ],
                    )
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
