import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextTheme {
  static final AppTextTheme instance = AppTextTheme._();

  AppTextTheme._();

  final TextTheme textTheme = TextTheme(
    titleMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: TextStyle(
      fontSize: 11.sp,
      color: Colors.grey,
    ),
    bodyMedium: TextStyle(
      fontSize: 12.sp,
    ),
    labelLarge: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    ),
  );

  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get bodySmall => textTheme.bodySmall;
  TextStyle? get bodyMedium => textTheme.bodyMedium;
  TextStyle? get labelLarge => textTheme.labelLarge;
}