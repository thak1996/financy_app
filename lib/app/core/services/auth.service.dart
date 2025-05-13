import 'package:result_dart/result_dart.dart';
import 'package:template_bloc/app/core/models/user_credentials.model.dart';
import '../interfaces/auth.interface.dart';

class AuthService implements IAuthService {
  @override
  Future<UserCredentials> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  AsyncResult<UserCredentials> register(
    String? name, {
    required String email,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (password.startsWith('123')) {
        return Failure(Exception('Invalid password'));
      }
      // throw Exception('Error');
      return Success(
        UserCredentials(id: email.hashCode, email: email, password: password),
      );
    } catch (e) {
      return Failure(e as Exception);
    }
  }
}
