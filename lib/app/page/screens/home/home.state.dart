import 'package:financy_app/app/data/models/transaction.model.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<TransactionModel> transactions;

  HomeSuccess({required this.transactions});
}

class HomeError extends HomeState {
  HomeError({required this.message});

  final String message;
}
