import 'package:financy_app/app/shared/consts/app_text_styles.dart';
import 'package:financy_app/app/shared/theme/app.colors.dart';
import 'package:financy_app/app/shared/widgets/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.iceWhite,
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/onboarding.png',
                width: 0.8.sw,
                height: 0.3.sh,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Spend Smarter \nSave More',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.text36(
                      context,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  PrimaryButtonWidget(
                    text: 'Get Started',
                    onPressed: () => context.pushNamed('register'),
                  ),
                  SizedBox(height: 16.h),
                  TextRichWidget(
                    textOne: 'Already have an account? ',
                    textTwo: 'Sign in',
                    onTap: () => context.pushNamed('login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
