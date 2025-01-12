import 'error_handler.dart';

/// Abstract class to represent different failure types in the app.
abstract class Failure {
  final String message;
  final String? code;

  Failure({required this.message, this.code});

  @override
  String toString() => 'Failure(code: $code, message: $message)';
}

class NetworkFailure extends Failure {
  NetworkFailure({super.message = 'Network failure occurred.'});
}

class TimeoutFailure extends Failure {
  TimeoutFailure({super.message = 'Request timed out.'});
}

class AuthenticationFailure extends Failure {
  AuthenticationFailure({super.message = 'Authentication failed.'});
}

class ServerFailure extends Failure {
  ServerFailure({super.message = 'Server error occurred.'});
}

class ValidationFailure extends Failure {
  ValidationFailure({required super.message});
}

class UnknownFailure extends Failure {
  UnknownFailure({super.message = 'An unknown error occurred.'});
}

/// A helper class to map exceptions into `Failure` instances.
class FailureMapper {
  /// Converts exceptions into a Failure object.
  static Failure map(dynamic exception) {
    if (exception is NetworkError) {
      return NetworkFailure(message: exception.message);
    } else if (exception is TimeoutError) {
      return TimeoutFailure(message: exception.message);
    } else if (exception is AuthenticationError) {
      return AuthenticationFailure(message: exception.message);
    } else if (exception is AppError) {
      return ValidationFailure(message: exception.message);
    } else {
      return UnknownFailure();
    }
  }
}
