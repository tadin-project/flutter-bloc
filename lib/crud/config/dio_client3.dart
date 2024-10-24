import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {
  final String baseUrl = "http://localhost:3501/api/v1";
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://localhost:3501/api/v1",
        connectTimeout: const Duration(milliseconds: 5000), // 5 seconds
        receiveTimeout: const Duration(milliseconds: 5000), // 5 seconds
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    );

    // Add Interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Log request or modify it before sending
        debugPrint("REQUEST[${options.method}] => PATH: ${options.path}");
        return handler.next(options); // Continue to the next handler
      },
      onResponse: (response, handler) {
        // Log response or process it
        debugPrint(
            "RESPONSE[${response.statusCode}] => DATA: ${response.data}");
        return handler.next(response); // Continue to the next handler
      },
      onError: (DioException error, handler) async {
        // Log error details
        debugPrint(
            "ERROR[${error.response?.statusCode}] => MESSAGE: ${error.message}");

        // Handle different types of errors
        if (error.type == DioExceptionType.connectionTimeout) {
          debugPrint(
              'Connection Timeout! Please check your internet connection.');
        } else if (error.type == DioExceptionType.receiveTimeout) {
          debugPrint('Receive Timeout! Server took too long to respond.');
        } else if (error.type == DioExceptionType.badResponse) {
          switch (error.response?.statusCode) {
            case 400:
              debugPrint('Bad Request: ${error.response?.data}');
              break;
            case 401:
              debugPrint('Unauthorized! Token expired or invalid.');
              break;
            case 403:
              debugPrint('Forbidden! You do not have access.');
              break;
            case 404:
              debugPrint('Not Found: ${error.response?.data}');
              break;
            case 500:
              debugPrint('Internal Server Error: ${error.response?.data}');
              break;
            default:
              debugPrint('Unknown Error: ${error.response?.data}');
          }
        } else if (error.type == DioExceptionType.cancel) {
          debugPrint('Request to ${error.requestOptions.uri} was cancelled.');
        } else if (error.type == DioExceptionType.unknown) {
          debugPrint('Unknown Error occurred. Check your network or server.');
        }

        return handler.next(error); // Continue to the next handler
      },
    ));
    // dio = Dio(BaseOptions(baseUrl: "http://localhost:3501/api/v1"));
    // dio = Dio();
  }

  // Method to set the token
  void setToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Method to clear the token
  void clearToken() {
    dio.options.headers.remove('Authorization');
  }

  ///[GET] We will use this method inorder to process get requests
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    debugPrint("GETTING API FROM : ${baseUrl + path}");
    debugPrint("QUERY PARAMS=>$queryParameters");
    return await dio.get(baseUrl + path,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        options: options,
        queryParameters: queryParameters);
  }

  ///[POST] We will use this method inorder to process post requests
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool addRequestInterceptor = true,
  }) async {
    debugPrint("URL : ${baseUrl + path}");
    debugPrint("Request body : $data");
    return await dio.post(
      baseUrl + path,
      // data: FormData.fromMap(data),
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
    // return await Dio().post(baseUrl + path, data: FormData.fromMap(data));
  }
}
