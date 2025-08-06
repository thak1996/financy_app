import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/user.model.dart';
import '../../../core/services/auth_firebase.service.dart';
import 'register.state.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController(this._authService) : super(RegisterInitial());

  final AuthFirebaseService _authService;

  Future<void> register(UserModel userCredentials) async {
    try {
      emit(RegisterLoading());
      final response = await _authService.register(
        userCredentials.name,
        email: userCredentials.email!,
        password: userCredentials.password!,
      );
      response.fold(
        (success) => emit(RegisterSuccess()),
        (failure) => emit(RegisterError(failure.toString())),
      );
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
