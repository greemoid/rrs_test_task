import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? debugMessage;
  final StackTrace? stackTrace;

  const Failure(this.message, {this.debugMessage, this.stackTrace});

  @override
  List<Object?> get props => [message, debugMessage, stackTrace];

  @override
  String toString() => '$runtimeType: $debugMessage';
}

class NetworkFailure extends Failure {
  const NetworkFailure({String? debugMessage, StackTrace? stackTrace})
    : super(
        'Check your internet connection.',
        debugMessage: debugMessage,
        stackTrace: stackTrace,
      );
}

class ServerFailure extends Failure {
  const ServerFailure({String? debugMessage, StackTrace? stackTrace})
    : super(
        'The server is temporarily unavailable. Please try again later.',
        debugMessage: debugMessage,
        stackTrace: stackTrace,
      );
}

class UnknownFailure extends Failure {
  const UnknownFailure({String? debugMessage, StackTrace? stackTrace})
    : super(
        'An unexpected error occurred. We are already working on fixing it.',
        debugMessage: debugMessage,
        stackTrace: stackTrace,
      );
}
