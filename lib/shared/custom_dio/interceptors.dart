import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomIntercetors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? null;
    options.headers = {"Authorization": token};
    print(
        "REQUEST[${options.method}] => PATH: ${options.path} => DATA: ${options.data}");
    handler.next(options);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    //200
    //201
    print("RESPONSE[${response.statusCode}] => PATH: $response");
    handler.next(response);
  }

  @override
  onError(DioError e, ErrorInterceptorHandler handler) {
    //Exception
    print("ERROR[${e.response}] => PATH: $e");

    handler.next(e);
  }
}
