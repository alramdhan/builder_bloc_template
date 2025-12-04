import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Dio get dio => _dio;

  Future get(String path, {Map<String, dynamic>? data, Map<String, dynamic>? queryParams}) async {
    try {
      var res = await _dio.get(path, data: data, queryParameters: queryParams);

      return res;
    } on DioException catch(e) {
      throw Exception(e);
    } catch(e) {
      throw Exception(e);
    }
  }
}