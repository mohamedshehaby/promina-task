import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_constants.dart';

class HttpUtils {
  final Dio dio = Dio();

  HttpUtils() {
    Map<String, String> headers = {
      Headers.contentTypeHeader: Headers.jsonContentType,
      Headers.acceptHeader: Headers.jsonContentType,
      'Authorization': 'Bearer ${ApiConstants.token}'
    };

    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: headers,
      receiveTimeout: const Duration(seconds: ApiConstants.apiTimeOut),
      sendTimeout: const Duration(seconds: ApiConstants.apiTimeOut),
    );

    // If app not released yet print all request and response info in log
    if (!kReleaseMode) {
      /// [PrettyDioLogger] for print the request and response in log
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }
  }
  Future<Response> get(String url, [Map<String, dynamic>? params]) {
    return dio.get(url, queryParameters: params ?? {});
  }

  Future<Response> post(String url, [Map<String, dynamic>? params]) {
    return dio.post(url, data: params ?? {});
  }

  Future<Response> postForm(String url, FormData params) {
    return dio.post(url, data: params);
  }
}
