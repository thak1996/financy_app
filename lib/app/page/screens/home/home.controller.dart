import 'package:financy_app/app/data/repositories/transaction.repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home.state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController(this._transactionRepository) : super(HomeInitial());

  final TransactionRepository _transactionRepository;

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    final result = await _transactionRepository.getAllTransactions();
    result.fold(
      (success) => emit(HomeSuccess(transactions: success)),
      (failure) => emit(HomeError(message: failure.toString())),
    );
  }

  Future<void> loadBalances() async {
    emit(HomeLoading());
    final result = await _transactionRepository.getBalances();
    result.fold(
      (success) => emit(HomeBalancesSuccess(balances: success)),
      (failure) => emit(HomeError(message: failure.toString())),
    );
  }
  
  Future<void> refreshData() async => await loadHomeData();
}
