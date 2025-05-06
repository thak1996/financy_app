import 'package:flutter/material.dart';
import '../theme/app.colors.dart';

class TextRichWidget extends StatelessWidget {
  const TextRichWidget({
    super.key,
    required this.textOne,
    required this.textTwo,
    required this.onTap,
  });

  final String textOne;
  final String textTwo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
          children: [
            TextSpan(text: textOne),
            TextSpan(
              text: textTwo,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
