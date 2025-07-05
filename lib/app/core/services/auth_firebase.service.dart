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
    String? token,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Success(
        UserCredentials(email: userCredential.user?.email, token: token),
      );
    } catch (e) {
      return Failure(Exception('Login failed: ${e.toString()}'));
    }
  }

  @override
  AsyncResult<UserCredentials> register(
    String? name, {
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await userCredential.user?.updateDisplayName(name);
      }
      return Success(
        UserCredentials(
          email: userCredential.user?.email,
          token: userCredential.user?.uid,
        ),
      );
    } catch (e) {
      return Failure(Exception('Registration failed: ${e.toString()}'));
    }
  }
}
