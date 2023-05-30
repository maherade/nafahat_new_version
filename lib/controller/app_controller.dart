
import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfume_store_mobile_app/model/my_marker.dart';

import '../model/countries_response.dart';
import '../model/red_box_response.dart';

class AppController extends GetxController {
  MyMarker? myMarker;

  void updateMyMarker(value) {
    myMarker = value;
    update();
  }



  //----------------
  int indexScreen = 0;
  setIndexScreen(int value) {
    indexScreen = value;
    update();
  }


  bool visibleButton = true;

  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 2);
  @override

  void startTimer() {
      visibleButton = false;
      myDuration =const Duration(minutes: 2);
      countdownTimer =
        Timer.periodic(const Duration(seconds: 2), (_) => setCountDown());
      update();
  }
  void resetTimer() {
      myDuration =const Duration(minutes: 2);
      visibleButton = false;
    update();

  }
  void setCountDown() {
    int reduceSecondsBy = 1;

      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
          visibleButton = true;
          update();
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
        update();
      }
      update();
  }
  //----------------------------- Cart Functionality ------------------------------

  int currentStepperIndex = 0;
  updateCurrentStepperIndex(int value){
    currentStepperIndex = value ;
    update();
  }
  CountriesResponse? selectedCountries;
  updateSelectedCountries(CountriesResponse value){
    selectedCountries = value ;
    update();
  }

  String? selectedAddress;
  updateSelectedAddress(String? value){
    selectedAddress = value ;
    update();
  }
  String? selectedAddressName;
  updateSelectedAddressName(String? value){
    selectedAddressName = value ;
    update();
  }
  String? selectedPaymentMethods;
  updateSelectedPaymentMethods(String? value){
    selectedPaymentMethods = value ;
    update();
  }
  String? selectedPaymentMethodsTitle;
  updateSelectedPaymentMethodsTitle(String? value){
    selectedPaymentMethodsTitle = value ;
    update();
  }
  int? shippingGroupValue;
  updateShippingGroupValue(int? value){
    shippingGroupValue = value ;
    update();
  }
  int? paymentGroupValue;

  //----------------------------- Image Picker ------------------------------
  final imagePicker = ImagePicker();
   File? selectedImage;

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        update();
    }
  }

  void removeImage() {
    selectedImage = null;
    update();
  }

}
