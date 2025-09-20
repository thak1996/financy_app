sealed class AddTransactionState {}

class AddTransactionInitial extends AddTransactionState {}

class AddTransactionLoading extends AddTransactionState {}

class AddTransactionSuccess extends AddTransactionState {}

class AddTransactionError extends AddTransactionState {
  final String message;
  
  AddTransactionError({required this.message});
}
