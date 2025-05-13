import 'package:result_dart/result_dart.dart';
import '../models/user_credentials.model.dart';

abstract class IAuthService {
  Future<UserCredentials> login();

  AsyncResult<UserCredentials> register(
    String? name, {
    required String email,
    required String password,
  });
}
