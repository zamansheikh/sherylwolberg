import 'package:flutter/material.dart';
import 'theme_color_resolver.dart';

class AppColors {
  static const AppColors instance = AppColors._();
  const AppColors._();
}

// Top-level getter for concise access
AppColors get appColors => AppColors.instance;

extension ColorsExtension on AppColors {
  Color get primaryTextColor =>
      ThemeColorResolver.getColorConstants().primaryTextColor;
  Color get accentColor => ThemeColorResolver.getColorConstants().accentColor;
  Color get backgroundColor =>
      ThemeColorResolver.getColorConstants().backgroundColor;
  Color get appBarBackgroundColor =>
      ThemeColorResolver.getColorConstants().appBarBackgroundColor;
  Color get buttonBackgroundColor =>
      ThemeColorResolver.getColorConstants().buttonBackgroundColor;
  Color get grey =>
      ThemeColorResolver.getColorConstants().greyColor;
  Color get secondaryTextColor =>
      ThemeColorResolver.getColorConstants().secondaryTextColor;
  Color get borderColor =>
      ThemeColorResolver.getColorConstants().borderColor;
  Color get primaryColor =>
      ThemeColorResolver.getColorConstants().primaryColor;
}
