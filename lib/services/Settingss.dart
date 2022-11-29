import 'package:dio/dio.dart';
import 'package:perfume_store_mobile_app/services/sp_helper.dart';

class Settingss {
  Settingss._();
  static Settingss settings = Settingss._();
  //TODO Add Base Api Url Here Only
  final String baseurl = 'http://18.215.180.224/api/';
  Dio? dio;
  initDio() {
    dio = Dio();
    dio!.options.baseUrl = baseurl;
    dio!.options.headers = getHeaders();
  }

  Map<String, dynamic> getHeaders() {
    String? token = SPHelper.spHelper.getToken();
    Map<String, dynamic> headers = token == null
        ? {'Content-Type': 'application/json',"Accept-Language":"ar"}
        : {
            'Content-Type': 'application/json',
            "Accept-Language":"ar",
            'Authorization': token
          };
    return headers;
  }
}
