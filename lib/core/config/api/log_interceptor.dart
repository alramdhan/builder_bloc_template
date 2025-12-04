import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class CustomLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    sl<Logger>().d("REQUEST[${options.method}] => PATH: ${options.path}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    sl<Logger>().d("RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    sl<Logger>().d("ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions}");
    super.onError(err, handler);
  }
}