import 'package:financy_app/app/core/services/auth_firebase.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home.state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController(this._authService) : super(HomeInitial());

  final AuthFirebaseService _authService;

  Future<void> logout() async {
    emit(HomeLoading());
    try {
      final result = await _authService.logout();
      result.fold(
        (success) => emit(HomeLoggedOut()),
        (failure) => emit(HomeError(failure.toString())),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
