import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'primary_button.widget.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.message,
    this.buttonText = 'OK',
  });

  final String title;
  final String message;
  final String buttonText;

  static void show(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder:
          (context) => AlertDialogWidget(
            title: title,
            message: message,
            buttonText: buttonText,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.w)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          PrimaryButtonWidget(
            text: buttonText,
            maxWidth: 100,
            onPressed: () => Navigator.pop(context),
            height: 40.h,
          ),
        ],
      ),
    );
  }
}
