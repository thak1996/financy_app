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

  void _initControllers() {}

  void toggleTransactionType(int index) {
    for (int i = 0; i < selectedTransactionType.length; i++) {
      selectedTransactionType[i] = i == index;
    }
    emit(AddTransactionInitial());
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
      emit(AddTransactionInitial());
    }
  }

  Future<void> submitTransaction() async {
    if (!formKey.currentState!.validate()) return;

    emit(AddTransactionLoading());
    try {
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
