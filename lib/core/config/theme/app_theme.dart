import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

abstract class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.primaryVariant,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.primaryVariant,
      secondary: AppColors.secondaryVariant,
      surface: AppColors.secondaryVariant,
      error: AppColors.red,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryVariant,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.primaryVariant,
      ),
    ),
  );
}
