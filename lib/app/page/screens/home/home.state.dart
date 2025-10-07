import 'package:financy_app/app/data/models/balances.model.dart';
import 'package:financy_app/app/data/models/transaction.model.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<TransactionModel> transactions;

  HomeSuccess({required this.transactions});
}

class HomeBalancesSuccess extends HomeState {
  final BalancesModel balances;

  HomeBalancesSuccess({this.balances = const BalancesModel.empty()});
}

class HomeError extends HomeState {
  HomeError({required this.message});

  final String message;
}
