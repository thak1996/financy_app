import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ----------------------------------------------------------
/// AppTextStyles - Centralized Responsive Text Styles
///
/// USAGE:
/// Import this file and use the static methods, passing the context.
/// You can customize color and fontWeight via optional parameters.
///
/// Example:
///   Text(
///     'Title',
///     style: AppTextStyles.text18(context, color: AppColors.primary, fontWeight: FontWeight.bold),
///   ),
///
/// All methods use Theme.of(context).textTheme as a base and apply responsiveness with flutter_screenutil.
///
/// -----------------------------------------------------------
class AppTextStyles {
  /// Responsive text style, size 12sp.
  /// [color] and [fontWeight] are optional.
  static TextStyle text12(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) => Theme.of(context).textTheme.labelLarge!.copyWith(
    fontSize: 12.sp,
    color: color ?? Theme.of(context).textTheme.labelLarge?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  /// Responsive text style, size 14sp.
  /// [color] and [fontWeight] are optional.
  static TextStyle text14(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) => Theme.of(context).textTheme.bodyMedium!.copyWith(
    fontSize: 14.sp,
    color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  /// Responsive text style, size 16sp.
  /// [color] and [fontWeight] are optional.
  static TextStyle text16(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) => Theme.of(context).textTheme.bodyLarge!.copyWith(
    fontSize: 16.sp,
    color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  /// Responsive text style, size 18sp.
  /// [color] and [fontWeight] are optional.
  static TextStyle text18(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) => Theme.of(context).textTheme.titleMedium!.copyWith(
    fontSize: 18.sp,
    color: color ?? Theme.of(context).textTheme.titleMedium?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  /// Responsive text style, size 20sp.
  /// [color] and [fontWeight] are optional.
  static TextStyle text20(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) => Theme.of(context).textTheme.titleLarge!.copyWith(
    fontSize: 20.sp,
    color: color ?? Theme.of(context).textTheme.titleLarge?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  /// Responsive text style, size 22sp.
  /// [color] and [fontWeight] are optional.
  static TextStyle text22(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) => Theme.of(context).textTheme.headlineSmall!.copyWith(
    fontSize: 22.sp,
    color: color ?? Theme.of(context).textTheme.headlineSmall?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  /// Responsive text style, size 24sp.
  /// [color] and [fontWeight] are optional.
  static TextStyle text24(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) => Theme.of(context).textTheme.headlineMedium!.copyWith(
    fontSize: 24.sp,
    color: color ?? Theme.of(context).textTheme.headlineMedium?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  /// Responsive text style, size 26sp.
  /// [color] and [fontWeight] are optional.
  static TextStyle text26(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) => Theme.of(context).textTheme.displaySmall!.copyWith(
    fontSize: 26.sp,
    color: color ?? Theme.of(context).textTheme.displaySmall?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  /// Responsive text style, size 28sp.
  /// [color] and [fontWeight] are optional.
  static TextStyle text28(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) => Theme.of(context).textTheme.displaySmall!.copyWith(
    fontSize: 28.sp,
    color: color ?? Theme.of(context).textTheme.displaySmall?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  /// Responsive text style, size 30sp.
  /// [color] and [fontWeight] are optional.
  static TextStyle text30(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) => Theme.of(context).textTheme.displayMedium!.copyWith(
    fontSize: 30.sp,
    color: color ?? Theme.of(context).textTheme.displayMedium?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  /// Responsive text style, size 32sp.
  /// [color] and [fontWeight] are optional.
  static TextStyle text32(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) => Theme.of(context).textTheme.displayMedium!.copyWith(
    fontSize: 32.sp,
    color: color ?? Theme.of(context).textTheme.displayMedium?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  /// Responsive text style, size 34sp.
  /// [color] and [fontWeight] are optional.
  static TextStyle text34(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) => Theme.of(context).textTheme.displayLarge!.copyWith(
    fontSize: 34.sp,
    color: color ?? Theme.of(context).textTheme.displayLarge?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  /// Responsive text style, size 36sp.
  /// [color] and [fontWeight] are optional.
  static TextStyle text36(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) => Theme.of(context).textTheme.displayLarge!.copyWith(
    fontSize: 36.sp,
    color: color ?? Theme.of(context).textTheme.displayLarge?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  /// Responsive text style, size 50sp.
  /// [color] and [fontWeight] are optional.
  static TextStyle text50(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
  }) => Theme.of(context).textTheme.displayLarge!.copyWith(
    fontSize: 50.sp,
    color: color ?? Theme.of(context).textTheme.displayLarge?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );
}
