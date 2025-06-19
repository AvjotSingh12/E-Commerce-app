import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
    primary: AppColors.primaryColor,
   
    error: AppColors.errorColor,
    background: AppColors.backgroundColor,
    surface: AppColors.surfaceColor,
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(color: AppColors.primaryTextColor),
    bodyLarge: TextStyle(color: AppColors.primaryTextColor),
    bodyMedium: TextStyle(color: AppColors.secondaryTextColor),
    labelLarge: TextStyle(color: AppColors.primaryColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    foregroundColor: Colors.white,
    elevation: 2,
  ),
);
