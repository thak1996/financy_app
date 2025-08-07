abstract class AppScaffoldState {}

class AppScaffoldInitial extends AppScaffoldState {}

class AppScaffoldLoading extends AppScaffoldState {}

class AppScaffoldSuccess extends AppScaffoldState {}

class AppScaffoldError extends AppScaffoldState {
  AppScaffoldError(this.message);

  final String message;
}
