import 'package:financy_app/app/shared/consts/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../theme/app.colors.dart';

class TextRichWidget extends StatelessWidget {
  const TextRichWidget({
    super.key,
    required this.textOne,
    this.textTwo,
    required this.onTap,
    this.alignment = Alignment.center,
  });

  final String textOne;
  final String? textTwo;
  final VoidCallback onTap;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            style: AppTextStyles.text14(
              context,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
            children: [
              TextSpan(text: "$textOne "),
              TextSpan(
                text: textTwo ?? ' ',
                style: AppTextStyles.text14(
                  context,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
