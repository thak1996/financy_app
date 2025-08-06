import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/user.model.dart';
import '../../../core/services/auth_firebase.service.dart';
import '../../../core/utils/secure_storage.dart';
import 'register.state.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController(this._authService, this._secureStorageService)
    : super(RegisterInitial());

  final AuthFirebaseService _authService;
  final SecureStorage _secureStorageService;

  Future<void> register(UserModel userCredentials) async {
    try {
      emit(RegisterLoading());
      final response = await _authService.register(
        userCredentials.name,
        email: userCredentials.email!,
        password: userCredentials.password!,
      );
      response.fold((success) {
        _secureStorageService.write(key: 'user', value: success.token ?? '');
        emit(RegisterSuccess());
      }, (failure) => emit(RegisterError(failure.toString())));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
