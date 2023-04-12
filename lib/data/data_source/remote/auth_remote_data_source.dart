import 'package:dio/dio.dart';
import 'package:promina_task/data/network/api_constants.dart';
import 'package:promina_task/data/network/http_utils.dart';

abstract class AuthRemoteDataSource {
  Future<Response> login(FormData formData);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpUtils httpUtils;
  const AuthRemoteDataSourceImpl({
    required this.httpUtils,
  });
  @override
  Future<Response> login(FormData formData) {
    return httpUtils.postForm(ApiConstants.login, formData);
  }
}
