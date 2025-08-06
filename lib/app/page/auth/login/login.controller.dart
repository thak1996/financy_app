import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/auth_firebase.service.dart';
import 'login.state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController(this._authService) : super(const LoginInitial());

  final AuthFirebaseService _authService;

  Future<void> login(String email, String password) async {
    emit(const LoginLoading());
    try {
      final result = await _authService.login(email: email, password: password);
      result.fold(
        (success) => emit(const LoginSuccess()),
        (failure) => emit(LoginError(failure.toString())),
      );
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
