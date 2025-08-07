import 'package:financy_app/app/core/theme/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'transactions.controller.dart';
import 'transactions.state.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsController, TransactionsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Transações"),
            actions: const [ThemeSwitchIcon(), SizedBox(width: 16)],
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(TransactionsState state) {
    return switch (state) {
      TransactionsLoading() => const Center(child: CircularProgressIndicator()),
      TransactionsError() => Center(
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
            Icon(Icons.receipt_long, size: 100, color: Colors.green),
            SizedBox(height: 16),
            Text(
              'Transações',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Lista de todas as suas transações'),
          ],
        ),
      ),
    };
  }
}
