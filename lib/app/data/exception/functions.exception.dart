import 'base.exception.dart';

class FunctionsException extends BaseException {
  const FunctionsException(super.message, [super.code]);

  factory FunctionsException.unknownError() =>
      const FunctionsException('Unknown error occurred', 'unknown');

  factory FunctionsException.invalidArgument() =>
      const FunctionsException('Invalid argument provided', 'invalid-argument');

  factory FunctionsException.notFound() =>
      const FunctionsException('Resource not found', 'not-found');

  factory FunctionsException.permissionDenied() =>
      const FunctionsException('Permission denied', 'permission-denied');

  factory FunctionsException.unauthenticated() =>
      const FunctionsException('User not authenticated', 'unauthenticated');

  factory FunctionsException.deadlineExceeded() =>
      const FunctionsException('Deadline exceeded', 'deadline-exceeded');

  factory FunctionsException.alreadyExists() =>
      const FunctionsException('Resource already exists', 'already-exists');

  factory FunctionsException.resourceExhausted() =>
      const FunctionsException('Resource exhausted', 'resource-exhausted');

  factory FunctionsException.cancelled() =>
      const FunctionsException('The operation was cancelled', 'cancelled');

  factory FunctionsException.unavailable() =>
      const FunctionsException('Service unavailable', 'unavailable');

  factory FunctionsException.internal() =>
      const FunctionsException('Internal server error', 'internal');

  factory FunctionsException.dataLoss() =>
      const FunctionsException('Unrecoverable data loss', 'data-loss');
}
