import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/auth_firebase.service.dart';
import '../../../core/utils/secure_storage.dart';
import 'login.state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController(this._secureStorageService, this._authService)
    : super(const LoginInitial());

  final SecureStorage _secureStorageService;
  final AuthFirebaseService _authService;

  Future<void> login(String email, String password) async {
    emit(const LoginLoading());
    try {
      final result = await _authService.login(email: email, password: password);
      result.fold((success) {
        _secureStorageService.write(key: 'user', value: success.token ?? '');
        log(success.token ?? '');
        emit(const LoginSuccess());
      }, (failure) => emit(LoginError(failure.toString())));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
