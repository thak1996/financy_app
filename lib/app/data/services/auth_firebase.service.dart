import 'dart:developer';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:financy_app/app/data/exception/app.exception.dart';
import 'package:financy_app/app/data/exception/auth.exception.dart';
import 'package:financy_app/app/data/exception/functions.exception.dart';
import 'package:financy_app/app/data/interfaces/auth.interface.dart';
import 'package:financy_app/app/shared/utils/log_printer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';
import '../models/user.model.dart';

class AuthFirebaseService implements IAuthService {
  final _auth = FirebaseAuth.instance;
  final _functions = FirebaseFunctions.instance;
  final Logger _logger = Logger(printer: LoggerPrinter('AuthFirebaseService'));

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
      final token = await response.user?.getIdToken();
      log('Bearer $token');
      return Success(UserModel(email: response.user?.email, token: token));
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
      final HttpsCallable callable = _functions.httpsCallable('registerUser');
      await callable.call({
        'email': email,
        'password': password,
        'displayName': name,
      });
      final response = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        await response.user?.updateDisplayName(name);
      }
      return Success(UserModel(email: response.user?.email));
    } on FirebaseAuthException catch (e) {
      return Failure(AuthException.fromFirebaseAuth(e));
    } on FirebaseFunctionsException catch (e) {
      return Failure(FunctionsException(e.message ?? 'no message', e.code));
    } catch (e) {
      return Failure(AppException.fromStatusCode(e.hashCode, e.toString()));
    }
  }

  @override
  AsyncResult<Unit> logout() async {
    try {
      await _auth.signOut();
      return Success(unit);
    } on FirebaseAuthException catch (e) {
      return Failure(AuthException.fromFirebaseAuth(e));
    } catch (e) {
      return Failure(AppException.fromStatusCode(e.hashCode, e.toString()));
    }
  }

  @override
  Future<String?> getIdToken({bool forceRefresh = false}) async {
    try {
      final token = await _auth.currentUser?.getIdToken(forceRefresh);
      return token;
    } catch (e) {
      _logger.w('getIdToken error: $e');
      return null;
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final firebaseUser = _auth.currentUser;
      if (firebaseUser == null) return null;
      final token = await firebaseUser.getIdToken();
      return UserModel(email: firebaseUser.email, token: token);
    } catch (e) {
      _logger.w('getCurrentUser error: $e');
      return null;
    }
  }
}
