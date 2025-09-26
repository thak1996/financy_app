import 'package:financy_app/app/shared/consts/app_text_styles.dart';
import 'package:financy_app/app/shared/theme/app.colors.dart';
import 'package:financy_app/app/shared/widgets/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.controller.dart';
import 'home.state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeController, HomeState>(
      builder: (context, state) {
        return BlocListener<HomeController, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              AlertDialogWidget.show(
                context,
                title: 'Error',
                message: state.message,
              );
            }
          },
          child: Scaffold(
            body: Column(
              children: [
                SizedBox(
                  height: 380.h,
                  child: Stack(
                    children: [
                      AppHeader(),
                      BalanceCard(
                        totalAmount: 1556.00,
                        incomeAmount: 1840.00,
                        outcomeAmount: 544.00,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.r,
                      vertical: 4.r,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transactions History',
                              style: AppTextStyles.text18(
                                context,
                                color: AppColors.textTertiary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'See all',
                              style: AppTextStyles.text14(
                                context,
                                color: AppColors.textGrey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Expanded(
                          child:
                              state is HomeSuccess
                                  ? state.transactions.isNotEmpty
                                      ? TransactionListView(
                                        transactions: state.transactions,
                                      )
                                      : Center(
                                        child: Text(
                                          'No transactions available',
                                          style: AppTextStyles.text16(
                                            context,
                                            color: AppColors.textGrey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                  : Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
