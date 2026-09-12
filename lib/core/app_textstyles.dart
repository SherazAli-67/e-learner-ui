import 'package:e_learner/core/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const _fontFamily = 'Urbanist';

  static const displayLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: .w700,
    color: AppColors.whiteColor,
    height: 1.2,
  );

  static const headlineLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: .w700,
    color: AppColors.whiteColor,
    height: 1.3,
  );

  static const headlineMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: .w700,
    color: AppColors.whiteColor,
    height: 1.3,
  );

  static const titleLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: .w600,
    color: AppColors.whiteColor,
    height: 1.4,
  );

  static const titleMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: .w600,
    color: AppColors.whiteColor,
    height: 1.4,
  );

  static const bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: .w400,
    color: AppColors.whiteColor,
    height: 1.5,
  );

  static const bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: .w400,
    color: AppColors.secondaryTextColor,
    height: 1.5,
  );

  static const bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: .w400,
    color: AppColors.secondaryTextColor,
    height: 1.4,
  );

  static const labelLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: .w600,
    color: AppColors.blackColor,
    height: 1.2,
  );

  static const labelMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: .w500,
    color: AppColors.whiteColor,
    height: 1.2,
  );

  static const button = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: .w700,
    color: AppColors.blackColor,
    height: 1.2,
  );
}
