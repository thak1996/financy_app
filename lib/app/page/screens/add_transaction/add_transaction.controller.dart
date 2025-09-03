import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_transaction.state.dart';

class AddTransactionController extends Cubit<AddTransactionState> {
  AddTransactionController() : super(AddTransactionInitial()) {
    _initControllers();
  }

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  final valueController = TextEditingController();
  final List<bool> selectedTransactionType = <bool>[true, false];
  String? selectedCategory;
  DateTime selectedDate = DateTime.now();
  final List<String> categories = ['Salário', 'Comida', 'Transporte', 'Lazer'];

  void _initControllers() {
    // Inicializações se necessárias
  }

  void toggleTransactionType(int index) {
    for (int i = 0; i < selectedTransactionType.length; i++) {
      selectedTransactionType[i] = i == index;
    }
    emit(AddTransactionInitial()); // Trigger rebuild
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      emit(AddTransactionInitial()); // Trigger rebuild
    }
  }

  Future<void> submitTransaction() async {
    if (!formKey.currentState!.validate()) return;

    emit(AddTransactionLoading());
    try {
      // Chame o service aqui (ex.: await transactionService.addTransaction(...))
      // Use result_dart: AsyncResult<Unit> result = await service.add(...);
      // if (result.isError) throw result.exception;
      emit(AddTransactionSuccess());
    } catch (e) {
      emit(AddTransactionError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    amountController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}
