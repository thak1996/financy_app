sealed class TransactionsState {}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsSuccess extends TransactionsState {}

class TransactionsError extends TransactionsState {
  TransactionsError({required this.message});

  final String message;
}
