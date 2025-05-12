import '../models/user_credentials.model.dart';

abstract class IAuthService {
  Future<UserCredentials> login();
  
  Future<UserCredentials> register(
    String? name, {
    required String email,
    required String password,
  });
}
