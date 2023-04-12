import 'package:dio/dio.dart';

import '../../common/resources/strings_manager.dart';
import 'failure.dart';

Failure handleError(dynamic error) {
  // DioError exits only in errors like
  // [connectTimeout, sendTimeout, receiveTimeout, cancel, other]
  // [response] When the server response, but with a incorrect status, such as 404, 503...
  if (error is DioError) {
    return _handleDioError(error);
  } else {
    return ResponseStatus.unknown.getFailure();
  }
}

///  [_handleDioError] for handling Dio error enum only
dynamic _handleDioError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectionTimeout:
      return ResponseStatus.connectTimeout.getFailure();

    case DioErrorType.sendTimeout:
      return ResponseStatus.sendTimeout.getFailure();

    case DioErrorType.receiveTimeout:
      return ResponseStatus.receiveTimeout.getFailure();

    case DioErrorType.badResponse:
      int? statusCode = error.response?.statusCode;
      String? statusMessage = error.response?.statusMessage;

      return Failure(
          code: statusCode, message: statusMessage ?? 'Bad Response');

    case DioErrorType.badCertificate:
      int? statusCode = error.response?.statusCode;
      String? statusMessage = error.response?.statusMessage;
      return Failure(
          code: statusCode, message: statusMessage ?? 'Bad Certificate');

    case DioErrorType.connectionError:
      return const Failure(message: ResponseMessage.noInternetConnection);

    case DioErrorType.cancel:
      return ResponseStatus.cancel.getFailure();

    case DioErrorType.unknown:
      return ResponseStatus.unknown.getFailure();
  }
}

enum ResponseStatus {
  /// It occurs when url is opened timeout.
  connectTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  ///It occurs when receiving timeout.
  receiveTimeout,

  /// When the request is cancelled, dio will throw a error with this type.
  cancel,

  /// When No internet connection.
  noInternetConnection,

  /// Default error type, Some other Error. In this case, you can
  /// use the DioError.error if it is not null.
  unknown,
}

extension ResponseStatusExtensions on ResponseStatus {
  Failure getFailure() {
    switch (this) {
      case ResponseStatus.connectTimeout:
        return const Failure(
          code: ResponseCode.connectTimeout,
          message: ResponseMessage.connectTimeout,
        );

      case ResponseStatus.sendTimeout:
        return const Failure(
            code: ResponseCode.sendTimeout,
            message: ResponseMessage.sendTimeout);

      case ResponseStatus.receiveTimeout:
        return const Failure(
          code: ResponseCode.receiveTimeout,
          message: ResponseMessage.receiveTimeout,
        );

      case ResponseStatus.cancel:
        return const Failure(
            code: ResponseCode.cancel, message: ResponseMessage.cancel);

      case ResponseStatus.noInternetConnection:
        return const Failure(
          code: ResponseCode.noInternetConnection,
          message: ResponseMessage.noInternetConnection,
        );

      case ResponseStatus.unknown:
        return const Failure(
            code: ResponseCode.unknown, message: ResponseMessage.unknown);
    }
  }
}

// Have all possible response messages that can be local from DIO or From Api
class ResponseMessage {
  // local status message
  static const String connectTimeout = AppStrings.timeoutError;
  static const String cancel = AppStrings.cancel;
  static const String receiveTimeout = AppStrings.timeoutError;
  static const String sendTimeout = AppStrings.timeoutError;
  static const String noInternetConnection = AppStrings.noInternetError;
  static const String unknown = AppStrings.unknownError;
  static const String unAuthorized = AppStrings.wrongUsernamePassword;
}

// Have all possible response codes that can be local from DIO or From Api
class ResponseCode {
  // local status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int noInternetConnection = -6;
  static const int unknown = -7;

  static const int databaseError = -12;
  static const int sessionDenied = -8;
}
