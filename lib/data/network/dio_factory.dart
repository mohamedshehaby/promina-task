import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_constants.dart';

const String applicationJson = 'application/json';
const String contentType = 'content-type';
const String accept = 'accept';
const String authorization = 'authorization';
const String language = 'language';
const String apiKey = 'api_key';

Future<Dio> getDio() async {
  final Dio dio = Dio();

  Map<String, String> headers = {
    contentType: applicationJson,
    accept: applicationJson,
    authorization: 'Bearer ${ApiConstants.token}'
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
  return dio;
}
