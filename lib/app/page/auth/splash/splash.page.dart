import 'package:financy_app/app/core/theme/app.colors.dart';
import 'package:financy_app/app/core/utils/secure_storage.dart';
import 'package:financy_app/app/page/auth/splash/splash.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'splash.state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashController(SecureStorage())..checkAuth(),
      child: BlocBuilder<SplashController, SplashState>(
        builder: (context, state) {
          return BlocListener<SplashController, SplashState>(
            listener: (context, state) {
              if (state is LoginSuccess) context.goNamed('app-scaffold');
              if (state is LoginFailed) context.goNamed('login');
            },
            child: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppColors.gradientBackground,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Financy",
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge?.copyWith(
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const CircularProgressIndicator(color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
