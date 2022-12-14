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
    print(x);
    return x;
  }
  removeToken() async {
   await sharedPreferences?.remove('accessToken');
  }


  setActivation(String value) async {
    sharedPreferences?.setString('active', value);
  }

  String? getActivation() {
    String? active = sharedPreferences?.getString('active');
    return active;
  }
  cleatActivation(){
    sharedPreferences?.remove('active');
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
