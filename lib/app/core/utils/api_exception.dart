import 'package:firebase_auth/firebase_auth.dart';

abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, [this.statusCode]);

  @override
  String toString() => message;

  /// Creates an exception based on HTTP status code
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

  /// Maps Firebase Auth exceptions to custom exceptions
  static AppException fromFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      // Authentication errors
      case 'user-not-found':
        return NotFoundException('Usuário não encontrado', 404);
      case 'wrong-password':
        return UnauthorizedException('Senha incorreta', 401);
      case 'invalid-credential':
        return UnauthorizedException('Credenciais inválidas', 401);
      case 'user-disabled':
        return ForbiddenException('Usuário desabilitado', 403);
      case 'requires-recent-login':
        return UnauthorizedException('Operação requer login recente', 401);
      case 'invalid-api-key':
        return UnauthorizedException('Chave de API inválida', 401);
      case 'multi-factor-auth-required':
        return UnauthorizedException(
          'Autenticação de múltiplos fatores obrigatória',
          401,
        );

      // Validation errors
      case 'invalid-email':
        return ValidationException('Email inválido', 400);
      case 'weak-password':
        return ValidationException('Senha muito fraca', 400);
      case 'missing-email':
        return ValidationException('Email é obrigatório', 400);
      case 'missing-password':
        return ValidationException('Senha é obrigatória', 400);
      case 'invalid-phone-number':
        return ValidationException('Número de telefone inválido', 400);
      case 'missing-phone-number':
        return ValidationException('Número de telefone é obrigatório', 400);
      case 'invalid-verification-code':
        return ValidationException('Código de verificação inválido', 400);
      case 'invalid-verification-id':
        return ValidationException('ID de verificação inválido', 400);
      case 'captcha-check-failed':
        return ValidationException('Falha na verificação de captcha', 400);
      case 'email-change-needs-verification':
        return ValidationException('Mudança de email requer verificação', 400);
      case 'maximum-second-factor-count-exceeded':
        return ValidationException(
          'Número máximo de fatores secundários excedido',
          400,
        );

      // Conflict errors
      case 'email-already-in-use':
        return ConflictException('Email já está em uso', 409);
      case 'credential-already-in-use':
        return ConflictException('Credencial já está em uso', 409);
      case 'account-exists-with-different-credential':
        return ConflictException(
          'Conta já existe com credencial diferente',
          409,
        );

      // Permission errors
      case 'operation-not-allowed':
        return MethodNotAllowedException('Operação não permitida', 405);
      case 'app-not-authorized':
        return ForbiddenException('App não autorizado', 403);
      case 'tenant-id-mismatch':
        return ForbiddenException('ID do inquilino não corresponde', 403);

      // Rate limiting errors
      case 'too-many-requests':
        return RateLimitException(
          'Muitas tentativas. Tente novamente mais tarde',
          429,
        );
      case 'quota-exceeded':
        return RateLimitException(
          'Cota excedida. Tente novamente mais tarde',
          429,
        );

      // Timeout errors
      case 'timeout':
        return TimeoutException('Tempo limite excedido', 408);

      // Network errors
      case 'network-request-failed':
        return NetworkException('Erro de conexão com a internet', 0);

      // Server errors
      case 'internal-error':
      case 'unknown-error':
        return ServerException('Erro interno do servidor', 500);
      case 'keychain-error':
        return ServerException('Erro interno do sistema', 500);
      case 'web-storage-unsupported':
        return ServerException('Armazenamento web não suportado', 501);

      // Resource not found errors
      case 'app-not-installed':
        return NotFoundException('Aplicativo não encontrado', 404);

      default:
        return GeneralException(
          'Erro de autenticação: ${e.message ?? e.code}',
          null,
        );
    }
  }
}

class GeneralException extends AppException {
  const GeneralException(super.message, [super.statusCode]);
}

class NetworkException extends AppException {
  const NetworkException(super.message, [super.statusCode]);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message, [super.statusCode]);
}

class NotFoundException extends AppException {
  const NotFoundException(super.message, [super.statusCode]);
}

class ValidationException extends AppException {
  const ValidationException(super.message, [super.statusCode]);
}

class ServerException extends AppException {
  const ServerException(super.message, [super.statusCode]);
}

class ForbiddenException extends AppException {
  const ForbiddenException(super.message, [super.statusCode]);
}

class MethodNotAllowedException extends AppException {
  const MethodNotAllowedException(super.message, [super.statusCode]);
}

class TimeoutException extends AppException {
  const TimeoutException(super.message, [super.statusCode]);
}

class ConflictException extends AppException {
  const ConflictException(super.message, [super.statusCode]);
}

class RateLimitException extends AppException {
  const RateLimitException(super.message, [super.statusCode]);
}

class ServiceUnavailableException extends AppException {
  const ServiceUnavailableException(super.message, [super.statusCode]);
}

class GatewayTimeoutException extends AppException {
  const GatewayTimeoutException(super.message, [super.statusCode]);
}
