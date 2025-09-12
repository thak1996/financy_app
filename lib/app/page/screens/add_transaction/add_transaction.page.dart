import 'package:financy_app/app/shared/consts/app_text_styles.dart';
import 'package:financy_app/app/shared/theme/app.colors.dart';
import 'package:financy_app/app/shared/utils/validators.dart';
import 'package:financy_app/app/shared/widgets/app_header.widget.dart';
import 'package:financy_app/app/shared/widgets/exports.dart';
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
          if (state is AddTransactionSuccess) Navigator.of(context).pop(true);
          if (state is AddTransactionError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AddTransactionLoading) {
            showDialog(
              context: context,
              builder: (context) => CircularProgressIndicatorWidget(),
            );
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              AppHeader(title: 'Adicionar Transação'),
              BlocBuilder<AddTransactionController, AddTransactionState>(
                builder: (context, state) {
                  final controller = context.read<AddTransactionController>();
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
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: controller.descriptionController,
                              decoration: InputDecoration(
                                labelText: 'Descrição',
                                labelStyle: AppTextStyles.text16(
                                  context,
                                  color: AppColors.textGrey,
                                ),
                              ),
                              validator: Validators.validateNonEmpty,
                            ),
                            SizedBox(height: 16.h),
                            TextFormField(
                              controller: controller.valueController,
                              decoration: InputDecoration(
                                labelText: 'Valor',
                                labelStyle: AppTextStyles.text16(
                                  context,
                                  color: AppColors.textGrey,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: Validators.validateNonEmpty,
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed:
                                  state is AddTransactionLoading
                                      ? null
                                      : controller.submitTransaction,
                              child:
                                  state is AddTransactionLoading
                                      ? CircularProgressIndicator()
                                      : Text('Adicionar'),
                            ),
                            if (state is AddTransactionError)
                              Text(
                                state.message,
                                style: TextStyle(color: Colors.red),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
