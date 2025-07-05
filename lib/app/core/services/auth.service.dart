import 'package:result_dart/result_dart.dart';
import '../interfaces/auth.interface.dart';
import '../models/user_credentials.model.dart';

class AuthService implements IAuthService {
  @override
  AsyncResult<UserCredentials> login({
    required String email,
    required String password,
    String? token,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (email == 'teste@teste.com' && password == '12345678') {
        return Success(
          UserCredentials(email: email, password: password, token: token),
        );
      }
      return Failure(Exception('Invalid email or password'));
    } catch (e) {
      return Failure(e as Exception);
    }
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
        UserCredentials(
          id: email.hashCode,
          email: email,
          password: password,
          name: name,
        ),
      );
    } catch (e) {
      return Failure(e as Exception);
    }
  }
}
