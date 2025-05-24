import 'package:dio/dio.dart';

import 'failure.dart';

Failure mapExceptionToFailure(Object exception, [StackTrace? stackTrace]) {
  if (exception is DioException) {
    final msg = exception.message;
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return NetworkFailure(debugMessage: msg, stackTrace: stackTrace);
      case DioExceptionType.badResponse:
        return ServerFailure(debugMessage: msg, stackTrace: stackTrace);
      default:
        return UnknownFailure(debugMessage: msg, stackTrace: stackTrace);
    }
  }

  return UnknownFailure(
    debugMessage: exception.toString(),
    stackTrace: stackTrace,
  );
}
