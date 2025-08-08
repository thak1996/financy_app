import 'package:financy_app/app/data/exception/app.exception.dart';
import 'package:financy_app/app/data/exception/auth.exception.dart';
import 'package:financy_app/app/data/interfaces/auth.interface.dart';
import 'package:financy_app/app/shared/utils/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:result_dart/result_dart.dart';
import '../models/user.model.dart';

class AuthFirebaseService implements IAuthService {
  AuthFirebaseService(this._secureStorageService);

  final _auth = FirebaseAuth.instance;
  final SecureStorage _secureStorageService;

  @override
  AsyncResult<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        await _secureStorageService.write(
          key: 'user',
          value: response.user?.uid ?? '',
        );
      }
      return Success(
        UserModel(email: response.user?.email, token: response.user?.uid),
      );
    } on FirebaseAuthException catch (e) {
      return Failure(AuthException.fromFirebaseAuth(e));
    } catch (e) {
      return Failure(AppException.fromStatusCode(e.hashCode, e.toString()));
    }
  }

  @override
  AsyncResult<UserModel> register(
    String? name, {
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        await response.user?.updateDisplayName(name);
        await _secureStorageService.write(
          key: 'user',
          value: response.user?.uid ?? '',
        );
      }
      return Success(
        UserModel(email: response.user?.email, token: response.user?.uid),
      );
    } on FirebaseAuthException catch (e) {
      return Failure(AuthException.fromFirebaseAuth(e));
    } catch (e) {
      return Failure(AppException.fromStatusCode(e.hashCode, e.toString()));
    }
  }

  @override
  AsyncResult<Unit> logout() async {
    try {
      await _auth.signOut();
      await _secureStorageService.delete('user');
      return Success(unit);
    } on FirebaseAuthException catch (e) {
      return Failure(AuthException.fromFirebaseAuth(e));
    } catch (e) {
      return Failure(AppException.fromStatusCode(e.hashCode, e.toString()));
    }
  }
}
