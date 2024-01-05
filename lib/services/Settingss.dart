import 'package:dio/dio.dart';
import 'package:perfume_store_mobile_app/services/sp_helper.dart';

class Settingss {
  Settingss._();

  static Settingss settings = Settingss._();

  //TODO Add Base Api Url Here Only
  final String baseurl =
      'https://nafahat.com/wp-content/plugins/nafahat/rest/v1/';

  Dio? dio;

  initDio() {
    dio = Dio();
    dio!.options.baseUrl = baseurl;

    //* delete authorization
    // dio!.options.headers = {
    //   'authorization':
    //       'Basic ${base64.encode(utf8.encode('$username:$password'))}'
    // };
    dio!.options.receiveTimeout = 100000;
  }

  Map<String, dynamic> getHeaders() {
    String? token = SPHelper.spHelper.getToken();

    Map<String, dynamic> headers = token == null
        ? {}
        : {
            //* delete authorization
            // 'authorization':
            //     'Basic ${base64.encode(utf8.encode('$username:$password'))}'
          };
    return headers;
  }
}
