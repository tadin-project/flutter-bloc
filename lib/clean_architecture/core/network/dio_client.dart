import 'package:dio/dio.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(BaseOptions(
      baseUrl: "http://localhost:3501/api/v1",
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    dynamic data,
  }) async {
    return await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      data: data,
    );
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    dynamic data,
  }) async {
    return await dio.post(
      path,
      queryParameters: queryParameters,
      options: options,
      data: data,
    );
  }

  Future<Response> put(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    dynamic data,
  }) async {
    return await dio.put(
      path,
      queryParameters: queryParameters,
      options: options,
      data: data,
    );
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    dynamic data,
  }) async {
    return await dio.delete(
      path,
      queryParameters: queryParameters,
      options: options,
      data: data,
    );
  }
}
