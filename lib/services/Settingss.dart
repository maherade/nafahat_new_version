import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:perfume_store_mobile_app/services/sp_helper.dart';

class Settingss {
  Settingss._();
  static Settingss settings = Settingss._();
  //TODO Add Base Api Url Here Only
  final String baseurl = 'https://nafahat.com/wp-content/plugins/nafahat/rest/v1/';
  String username = 'ck_54b7ebd52fd718be81cb1043637c84732aa1705c';
  String password = 'cs_df50caa82b6d05266923b0f9a6e2aaa000960410';

  Dio? dio;
  initDio() {
    dio = Dio();
    dio!.options.baseUrl = baseurl;
     dio!.options.headers = {
       'authorization': 'Basic ${base64.encode(utf8.encode('$username:$password'))}'
     };
     dio!.options.receiveTimeout = 10000;
  }

  Map<String, dynamic> getHeaders() {
    String? token = SPHelper.spHelper.getToken();
    print(token);
    Map<String, dynamic> headers = token == null
        ? {}
        : {
      'authorization': 'Basic ${base64.encode(utf8.encode('$username:$password'))}'
    };
    return headers;
  }
}
