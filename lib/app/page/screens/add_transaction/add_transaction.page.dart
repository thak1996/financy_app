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
          appBar: AppBar(title: const Text('Adicionar Transação')),
          body: Padding(
            padding: EdgeInsets.all(16.r),
            child: _AddTransactionForm(),
          ),
        ),
      ),
    );
  }
}

class _AddTransactionForm extends StatefulWidget {
  const _AddTransactionForm();

  @override
  State<_AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<_AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Título'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe o título';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _amountController,
            decoration: InputDecoration(labelText: 'Valor'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe o valor';
              }
              if (double.tryParse(value) == null) {
                return 'Valor inválido';
              }
              return null;
            },
          ),
          SizedBox(height: 24.h),
          BlocBuilder<AddTransactionController, AddTransactionState>(
            builder: (context, state) {
              if (state is AddTransactionLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<AddTransactionController>()
                        .submitTransaction();
                  }
                },
                child: const Text('Salvar'),
              );
            },
          ),
        ],
      ),
    );
  }
}
