import 'dart:io';

import 'package:dio/dio.dart';
import 'package:promina_task/data/network/api_constants.dart';
import 'package:promina_task/data/network/http_utils.dart';

abstract class ImageRemoteDataSource {
  Future<Response> getGallery();
  Future<Response> uploadImage(File image);
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  final HttpUtils httpUtils;
  const ImageRemoteDataSourceImpl({
    required this.httpUtils,
  });
  @override
  Future<Response> getGallery() {
    return httpUtils.get(ApiConstants.myGallery);
  }

  @override
  Future<Response> uploadImage(File image) async {
    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      "img": await MultipartFile.fromFile(image.path, filename: fileName),
    });
    return httpUtils.postForm(ApiConstants.uploadImage, formData);
  }
}
