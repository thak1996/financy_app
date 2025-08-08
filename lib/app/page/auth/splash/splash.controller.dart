import 'package:financy_app/app/shared/utils/log_printer.dart';
import 'package:financy_app/app/shared/utils/secure_storage.dart';
import 'package:financy_app/app/page/auth/splash/splash.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

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
        emit(SplashSuccess());
      } else {
        _logger.w('Usuário não está logado');
        emit(SplashFailed());
      }
    } catch (e) {
      _logger.e('Erro ao verificar autenticação: $e');
      emit(SplashFailed());
    }
  }
}
