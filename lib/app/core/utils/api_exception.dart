abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, [this.statusCode]);

  @override
  String toString() => message;

  static AppException fromStatusCode(int? statusCode, String message) {
    switch (statusCode) {
      case 400:
        return ValidationException('Dados inválidos: $message', statusCode);
      case 401:
        return UnauthorizedException('Não autorizado: $message', statusCode);
      case 403:
        return ForbiddenException('Acesso negado: $message', statusCode);
      case 404:
        return NotFoundException(
          'Recurso não encontrado: $message',
          statusCode,
        );
      case 405:
        return MethodNotAllowedException('Método não permitido', statusCode);
      case 408:
        return TimeoutException('Tempo limite excedido', statusCode);
      case 409:
        return ConflictException('Conflito de dados: $message', statusCode);
      case 422:
        return ValidationException('Erro de validação: $message', statusCode);
      case 429:
        return RateLimitException(
          'Muitas requisições. Tente novamente mais tarde',
          statusCode,
        );
      case 500:
        return ServerException('Erro interno do servidor', statusCode);
      case 501:
        return ServerException('Funcionalidade não implementada', statusCode);
      case 502:
        return ServerException('Gateway inválido', statusCode);
      case 503:
        return ServiceUnavailableException('Serviço indisponível', statusCode);
      case 504:
        return GatewayTimeoutException(
          'Tempo limite do gateway excedido',
          statusCode,
        );
      case 0:
        return NetworkException('Erro de conexão', statusCode);
      case -1:
        return TimeoutException('Tempo limite excedido', statusCode);
      default:
        return GeneralException('Erro inesperado: $message', statusCode);
    }
  }

  static String messageFromStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Requisição inválida.';
      case 401:
        return 'Usuário ou senha inválidos.';
      case 404:
        return 'Recurso não encontrado.';
      case 500:
        return 'Erro interno do servidor.';
      default:
        return 'Erro inesperado.';
    }
  }
}

class GeneralException extends AppException {
  GeneralException(super.message, [super.statusCode]);
}

class NetworkException extends AppException {
  NetworkException(super.message, [super.statusCode]);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(super.message, [super.statusCode]);
}

class NotFoundException extends AppException {
  NotFoundException(super.message, [super.statusCode]);
}

class ValidationException extends AppException {
  ValidationException(super.message, [super.statusCode]);
}

class ServerException extends AppException {
  ServerException(super.message, [super.statusCode]);
}

class ForbiddenException extends AppException {
  ForbiddenException(super.message, [super.statusCode]);
}

class MethodNotAllowedException extends AppException {
  MethodNotAllowedException(super.message, [super.statusCode]);
}

class TimeoutException extends AppException {
  TimeoutException(super.message, [super.statusCode]);
}

class ConflictException extends AppException {
  ConflictException(super.message, [super.statusCode]);
}

class RateLimitException extends AppException {
  RateLimitException(super.message, [super.statusCode]);
}

class ServiceUnavailableException extends AppException {
  ServiceUnavailableException(super.message, [super.statusCode]);
}

class GatewayTimeoutException extends AppException {
  GatewayTimeoutException(super.message, [super.statusCode]);
}
