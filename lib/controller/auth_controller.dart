

import 'package:get/get.dart';

import '../model/user_response.dart';
import '../model/view_all_information_about_customer_response.dart';




class AuthController extends GetxController{
  Rx<ListViewAllInformationAboutCustomerResponse>? getCustomerInformationData = ListViewAllInformationAboutCustomerResponse().obs;
}