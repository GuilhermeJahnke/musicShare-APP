import 'package:dio/dio.dart';
import 'package:musicShare/env/enviroment.dart';
import 'package:musicShare/shared/custom_dio/interceptors.dart';

class CustomDio {
  var dio;
  CustomDio() {
    dio = Dio();
    dio.options.baseUrl = BASE_URL;
    dio.interceptors.add(CustomIntercetors());
    dio.options.connectTimeout = 15000;
    // dio.options.heades.add({'Access-Control-Allow-Origin': '*'});
  }
  Dio get instance => dio;
}
