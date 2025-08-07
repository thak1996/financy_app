# Financy App - AI Coding Agent Instructions

## Architecture Overview

This is a **Flutter finance app** using **BLoC/Cubit** pattern with **Firebase Authentication**. The app follows a **page-based architecture** with centralized state management and **result_dart** for error handling.

### Core Pattern: BLoC/Cubit + MultiBlocProvider

- Each page has a dedicated `Controller` (Cubit), `State`, and `Page` file
- States use **sealed classes** with specific subtypes: `Initial`, `Loading`, `Success`, `Error`
- Controllers emit states using `emit()` and handle async operations with `try/catch`
- Use `BlocBuilder` for UI updates and `BlocListener` for side effects

**Example structure** (follow this pattern exactly):

```dart
// page.state.dart
sealed class PageState {}
class PageInitial extends PageState {}
class PageLoading extends PageState {}
class PageSuccess extends PageState {}
class PageError extends PageState {
  final String message;
  PageError({required this.message});
}

// page.controller.dart
class PageController extends Cubit<PageState> {
  PageController() : super(PageInitial());

  Future<void> loadData() async {
    emit(PageLoading());
    try {
      // async work
      emit(PageSuccess());
    } catch (e) {
      emit(PageError(message: e.toString()));
    }
  }
}
```

### App Navigation: AppScaffold + PageView

- **`AppScaffoldPage`** is the main container with `MultiBlocProvider` hosting all page controllers
- Uses `PageView` with `PageController` (not GoRouter ShellRoute) for smooth tab navigation
- **Custom PageController extension** (`page_controller.ext.dart`) handles bottom navigation logic
- Pages are **stateless** and access controllers via `context.read<Controller>()`

### Authentication Flow

- **Firebase Auth** with `SecureStorage` for token persistence
- **`SplashController`** checks auth state on app start using `LoggerPrinter` for debugging
- Routes: `splash` → `login/register` → `app-scaffold` (main app)
- Auth service uses **`result_dart`** returning `AsyncResult<UserModel>` or `AsyncResult<Unit>`

### Critical Conventions

1. **Dependency Injection**: Controllers receive services in constructor, NOT via Provider in pages
2. **Error Handling**: Always use `result_dart` `Success`/`Failure` pattern in services
3. **State Management**: Controllers are created in `MultiBlocProvider` at `AppScaffoldPage` level
4. **File Naming**: `feature.controller.dart`, `feature.state.dart`, `feature.page.dart`
5. **Context Safety**: Always check `context.mounted` after `await` operations

### Development Commands

```bash
flutter clean && flutter pub get    # Reset dependencies
flutter run                         # Run with hot reload
flutter test                        # Run unit tests
```

### Common Patterns to Follow

- **Service interfaces**: Use abstract classes (`IAuthService`, `ISecureStorage`)
- **Logging**: Use `Logger` with `LoggerPrinter('ClassName')` for debugging
- **Theme**: Toggle with `ThemeCubit` persisted in secure storage
- **Navigation**: Use `context.goNamed()` for route changes, `PageController.navigateTo()` for tabs
- **Widgets**: Custom widgets end with `.widget.dart` suffix

### Key Files to Reference

- `lib/app/page/screens/app_scaffold/app_scaffold.page.dart` - Main app structure
- `lib/app/core/extensions/page_controller.ext.dart` - Bottom navigation logic
- `lib/app/core/services/auth_firebase.service.dart` - Authentication patterns
- `lib/app/app.provider.dart` - Global provider setup
