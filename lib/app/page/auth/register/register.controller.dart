import 'package:financy_app/app/data/exports.dart';
import 'package:financy_app/app/data/services/graohql.service.dart';
import 'package:financy_app/app/page/auth/register/register.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController({required this.authService, required this.graphQlService})
    : super(RegisterInitial());

  final AuthFirebaseService authService;
  final GraphQlService graphQlService;

  Future<void> register(UserModel userCredentials) async {
    try {
      emit(RegisterLoading());
      final response = await authService.register(
        userCredentials.name,
        email: userCredentials.email!,
        password: userCredentials.password!,
      );
      response.fold((success) async {
        await graphQlService.refreshClient();
        emit(RegisterSuccess());
      }, (failure) => emit(RegisterError(failure.toString())));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
