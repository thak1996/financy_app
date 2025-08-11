import 'package:financy_app/app/shared/theme/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            Icon(Icons.error, size: 64, color: Colors.red),
            SizedBox(height: 16.h),
            Text('Erro: ${state.message}'),
          ],
        ),
      ),
      _ => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics, size: 100, color: Colors.orange),
            SizedBox(height: 16.h),
            Text(
              'Estatísticas Financeiras',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text('Gráficos e relatórios detalhados'),
          ],
        ),
      ),
    };
  }
}
