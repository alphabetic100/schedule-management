import 'package:flutter/material.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class AppTextTheme {
  static const String fontFamily = 'Poppins';
  static const String fontFamilyBold = 'Poppins-Bold';
  static const String fontFamilyMedium = 'Poppins-Medium';
  static const String fontFamilyRegular = 'Poppins-Regular';

  static TextTheme get textTheme => TextTheme(
    displayLarge: TextStyle(
      fontFamily: fontFamilyBold,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryTextColor,
    ),
    displayMedium: TextStyle(
      fontFamily: fontFamilyMedium,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryTextColor,
    ),
    displaySmall: TextStyle(
      fontFamily: fontFamilyMedium,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryTextColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamilyRegular,
      fontSize: 18,
      color: AppColors.secondaryTextColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamilyRegular,
      fontSize: 16,
      color: AppColors.secondaryTextColor,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamilyRegular,
      fontSize: 14,
      color: AppColors.secondaryTextColor,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamilyMedium,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryTextColor,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamilyMedium,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryTextColor,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamilyMedium,
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryTextColor,
    ),
  );
}
