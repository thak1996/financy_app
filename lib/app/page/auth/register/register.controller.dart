import 'package:financy_app/app/core/exports.dart';
import 'package:financy_app/app/page/exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
