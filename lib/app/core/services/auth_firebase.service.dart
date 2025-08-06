import 'package:financy_app/app/core/exception/app.exception.dart';
import 'package:financy_app/app/core/exception/auth.exception.dart';
import 'package:financy_app/app/core/interfaces/auth.interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:result_dart/result_dart.dart';
import '../models/user_credentials.model.dart';

class AuthFirebaseService implements IAuthService {
  final _auth = FirebaseAuth.instance;

  @override
  AsyncResult<UserCredentials> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Success(
        UserCredentials(email: response.user?.email, token: response.user?.uid),
      );
    } on FirebaseAuthException catch (e) {
      return Failure(AuthException.fromFirebaseAuth(e));
    } catch (e) {
      return Failure(AppException.fromStatusCode(e.hashCode, e.toString()));
    }
  }

  @override
  AsyncResult<UserCredentials> register(
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
      }
      return Success(
        UserCredentials(email: response.user?.email, token: response.user?.uid),
      );
    } on FirebaseAuthException catch (e) {
      return Failure(AuthException.fromFirebaseAuth(e));
    } catch (e) {
      return Failure(AppException.fromStatusCode(e.hashCode, e.toString()));
    }
  }
}
