import 'package:result_dart/result_dart.dart';
import '../models/user_credentials.model.dart';

abstract class IAuthService {
  AsyncResult<UserCredentials> login({
    required String email,
    required String password,
  });

  AsyncResult<UserCredentials> register(
    String? name, {
    required String email,
    required String password,
  });
}
