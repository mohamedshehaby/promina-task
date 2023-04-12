import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:promina_task/common/resources/strings_manager.dart';
import 'package:promina_task/data/data_source/remote/auth_remote_data_source.dart';
import 'package:promina_task/data/network/error_handler.dart';
import 'package:promina_task/data/network/failure.dart';

import '../../data/network/network_info.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(Map<String, dynamic> loginFormMap);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  const AuthRepositoryImpl({
    required this.networkInfo,
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> login(
      Map<String, dynamic> loginFormMap) async {
    FormData formData = FormData.fromMap(
        {'email': loginFormMap['email'], 'password': loginFormMap['password']});

    if (await networkInfo.isConnected) {
      try {
        final response = await authRemoteDataSource.login(formData);
        if (response.data['user'] != null && response.statusCode == 200) {
          final user = UserEntity(
              id: response.data['user']['id'],
              email: response.data['user']['email'],
              name: response.data['user']['name'],
              token: response.data['token']);
          return Right(user);
        } else if (response.data['error_message'] != null) {
          return const Left(Failure(message: AppStrings.wrongUsernamePassword));
        } else {
          return Left(ResponseStatus.unknown.getFailure());
        }
      } catch (e) {
        return Left(handleError(e));
      }
    } else {
      return Left(ResponseStatus.noInternetConnection.getFailure());
    }
  }
}
