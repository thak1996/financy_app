import 'package:firebase_auth/firebase_auth.dart';
import 'base.exception.dart';

class AuthException extends BaseException {
  const AuthException(super.message, [super.code]);

  factory AuthException.fromFirebaseAuth(FirebaseAuthException e) {
    final message = switch (e.code) {
      'user-not-found' => 'User not found',
      'wrong-password' => 'Incorrect password',
      'email-already-in-use' => 'This email is already in use',
      'weak-password' => 'Password is too weak',
      'invalid-email' => 'Invalid email address',
      'too-many-requests' => 'Too many attempts. Please try again later.',
      'user-disabled' => 'This account has been disabled',
      'operation-not-allowed' => 'Operation not allowed',
      'invalid-credential' => 'Invalid credentials',
      'network-request-failed' => 'Connection error. Check your internet.',
      'requires-recent-login' => 'This operation requires recent login',
      _ => 'Authentication error: ${e.message ?? 'Unknown error'}',
    };

    return AuthException(message, e.code);
  }

  factory AuthException.userNotFound() =>
      const AuthException('User not found', 'user-not-found');

  factory AuthException.invalidCredentials() =>
      const AuthException('Invalid credentials', 'invalid-credential');

  factory AuthException.networkError() =>
      const AuthException('Connection error', 'network-error');

      factory AuthException.weakPassword() =>
      const AuthException('Password is too weak', 'weak-password');
}
