import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:promina_task/data/data_source/remote/auth_remote_data_source.dart';
import 'package:promina_task/data/data_source/remote/image_remote_data_source.dart';
import 'package:promina_task/data/network/http_utils.dart';
import 'package:promina_task/domain/repositories/auth_repository.dart';
import 'package:promina_task/presentation/blocs/gallery/gallery_bloc.dart';

import '../../data/network/network_info.dart';
import '../../domain/repositories/image_repository.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/images/image_bloc.dart';

final instance = GetIt.I;

Future init() async {
  /// [Http Utils]
  instance.registerLazySingleton<HttpUtils>(() => HttpUtils());

  /// [NetworkInfo]
  /// [InternetConnectionChecker] singleton by default
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  /// [Data Sources]
  /// [Auth Data Source]
  instance.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(httpUtils: instance()));

  instance.registerLazySingleton<ImageRemoteDataSource>(
      () => ImageRemoteDataSourceImpl(httpUtils: instance()));

  /// [Repositories]
  /// [Auth Repository]
  instance.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      networkInfo: instance(), authRemoteDataSource: instance()));

  instance.registerLazySingleton<ImageRepository>(() => ImageRepositoryImpl(
      networkInfo: instance(), imageRemoteDataSource: instance()));

  /// [Blocs]
  /// [Auth Bloc]
  instance
      .registerFactory<AuthBloc>(() => AuthBloc(authRepository: instance()));

  instance.registerFactory<GalleryBloc>(
      () => GalleryBloc(imageRepository: instance()));

  instance.registerFactory<ImageBloc>(() => ImageBloc(instance()));
  instance.registerLazySingleton<Logger>(() => Logger());
}
