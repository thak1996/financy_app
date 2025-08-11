import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(text: "$textOne "),
              TextSpan(
                text: textTwo ?? ' ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
