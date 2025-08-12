import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle text12(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) => Theme.of(context).textTheme.labelLarge!.copyWith(
    fontSize: fontSize ?? 12.sp,
    color: color ?? Theme.of(context).textTheme.labelLarge?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  static TextStyle text14(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) => Theme.of(context).textTheme.bodyMedium!.copyWith(
    fontSize: fontSize ?? 14.sp,
    color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  static TextStyle text16(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) => Theme.of(context).textTheme.bodyLarge!.copyWith(
    fontSize: fontSize ?? 16.sp,
    color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  static TextStyle text18(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) => Theme.of(context).textTheme.titleMedium!.copyWith(
    fontSize: fontSize ?? 18.sp,
    color: color ?? Theme.of(context).textTheme.titleMedium?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  static TextStyle text20(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) => Theme.of(context).textTheme.titleLarge!.copyWith(
    fontSize: fontSize ?? 20.sp,
    color: color ?? Theme.of(context).textTheme.titleLarge?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  static TextStyle text22(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) => Theme.of(context).textTheme.headlineSmall!.copyWith(
    fontSize: fontSize ?? 22.sp,
    color: color ?? Theme.of(context).textTheme.headlineSmall?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  static TextStyle text24(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) => Theme.of(context).textTheme.headlineMedium!.copyWith(
    fontSize: fontSize ?? 24.sp,
    color: color ?? Theme.of(context).textTheme.headlineMedium?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  static TextStyle text26(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) => Theme.of(context).textTheme.displaySmall!.copyWith(
    fontSize: fontSize ?? 26.sp,
    color: color ?? Theme.of(context).textTheme.displaySmall?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  static TextStyle text28(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) => Theme.of(context).textTheme.displaySmall!.copyWith(
    fontSize: fontSize ?? 28.sp,
    color: color ?? Theme.of(context).textTheme.displaySmall?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  static TextStyle text30(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) => Theme.of(context).textTheme.displayMedium!.copyWith(
    fontSize: fontSize ?? 30.sp,
    color: color ?? Theme.of(context).textTheme.displayMedium?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  static TextStyle text32(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) => Theme.of(context).textTheme.displayMedium!.copyWith(
    fontSize: fontSize ?? 32.sp,
    color: color ?? Theme.of(context).textTheme.displayMedium?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  static TextStyle text34(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) => Theme.of(context).textTheme.displayLarge!.copyWith(
    fontSize: fontSize ?? 34.sp,
    color: color ?? Theme.of(context).textTheme.displayLarge?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  static TextStyle text36(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) => Theme.of(context).textTheme.displayLarge!.copyWith(
    fontSize: fontSize ?? 36.sp,
    color: color ?? Theme.of(context).textTheme.displayLarge?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );

  static TextStyle text50(
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) => Theme.of(context).textTheme.displayLarge!.copyWith(
    fontSize: fontSize ?? 50.sp,
    color: color ?? Theme.of(context).textTheme.displayLarge?.color,
    fontWeight: fontWeight ?? FontWeight.normal,
  );
}
