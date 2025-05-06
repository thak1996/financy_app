import 'package:flutter_bloc/flutter_bloc.dart';
import 'register.state.dart';
import 'dart:developer';

class RegisterController extends Cubit<RegisterState> {
  RegisterController() : super(RegisterInitial());

  Future<void> register(String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(RegisterLoading());
      log('email: $email');
      log('password: $password');
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
