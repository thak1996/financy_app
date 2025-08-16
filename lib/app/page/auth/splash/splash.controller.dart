import 'package:financy_app/app/shared/utils/secure_storage.dart';
import 'package:financy_app/app/page/auth/splash/splash.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashController extends Cubit<SplashState> {
  SplashController(this._secureStorageService) : super(SplashInitial());

  final SecureStorage _secureStorageService;

  Future<void> checkAuth() async {
    emit(SplashLoading());
    try {
      final token = await _secureStorageService.read('user');
      if (token != null && token.isNotEmpty) {
        emit(SplashSuccess());
      } else {
        emit(SplashFailed());
      }
    } catch (e) {
      emit(SplashFailed());
    }
  }
}
