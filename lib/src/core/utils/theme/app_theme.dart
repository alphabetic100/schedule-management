import 'package:flutter/material.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';
import 'package:schedule_management/src/core/utils/theme/text_theme.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get appTheme {
    return ThemeData(
      primarySwatch: Colors.red,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      textTheme: AppTextTheme.textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.primaryTextColor),
      ),
      brightness: Brightness.light,
    );
  }
}
