import 'package:financy_app/app/core/services/auth_firebase.service.dart';
import 'package:financy_app/app/core/utils/secure_storage.dart';
import 'package:financy_app/app/core/widgets/alert_dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/theme_switch.dart';
import 'home.controller.dart';
import 'home.state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeController(AuthFirebaseService(SecureStorage())),
      child: BlocBuilder<HomeController, HomeState>(
        builder: (context, state) {
          final controller = context.read<HomeController>();
          return BlocListener<HomeController, HomeState>(
            listener: (context, state) {
              if (state is HomeLoggedOut) context.pushNamed('login');
              if (state is HomeError) {
                context.pop();
                AlertDialogWidget.show(
                  context,
                  title: 'Erro',
                  message: state.message,
                );
              }
              if (state is HomeLoading) {
                showDialog(
                  context: context,
                  builder:
                      (context) => Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Home"),
                actions: const [ThemeSwitchIcon(), SizedBox(width: 16)],
              ),
              body: Center(
                child: IconButton(
                  onPressed: () => controller.logout(),
                  icon: const Icon(Icons.logout_outlined),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
