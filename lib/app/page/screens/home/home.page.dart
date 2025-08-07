import 'package:financy_app/app/core/theme/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home.controller.dart';
import 'home.state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeController, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Dashboard"),
            actions: const [ThemeSwitchIcon(), SizedBox(width: 16)],
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(HomeState state) {
    return switch (state) {
      HomeLoading() => const Center(child: CircularProgressIndicator()),
      HomeError() => Center(
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
            Icon(Icons.dashboard, size: 100, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Dashboard Principal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Aqui ficará o resumo financeiro'),
          ],
        ),
      ),
    };
  }
}
