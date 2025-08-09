
import 'package:financy_app/app/shared/widgets/alert_dialog.widget.dart';
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
        return BlocListener<HomeController, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              AlertDialogWidget.show(
                context,
                title: 'Erro',
                message: state.message,
              );
            }
          },
          child: _buildBody(state, context),
        );
      },
    );
  }

  Widget _buildBody(HomeState state, BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<HomeController>().setEmit(
                  HomeError(message: "Erro ao carregar dados"),
                );
              },
              child: const Text("State Error"),
            ),
          ],
        ),
      ),
    );
  }
}
