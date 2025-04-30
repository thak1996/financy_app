import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app.colors.dart';
import 'app.metrics.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme,
      ).copyWith(
        displayLarge: GoogleFonts.inter(
          fontSize: AppMetrics.fontDisplay1,
          fontWeight: FontWeight.bold,
          letterSpacing: AppMetrics.letterSpacingS,
          color: AppColors.textPrimary,
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: AppMetrics.fontDisplay2,
          fontWeight: FontWeight.bold,
          letterSpacing: AppMetrics.letterSpacingS,
          color: AppColors.textPrimary,
        ),
        displaySmall: GoogleFonts.inter(
          fontSize: AppMetrics.fontDisplay3,
          fontWeight: FontWeight.bold,
          letterSpacing: AppMetrics.letterSpacingS,
          color: AppColors.textPrimary,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: AppMetrics.fontHeadline,
          fontWeight: FontWeight.w600,
          letterSpacing: AppMetrics.letterSpacingS,
          color: AppColors.textPrimary,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: AppMetrics.fontTitle,
          fontWeight: FontWeight.w600,
          letterSpacing: AppMetrics.letterSpacingS,
          color: AppColors.textPrimary,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: AppMetrics.fontTitle,
          fontWeight: FontWeight.w600,
          letterSpacing: AppMetrics.letterSpacingS,
          color: AppColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: AppMetrics.fontBody,
          letterSpacing: AppMetrics.letterSpacingL,
          color: AppColors.textSecondary,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: AppMetrics.fontLabel,
          letterSpacing: AppMetrics.letterSpacingL,
          color: AppColors.textSecondary,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: AppMetrics.fontLabel,
          fontWeight: FontWeight.w500,
          letterSpacing: AppMetrics.letterSpacingM,
          color: AppColors.textSecondary,
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppMetrics.radiusM),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,
          padding: EdgeInsets.symmetric(
            horizontal: AppMetrics.spacingL,
            vertical: AppMetrics.spacingS,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppMetrics.radiusS),
          ),
          minimumSize: Size.fromHeight(AppMetrics.buttonHeightM),
          textStyle: TextStyle(
            fontSize: AppMetrics.fontBody,
            fontWeight: FontWeight.w500,
            letterSpacing: AppMetrics.letterSpacingM,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(
            horizontal: AppMetrics.spacingM,
            vertical: AppMetrics.spacingXS,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppMetrics.radiusS),
          ),
          minimumSize: Size.fromHeight(AppMetrics.buttonHeightS),
          textStyle: TextStyle(
            fontSize: AppMetrics.fontBody,
            fontWeight: FontWeight.w500,
            letterSpacing: AppMetrics.letterSpacingM,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,
          padding: EdgeInsets.symmetric(
            horizontal: AppMetrics.spacingL,
            vertical: AppMetrics.spacingS,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppMetrics.radiusS),
          ),
          minimumSize: Size.fromHeight(AppMetrics.buttonHeightM),
          textStyle: TextStyle(
            fontSize: AppMetrics.fontBody,
            fontWeight: FontWeight.w500,
            letterSpacing: AppMetrics.letterSpacingM,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppMetrics.radiusS),
          borderSide: BorderSide(color: AppColors.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppMetrics.radiusS),
          borderSide: BorderSide(color: AppColors.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppMetrics.radiusS),
          borderSide: BorderSide(color: AppColors.grey300),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppMetrics.spacingM,
          vertical: AppMetrics.spacingS,
        ),
        hoverColor: Colors.transparent,
        focusColor: AppColors.grey200,
        filled: true,
        fillColor: AppColors.grey100,
        labelStyle: TextStyle(color: AppColors.textPrimary),
        hintStyle: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme)
          .apply(bodyColor: Colors.white, displayColor: Colors.white)
          .copyWith(
            displayLarge: GoogleFonts.inter(
              fontSize: AppMetrics.fontDisplay1,
              fontWeight: FontWeight.bold,
              letterSpacing: AppMetrics.letterSpacingS,
              color: Colors.white,
            ),
            displayMedium: GoogleFonts.inter(
              fontSize: AppMetrics.fontDisplay2,
              fontWeight: FontWeight.bold,
              letterSpacing: AppMetrics.letterSpacingS,
              color: Colors.white,
            ),
            displaySmall: GoogleFonts.inter(
              fontSize: AppMetrics.fontDisplay3,
              fontWeight: FontWeight.bold,
              letterSpacing: AppMetrics.letterSpacingS,
              color: Colors.white,
            ),
            headlineMedium: GoogleFonts.inter(
              fontSize: AppMetrics.fontHeadline,
              fontWeight: FontWeight.w600,
              letterSpacing: AppMetrics.letterSpacingS,
              color: Colors.white,
            ),
            headlineSmall: GoogleFonts.inter(
              fontSize: AppMetrics.fontTitle,
              fontWeight: FontWeight.w600,
              letterSpacing: AppMetrics.letterSpacingS,
              color: Colors.white,
            ),
            titleLarge: GoogleFonts.inter(
              fontSize: AppMetrics.fontTitle,
              fontWeight: FontWeight.w600,
              letterSpacing: AppMetrics.letterSpacingS,
              color: Colors.white,
            ),
            bodyLarge: GoogleFonts.inter(
              fontSize: AppMetrics.fontBody,
              letterSpacing: AppMetrics.letterSpacingL,
              color: Colors.white,
            ),
            bodyMedium: GoogleFonts.inter(
              fontSize: AppMetrics.fontLabel,
              letterSpacing: AppMetrics.letterSpacingL,
              color: Colors.white70,
            ),
            labelLarge: GoogleFonts.inter(
              fontSize: AppMetrics.fontLabel,
              fontWeight: FontWeight.w500,
              letterSpacing: AppMetrics.letterSpacingM,
              color: Colors.white70,
            ),
          ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppMetrics.radiusM),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,
          padding: EdgeInsets.symmetric(
            horizontal: AppMetrics.spacingL,
            vertical: AppMetrics.spacingS,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppMetrics.radiusS),
          ),
          minimumSize: Size.fromHeight(AppMetrics.buttonHeightM),
          textStyle: TextStyle(
            fontSize: AppMetrics.fontBody,
            fontWeight: FontWeight.w500,
            letterSpacing: AppMetrics.letterSpacingM,
            color: Colors.white,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppMetrics.radiusS),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppMetrics.spacingM,
          vertical: AppMetrics.spacingS,
        ),
        fillColor: Colors.grey[900],
        filled: true,
        labelStyle: const TextStyle(color: Colors.white),
        hintStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppMetrics.radiusS),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppMetrics.radiusS),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
