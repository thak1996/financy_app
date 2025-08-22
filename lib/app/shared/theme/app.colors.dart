import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

  // Brand Colors
  static Color get primary => const Color(0xFF438883);
  static Color get secondary => const Color(0xFF2F7E79);

  static Color get warning => const Color(0xFFFFC107);
  static Color get error => const Color(0xFFF44336);
  static Color get notification => const Color(0xFFFFAB7B);
  static Color get darkGreen => const Color(0xFF2F7E79);

  // Neutral Colors
  static Color get grey100 => const Color(0xFFF5F5F5);
  static Color get grey200 => const Color(0xFFEEEEEE);
  static Color get grey300 => const Color(0xFFE0E0E0);

  static Color get white => const Color(0xFFFFFFFF);
  static Color get black => const Color(0xFF000000);
  static Color get iceWhite => const Color(0xFFEEF8F7);

  // Surface Colors
  static Color get background => const Color(0xFFFFFFFF);
  static Color get surface => const Color(0xFFFFFFFF);
  static Color get surfaceDark => const Color(0xFF1E1E1E);

  // Text Colors
  static Color get textPrimary => const Color(0xFF438883);
  static Color get textSecondary => const Color(0xFF444444);
  static Color get textTertiary => const Color(0xFF222222);
  static Color get textGrey => const Color(0xFF666666);
  static Color get textGreyDark => const Color(0xFF888888);
  static Color get textDisabled => const Color(0xFFBDBDBD);
  static Color get income => const Color(0xFF25A969);
  static Color get outcome => const Color(0xFFF95B51);
  static Color get antiFlashWhite => const Color(0xFFF0F6F5);

  // Link Colors
  static Color get link => const Color(0xFF2196F3);

  static List<Color> get gradientBackground => [
    Color(0xFF63B5AF),
    Color(0xFF438883),
  ];
  static List<Color> get gradientButton => [
    Color(0xFF69AEA9),
    Color(0xFF3F8782),
  ];
  static List<Color> get greenGradient => [
    Color(0xFF429690),
    Color(0xFF2A7C76),
  ];
}
