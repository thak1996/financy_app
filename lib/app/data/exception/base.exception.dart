abstract class BaseException implements Exception {
  final String message;
  final String? statusCode;

  const BaseException(this.message, [this.statusCode]);

  String get code => statusCode ?? 'unknown';

  @override
  String toString() => message;
}
