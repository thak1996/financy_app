import 'package:financy_app/app/shared/theme/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'stats.controller.dart';
import 'stats.state.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsController, StatsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Estatísticas"),
            actions: const [ThemeSwitchIcon(), SizedBox(width: 16)],
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(StatsState state) {
    return switch (state) {
      StatsLoading() => const Center(child: CircularProgressIndicator()),
      StatsError() => Center(
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
            Icon(Icons.analytics, size: 100, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              'Estatísticas Financeiras',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Gráficos e relatórios detalhados'),
          ],
        ),
      ),
    };
  }
}
