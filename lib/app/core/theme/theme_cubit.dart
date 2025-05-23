import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum ThemeState { light, dark }

class ThemeCubit extends Cubit<ThemeState> {
  static const _storageKey = 'theme_mode';
  final FlutterSecureStorage _storage;

  ThemeCubit({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage(),
      super(ThemeState.light) {
    _loadTheme();
  }

  void _loadTheme() async {
    final saved = await _storage.read(key: _storageKey);
    if (saved == 'dark') {
      emit(ThemeState.dark);
    } else {
      emit(ThemeState.light);
    }
  }

  void toggleTheme() async {
    final newTheme =
        state == ThemeState.light ? ThemeState.dark : ThemeState.light;
    emit(newTheme);
    await _storage.write(
      key: _storageKey,
      value: newTheme == ThemeState.dark ? 'dark' : 'light',
    );
  }
}
