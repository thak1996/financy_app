import 'package:flutter_bloc/flutter_bloc.dart';
import 'stats.state.dart';

class StatsController extends Cubit<StatsState> {
  StatsController() : super(StatsInitial());

  Future<void> loadStatsData() async {
    emit(StatsLoading());

    try {
      // Simular carregamento de estatísticas
      await Future.delayed(const Duration(seconds: 1));
      emit(StatsSuccess());
    } catch (e) {
      emit(StatsError(message: e.toString()));
    }
  }

  Future<void> refreshData() async {
    await loadStatsData();
  }

  Future<void> getTransactionsByPeriod() async {
    await loadStatsData();
  }
}
