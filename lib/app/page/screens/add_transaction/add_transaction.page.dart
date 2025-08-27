import 'package:financy_app/app/shared/consts/app_text_styles.dart';
import 'package:financy_app/app/shared/theme/app.colors.dart';
import 'package:financy_app/app/shared/widgets/app_header.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'add_transaction.controller.dart';
import 'add_transaction.state.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTransactionController(),
      child: BlocListener<AddTransactionController, AddTransactionState>(
        listener: (context, state) {
          if (state is AddTransactionSuccess) {
            Navigator.of(context).pop(true);
          } else if (state is AddTransactionError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              AppHeader(title: 'Adicionar Transação'),
              _TransactionForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionForm extends StatefulWidget {
  const _TransactionForm();

  @override
  State<_TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<_TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<bool> _selectedTransactionType = <bool>[true, false];
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  final List<String> _categories = ['Salário', 'Comida', 'Transporte', 'Lazer'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 165.h,
      left: 24.w,
      right: 24.w,
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: ToggleButtons(
                  onPressed:
                      (int index) => setState(() {
                        for (
                          int i = 0;
                          i < _selectedTransactionType.length;
                          i++
                        ) {
                          _selectedTransactionType[i] = i == index;
                        }
                      }),
                  borderRadius: BorderRadius.circular(12.r),
                  selectedColor: Colors.white,
                  fillColor: Colors.teal[100],
                  color: Colors.teal[100],
                  constraints: BoxConstraints(minHeight: 40.h, minWidth: 120.w),
                  isSelected: _selectedTransactionType,
                  children: [
                    Text(
                      'Income',
                      style: AppTextStyles.text14(
                        context,
                      ).apply(color: AppColors.textGrey),
                    ),
                    Text(
                      'Expense',
                      style: AppTextStyles.text14(
                        context,
                      ).apply(color: AppColors.textGrey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // Campo de Valor (Amount)
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'AMOUNT',
                  prefixText: '\$ ',
                  suffixIcon: Icon(
                    Icons.thumb_up_alt,
                    color: AppColors.textGreyDark,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Campo de Descrição
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'DESCRIPTION',
                  hintText: 'Add description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Campo de Categoria
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'CATEGORY',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                hint: const Text('Select a category'),
                items:
                    _categories.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator:
                    (value) =>
                        value == null ? 'Please select a category' : null,
              ),
              SizedBox(height: 16.h),

              // Campo de Data
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'DATE',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(''),
                      const Icon(Icons.calendar_today_outlined),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.h),

              // Botão de Adicionar
              ElevatedButton(
                onPressed: () {
                  // Primeiro, valida o formulário
                  if (_formKey.currentState!.validate()) {
                    // Se for válido, envia o evento para o BLoC
                    // Você precisará criar um evento no seu controller para receber estes dados
                    /*
                    context.read<AddTransactionController>().add(
                      SubmitTransaction(
                        type: _selectedTransactionType[0] ? 'income' : 'expense',
                        amount: double.parse(_amountController.text),
                        description: _descriptionController.text,
                        category: _selectedCategory!,
                        date: _selectedDate,
                      ),
                    );
                    */
                    // A linha abaixo é apenas para teste, substitua pela de cima
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data...')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  backgroundColor: Colors.teal[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Add',
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
