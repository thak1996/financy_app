import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/secure_storage.dart';
import 'login.state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController(this._secureStorageService) : super(const LoginInitial());

  final SecureStorageService _secureStorageService;

  Future<void> login(String email, String password) async {
    emit(const LoginLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (email == 'teste@teste.com' && password == '12345678') {
        log('email: $email');
        log('password: $password');
        emit(const LoginSuccess());
      } else {
        emit(const LoginError('Email ou senha inválidos'));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
