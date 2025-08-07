import 'package:flutter_bloc/flutter_bloc.dart';
import 'transactions.state.dart';

class TransactionsController extends Cubit<TransactionsState> {
  TransactionsController() : super(TransactionsInitial());

  Future<void> loadTransactionsData() async {
    emit(TransactionsLoading());

    try {
      // Simular carregamento de transações
      await Future.delayed(const Duration(seconds: 1));
      emit(TransactionsSuccess());
    } catch (e) {
      emit(TransactionsError(message: e.toString()));
    }
  }

  Future<void> refreshData() async {
    await loadTransactionsData();
  }

  Future<void> getTransactionsByDateRange() async {
    await loadTransactionsData();
  }

  Future<void> refreshTransactions() async {
    await loadTransactionsData();
  }
}
