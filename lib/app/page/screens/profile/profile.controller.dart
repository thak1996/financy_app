import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:financy_app/app/data/services/auth_firebase.service.dart';
import 'profile.state.dart';

class ProfileController extends Cubit<ProfileState> {
  ProfileController(this._authService) : super(ProfileInitial());

  final AuthFirebaseService _authService;

  Future<void> loadProfileData() async {
    emit(ProfileLoading());

    try {
      // Simular carregamento de dados do perfil
      await Future.delayed(const Duration(seconds: 1));
      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> refreshData() async {
    await loadProfileData();
  }

  Future<void> logout() async {
    emit(ProfileLoading());
    try {
      final result = await _authService.logout();
      result.fold(
        (error) => emit(ProfileError(message: error.toString())),
        (_) => emit(ProfileLoggedOut()),
      );
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
  
  Future<void> refreshProfile() async {
    await loadProfileData();
  }
}
