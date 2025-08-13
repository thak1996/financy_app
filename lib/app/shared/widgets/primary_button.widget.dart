import 'package:financy_app/app/shared/consts/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app.colors.dart';

class PrimaryButtonWidget extends StatelessWidget {
  const PrimaryButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 28),
    this.isLoading = false,
    this.height,
    this.maxWidth = double.infinity,
  });

  final String text;
  final VoidCallback onPressed;
  final EdgeInsets padding;
  final bool isLoading;
  final double? height;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          height: height ?? 50.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.gradientButton,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(40.r),
              onTap: isLoading ? null : onPressed,
              child: Center(
                child:
                    isLoading
                        ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.white,
                            ),
                          ),
                        )
                        : Text(
                          text,
                          style: AppTextStyles.text16(
                            context,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
