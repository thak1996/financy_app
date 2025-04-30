import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/secure_storage.dart';
import 'login.state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController(this._secureStorageService) : super(const LoginInitial());

  final SecureStorageService _secureStorageService;

  void validateFields(String email, String password) {
    final isValid = email.isNotEmpty && password.isNotEmpty;
    emit(LoginInitial(isValid: isValid));
  }

  Future<void> login(String email, String password) async {
    emit(const LoginLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      log('email: $email');
      log('password: $password');
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
