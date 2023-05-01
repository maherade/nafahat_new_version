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
  setAdminToken(String value) async {
    await sharedPreferences?.setString('adminToken', value);
  }

  String? getAdminToken() {
    String? x = sharedPreferences?.getString('adminToken');
    return x;
  }
  removeAdminToken() async {
    await sharedPreferences?.remove('adminToken');
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

  setUserId(String value) async {
   await sharedPreferences?.setString('userId', value);
  }

  String? getUserId() {
    String? x = sharedPreferences?.getString('userId');
    return x;
  }
  removeUserId() async {
   await sharedPreferences?.remove('userId');
  }





  setDefaultLanguage(String value) async {
    sharedPreferences?.setString('lang', value);
  }

  String? getDefaultLanguage() {
    String? defaultLang = sharedPreferences?.getString('lang');
    return defaultLang??'ar';
  }
  removeDefaultLanguage(){
    sharedPreferences?.remove('lang');
  }
}
