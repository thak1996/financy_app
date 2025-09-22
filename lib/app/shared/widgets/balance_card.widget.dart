import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:financy_app/app/shared/consts/app_text_styles.dart';
import 'package:financy_app/app/shared/theme/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.totalAmount,
    required this.incomeAmount,
    required this.outcomeAmount,
  });

  final double totalAmount;
  final double incomeAmount;
  final double outcomeAmount;

  @override
  Widget build(BuildContext context) {
    final totalFormatted = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    ).format(totalAmount);
    final incomeFormatted = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    ).format(incomeAmount);
    final outcomeFormatted = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    ).format(outcomeAmount);

    return Positioned(
      left: 24.w,
      right: 24.w,
      top: 155.h,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        decoration: BoxDecoration(
          color: AppColors.darkGreen,
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.3),
              blurRadius: 18.r,
              spreadRadius: 0,
              offset: Offset(0, 16.r),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Balance',
                      style: AppTextStyles.text16(
                        context,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      totalFormatted,
                      style: AppTextStyles.text24(
                        context,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => log('options'),
                  child: PopupMenuButton(
                    padding: EdgeInsets.zero,
                    child: Icon(Icons.more_horiz, color: AppColors.white),
                    itemBuilder:
                        (context) => [
                          PopupMenuItem(child: Text('Option 1')),
                          PopupMenuItem(child: Text('Option 2')),
                        ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            Row(
              children: [
                Expanded(
                  child: TransactionValueWidget(
                    amount: incomeAmount,
                    type: TransactionType.income,
                    formattedValue: incomeFormatted,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: TransactionValueWidget(
                    amount: outcomeAmount,
                    type: TransactionType.outcome,
                    formattedValue: outcomeFormatted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum TransactionType { income, outcome }

class TransactionValueWidget extends StatelessWidget {
  const TransactionValueWidget({
    super.key,
    required this.amount,
    required this.type,
    required this.formattedValue,
  });
  final double amount;
  final TransactionType type;
  final String formattedValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.06),
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          child: Icon(
            type == TransactionType.income
                ? Icons.arrow_upward
                : Icons.arrow_downward,
            color: AppColors.white,
            size: 16.h,
          ),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type == TransactionType.income ? 'Income' : 'Expense',
                style: AppTextStyles.text16(
                  context,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
              AutoSizeText(
                formattedValue,
                style: AppTextStyles.text20(
                  context,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
