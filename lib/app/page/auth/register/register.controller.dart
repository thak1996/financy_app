import 'package:flutter_bloc/flutter_bloc.dart';
import 'register.state.dart';
import 'dart:developer';

class RegisterController extends Cubit<RegisterState> {
  RegisterController() : super(RegisterInitial());

  Future<void> register(String email, String password, String name) async {
    emit(RegisterLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (email == 'teste@teste.com' &&
          password == '12345678' &&
          name == 'teste') {
        log('email: $email');
        log('password: $password');
        log('name: $name');
        emit(RegisterSuccess());
      } else {
        emit(RegisterError('Informações Incorretas'));
      }
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
