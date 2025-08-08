import 'package:financy_app/app/shared/theme/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'profile.controller.dart';
import 'profile.state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileController, ProfileState>(
      builder: (context, state) {
        final controller = context.read<ProfileController>();
        return BlocListener<ProfileController, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoggedOut) context.goNamed('login');
            if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Perfil"),
              actions: [
                const ThemeSwitchIcon(),
                IconButton(
                  onPressed: () => controller.logout(),
                  icon: const Icon(Icons.logout_outlined),
                  tooltip: 'Sair',
                ),
                const SizedBox(width: 16),
              ],
            ),
            body: _buildBody(state),
          ),
        );
      },
    );
  }

  Widget _buildBody(ProfileState state) {
    return switch (state) {
      ProfileLoading() => const Center(child: CircularProgressIndicator()),
      ProfileError() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Erro: ${state.message}'),
          ],
        ),
      ),
      _ => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 100, color: Colors.purple),
            SizedBox(height: 16),
            Text(
              'Perfil do Usuário',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Configurações e dados pessoais'),
          ],
        ),
      ),
    };
  }
}
