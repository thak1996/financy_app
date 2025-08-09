import 'package:flutter_bloc/flutter_bloc.dart';
import 'home.state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController() : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(HomeSuccess());
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> setEmit(HomeState state) async {
    emit(state);
  }

  Future<void> refreshData() async {
    await loadHomeData();
  }
}
