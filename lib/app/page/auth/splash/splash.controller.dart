import 'package:financy_app/app/core/utils/secure_storage.dart';
import 'package:financy_app/app/core/utils/log_printer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'splash.state.dart';

class SplashController extends Cubit<SplashState> {
  SplashController(this._secureStorageService) : super(SplashInitial());

  final SecureStorage _secureStorageService;
  final Logger _logger = Logger(printer: LoggerPrinter('SplashController'));

  Future<void> checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _logger.i('Iniciando verificação de autenticação...');
    emit(SplashLoading());
    try {
      final token = await _secureStorageService.read('user');
      if (token != null && token.isNotEmpty) {
        _logger.i('Usuário está logado');
        emit(LoginSuccess());
      } else {
        _logger.w('Usuário não está logado');
        emit(LoginFailed());
      }
    } catch (e) {
      _logger.e('Erro ao verificar autenticação: $e');
      emit(LoginFailed());
    }
  }
}
