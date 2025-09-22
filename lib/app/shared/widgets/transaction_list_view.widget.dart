import 'package:financy_app/app/data/models/transaction.model.dart';
import 'package:financy_app/app/shared/consts/app_text_styles.dart';
import 'package:financy_app/app/shared/theme/app.colors.dart';
import 'package:financy_app/app/shared/utils/date_formatter_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({super.key, required this.transactions});

  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.r),
          leading: SizedBox(
            width: 48.w,
            height: 48.h,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.antiFlashWhite,
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
              ),
              padding: EdgeInsets.all(8.r),
              child: Icon(
                Icons.monetization_on,
                size: 20.h,
                color: AppColors.darkGreen,
              ),
            ),
          ),
          title: Text(
            transaction.description,
            style: AppTextStyles.text16(
              context,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            DateFormatter.formatDate(transaction.date),
            style: AppTextStyles.text14(
              context,
              color: AppColors.textGrey,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Text(
            transaction.value < 0
                ? '- \$${transaction.value.abs().toStringAsFixed(2).replaceAll('.', ',')}'
                : '+ \$${transaction.value.toStringAsFixed(2).replaceAll('.', ',')}',
            style: AppTextStyles.text16(
              context,
              color:
                  transaction.value < 0 ? AppColors.outcome : AppColors.income,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
