import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  SPHelper._();
  static SPHelper spHelper = SPHelper._();

  SharedPreferences? sharedPreferences;

  Future<SharedPreferences> initSharedPrefrences() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences!;
    } else {
      return sharedPreferences!;
    }
  }

  setToken(String value) async {
   await sharedPreferences?.setString('accessToken', value);
  }

  String? getToken() {
    String? x = sharedPreferences?.getString('accessToken');
    return x;
  }
  removeToken() async {
   await sharedPreferences?.remove('accessToken');
  }


  setPaymentHtml(String value) async {
    sharedPreferences?.setString('PaymentHtml', value);
  }

  String? getPaymentHtml() {
    String? active = sharedPreferences?.getString('PaymentHtml');
    return active;
  }
  clearPaymentHtml(){
    sharedPreferences?.remove('PaymentHtml');
  }


  setUserType(String value) async {
    sharedPreferences?.setString('userType', value);
  }
  String? getUserType() {
    String? active = sharedPreferences?.getString('userType');
    return active;
  }
  cleatUserType(){
    sharedPreferences?.remove('userType');
  }
}
