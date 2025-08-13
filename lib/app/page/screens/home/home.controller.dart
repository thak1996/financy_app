import 'package:financy_app/app/data/models/repository.model.dart';
import 'package:financy_app/app/data/repositories/transaction.repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home.state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController(this._transactionRepository) : super(HomeInitial());

  final TransactionRepository _transactionRepository;

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    try {
      final result = await _transactionRepository.getAllTransactions();
      result.fold((success) {
        _transactions = success;
        emit(HomeSuccess(transactions: _transactions));
      }, (failure) => emit(HomeError(message: failure.toString())));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> refreshData() async => await loadHomeData();
}
