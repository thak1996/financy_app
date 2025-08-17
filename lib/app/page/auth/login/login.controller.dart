import 'package:financy_app/app/data/exports.dart';
import 'package:financy_app/app/data/services/graphql.service.dart';
import 'package:financy_app/app/page/auth/login/login.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginController extends Cubit<LoginState> {
  LoginController({required this.authService, required this.graphQlService})
    : super(const LoginInitial());

  final AuthFirebaseService authService;
  final GraphQlService graphQlService;

  Future<void> login(String email, String password) async {
    emit(const LoginLoading());
    try {
      final result = await authService.login(email: email, password: password);
      result.fold(
        (success) => emit(const LoginSuccess()),
        (failure) => emit(LoginError(failure.toString())),
      );
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
