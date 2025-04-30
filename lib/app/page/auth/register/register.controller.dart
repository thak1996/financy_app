import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register.state.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController() : super(const RegisterInitial());

  Future<void> register(String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(RegisterLoading(currentStep: state.currentStep));
      log('email: $email');
      log('password: $password');
    } catch (e) {
      emit(RegisterError(e.toString(), currentStep: state.currentStep));
    }
  }

  @override
  Future<void> close() {
    reset();
    return super.close();
  }

  void nextStep() {
    if (state.currentStep < 1) {
      emit(RegisterInitial(currentStep: state.currentStep + 1));
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step <= 1) {
      emit(RegisterInitial(currentStep: step));
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(RegisterInitial(currentStep: state.currentStep - 1));
    }
  }

  void reset() => emit(const RegisterInitial());
}
