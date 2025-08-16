import 'package:result_dart/result_dart.dart';
import '../models/user.model.dart';

abstract class IAuthService {
  AsyncResult<UserModel> login({
    required String email,
    required String password,
  });

  AsyncResult<UserModel> register(
    String? name, {
    required String email,
    required String password,
  });

  AsyncResult<Unit> logout();

  Future<String?> getIdToken({bool forceRefresh = false});
}
