import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'app.provider.dart';
import 'app.route.dart';
import 'core/theme/app.theme.dart';
import 'core/theme/theme_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProvider.providers,
      child: BlocProvider(
        create: (_) => ThemeCubit(storage: FlutterSecureStorage()),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'financy_app',
              darkTheme: AppTheme.darkTheme,
              theme: AppTheme.lightTheme,
              themeMode:
                  state == ThemeState.light ? ThemeMode.light : ThemeMode.dark,
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter,
            );
          },
        ),
      ),
    );
  }
}
