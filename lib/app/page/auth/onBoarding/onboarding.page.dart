import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app.colors.dart';
import '../../../core/widgets/primary_button.widget.dart';
import '../../../core/widgets/text_rich_widget.dart';

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
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Spend Smarter \nSave More',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButtonWidget(
                    text: 'Get Started',
                    onPressed: () => context.pushNamed('register'),
                  ),
                  const SizedBox(height: 16),
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
