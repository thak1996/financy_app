import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
          const SizedBox(height: 24),
          PrimaryButton(
            text: buttonText,
            maxWidth: 100,
            onPressed: () => Navigator.pop(context),
            height: 40,
          ),
        ],
      ),
    );
  }
}
