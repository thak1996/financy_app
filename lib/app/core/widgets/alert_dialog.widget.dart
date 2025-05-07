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
    showDialog(
      context: context,
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
    return AlertDialog(
      title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
      actions: [
        PrimaryButton(
          text: buttonText,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
