import 'package:financy_app/app/data/exception/base.exception.dart';

class AppException extends BaseException {
  final Exception? originalException;
  final StackTrace? stackTrace;

  const AppException({
    required String message,
    String? code,
    this.originalException,
    this.stackTrace,
  }) : super(message, code);

  factory AppException.fromStatusCode(int code, String message) {
    return AppException(message: message, code: code.toString());
  }

  @override
  String toString() {
    return 'AppException(message: $message, code: $code, originalException: $originalException)';
  }
}
