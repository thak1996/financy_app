import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/user_credentials.model.dart';
import '../../../core/services/auth.service.dart';
import 'register.state.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController(this._authService) : super(RegisterInitial());

  final AuthService _authService;

  Future<void> register(UserCredentials userCredentials) async {
    emit(RegisterLoading());
    try {
      await _authService.register(
        userCredentials.name,
        email: userCredentials.email!,
        password: userCredentials.password!,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
