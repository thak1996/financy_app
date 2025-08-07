import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_scaffold.state.dart';

class AppScaffoldController extends Cubit<AppScaffoldState> {
  AppScaffoldController() : super(AppScaffoldInitial());

  late PageController _pageController;
  PageController get pageController => _pageController;

  set setPageController(PageController newPageController) {
    _pageController = newPageController;
  }

  Future<void> getRefreshTransactions() async {
    emit(AppScaffoldLoading());

    try {
      // Simular carregamento de transações
      await Future.delayed(const Duration(seconds: 1));
      emit(AppScaffoldSuccess());
    } catch (e) {
      emit(AppScaffoldError(e.toString()));
    }
  }

  Future<void> getRefreshHome() async {
    emit(AppScaffoldLoading());

    try {
      // Simular carregamento de saldo
      await Future.delayed(const Duration(seconds: 1));
      emit(AppScaffoldSuccess());
    } catch (e) {
      emit(AppScaffoldError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _pageController.dispose();
    return super.close();
  }
}
