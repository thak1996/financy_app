import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_transaction.state.dart';

class AddTransactionController extends Cubit<AddTransactionState> {
  AddTransactionController() : super(AddTransactionInitial());

  Future<void> submitTransaction(/* transaction data */) async {
    emit(AddTransactionLoading());
    try {
      // ... call service to add transaction
      emit(AddTransactionSuccess());
    } catch (e) {
      emit(AddTransactionError(message: e.toString()));
    }
  }
}
