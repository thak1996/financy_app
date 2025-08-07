sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  ProfileError({required this.message});

  final String message;
}

class ProfileLoggedOut extends ProfileState {}
