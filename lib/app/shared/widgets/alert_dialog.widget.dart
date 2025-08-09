import 'package:flutter/material.dart';

/// Represents an action button in the alert dialog
class AlertDialogAction {
  final String label;
  final VoidCallback onPressed;
  final bool isDestructive;
  const AlertDialogAction({
    required this.label,
    required this.onPressed,
    this.isDestructive = false,
  });
}

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final Color? iconColor;
  final List<AlertDialogAction> actions;

  const AlertDialogWidget({
    super.key,
    this.icon,
    this.iconColor,
    required this.title,
    required this.message,
    required this.actions,
  });

  /// Shows an informational dialog with a single OK button
  static Future<void> showInfo(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    return _showBottomSheet(
      context,
      title: title,
      message: message,
      icon: Icons.info_outline,
      iconColor: Colors.blue,
      actions: [
        AlertDialogAction(
          label: buttonText,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  /// Shows a success dialog with a single OK button
  static Future<void> showSuccess(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    return _showBottomSheet(
      context,
      title: title,
      message: message,
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
      actions: [
        AlertDialogAction(
          label: buttonText,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  /// Shows a confirmation dialog with Confirm and Cancel buttons, returns true if confirmed
  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Yes',
    String cancelText = 'No',
  }) {
    return _showBottomSheet<bool>(
      context,
      title: title,
      message: message,
      icon: Icons.help_outline,
      iconColor: Colors.orange,
      actions: [
        AlertDialogAction(
          label: cancelText,
          onPressed: () => Navigator.pop(context, false),
        ),
        AlertDialogAction(
          label: confirmText,
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }

  static Future<T?> _showBottomSheet<T>(
    BuildContext context, {
    required String title,
    required String message,
    IconData? icon,
    Color? iconColor,
    required List<AlertDialogAction> actions,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder:
          (_) => AlertDialogWidget(
            title: title,
            message: message,
            icon: icon,
            iconColor: iconColor,
            actions: actions,
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
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 48,
              color: iconColor ?? Theme.of(context).primaryColor,
            ),
          const SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                actions.map((action) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextButton(
                      onPressed: action.onPressed,
                      style: TextButton.styleFrom(
                        foregroundColor:
                            action.isDestructive ? Colors.red : null,
                      ),
                      child: Text(action.label),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
