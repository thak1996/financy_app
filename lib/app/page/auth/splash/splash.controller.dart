import 'package:financy_app/app/data/services/auth_firebase.service.dart';
import 'package:financy_app/app/data/services/graphql.service.dart';
import 'package:financy_app/app/page/auth/splash/splash.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashController extends Cubit<SplashState> {
  SplashController({required this.authService, required this.graphQlService})
    : super(SplashInitial());

  final AuthFirebaseService authService;
  final GraphQlService graphQlService;

  Future<void> checkAuthState() async {
    emit(SplashLoading());
    try {
      final user = await authService.getCurrentUser();
      if (user != null) {
        final token = await authService.getIdToken();
        if (token == null) emit(SplashFailed());
        await graphQlService.refreshClient();
        emit(SplashSuccess());
      } else {
        emit(SplashFailed());
      }
    } catch (e) {
      emit(SplashFailed());
    }
  }
}
