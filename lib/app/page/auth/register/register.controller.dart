import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/user_credentials.model.dart';
import '../../../core/services/auth.service.dart';
import 'register.state.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController(this._authService) : super(RegisterInitial());

  final AuthService _authService;

  Future<void> register(UserCredentials userCredentials) async {
    try {
      emit(RegisterLoading());
      final result = await _authService.register(
        userCredentials.name,
        email: userCredentials.email!,
        password: userCredentials.password!,
      );
      result.fold(
        (success) => emit(RegisterSuccess()),
        (failure) => emit(RegisterError(failure.toString())),
      );
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
