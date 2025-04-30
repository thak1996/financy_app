abstract class RegisterState {
  final int currentStep;

  const RegisterState({this.currentStep = 0});
}

class RegisterInitial extends RegisterState {
  const RegisterInitial({super.currentStep});
}

class RegisterLoading extends RegisterState {
  const RegisterLoading({super.currentStep});
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess({super.currentStep});
}

class RegisterError extends RegisterState {
  final String message;

  const RegisterError(this.message, {super.currentStep});
}
