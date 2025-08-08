import 'package:financy_app/app/data/exception/base.exception.dart';

class AppException extends BaseException {
  const AppException(super.message, [super.code]);

  factory AppException.fromStatusCode(int code, String message) {
    return AppException(message, code.toString());
  }
}
