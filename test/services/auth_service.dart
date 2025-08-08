import 'package:financy_app/app/data/exception/auth.exception.dart';
import 'package:financy_app/app/data/models/user.model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:result_dart/result_dart.dart';
import '../mock/mock_firebase_auth_service.dart';

void main() {
  late MockFirebaseAuthService mockFirebaseAuthService;

  setUp(() {
    mockFirebaseAuthService = MockFirebaseAuthService();
  });

  group('FirebaseAuthService Tests', () {
    test('Sign In - Success', () async {
      when(
        mockFirebaseAuthService.login(
          email: 'test@example.com',
          password: 'password',
        ),
      ).thenAnswer(
        (_) async =>
            Success(UserModel(email: 'test@example.com', token: 'user_token')),
      );

      final result = await mockFirebaseAuthService.login(
        email: 'test@example.com',
        password: 'password',
      );
      expect(result.isSuccess(), true);
    });

    test('Sign In - Failure', () async {
      when(
        mockFirebaseAuthService.login(
          email: 'invalid@example.com',
          password: 'wrongpassword',
        ),
      ).thenAnswer((_) async => Failure(AuthException('Invalid credentials')));

      final result = await mockFirebaseAuthService.login(
        email: 'invalid@example.com',
        password: 'wrongpassword',
      );

      expect(result.isError(), true);
    });
  });
}
