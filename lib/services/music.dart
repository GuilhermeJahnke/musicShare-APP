// import 'package:dio/dio.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:musicShare/shared/custom_dio/custom_dio.dart';
// import 'package:dv_invest/models/auth_model.dart';

class MusicService {
  final _client = new CustomDio().instance;

  Future login(params) async {
    try {
      var response = await _client.post("login/", data: params);

      return response;
    } on DioError catch (error) {
      print('error: $error');
      return error.response;
    } on SocketException catch (error) {
      print('No net $error');
    }
    return null;
  }
}
