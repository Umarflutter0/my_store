import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.background,
      secondary: AppColors.rating,
      onSecondary: AppColors.blackPrimary,
      error: AppColors.error,
      onError: AppColors.background,
      surface: AppColors.background,
      onSurface: AppColors.blackPrimary,
    ),
  );
}
