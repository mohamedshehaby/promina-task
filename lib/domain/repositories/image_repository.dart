import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:promina_task/data/network/error_handler.dart';
import 'package:promina_task/data/network/failure.dart';

import '../../data/data_source/remote/image_remote_data_source.dart';
import '../../data/network/network_info.dart';

abstract class ImageRepository {
  Future<Either<Failure, List>> getGallery();
  Future<Either<Failure, String>> uploadImage(File image);
}

class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDataSource imageRemoteDataSource;
  final NetworkInfo networkInfo;

  const ImageRepositoryImpl({
    required this.networkInfo,
    required this.imageRemoteDataSource,
  });

  @override
  Future<Either<Failure, List>> getGallery() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await imageRemoteDataSource.getGallery();

        if (response.statusCode == 200 &&
            response.data['status'] == 'success') {
          return Right(response.data['data']['images']);
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

  @override
  Future<Either<Failure, String>> uploadImage(File image) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await imageRemoteDataSource.uploadImage(image);

        if (response.statusCode == 200 ||
            response.data['status'] == 'success') {
          return Right(response.data['message']);
        } else if (response.statusCode == 422) {
          return Left(Failure(message: response.data['errors']['img'][0]));
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
