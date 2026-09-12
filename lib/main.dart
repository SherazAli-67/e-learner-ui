import 'package:e_learner/constants/string_const.dart';
import 'package:e_learner/core/app_colors.dart';
import 'package:e_learner/core/app_textstyles.dart';
import 'package:e_learner/router/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConst.appTitle,
      theme: ThemeData(
        brightness: .dark,
        fontFamily: 'Urbanist',
        scaffoldBackgroundColor: AppColors.blackColor,
        colorScheme: .dark(
          primary: AppColors.primaryColor,
          surface: AppColors.surfaceColor,
          onPrimary: AppColors.blackColor,
          onSurface: AppColors.whiteColor,
        ),
        textTheme: const TextTheme(
          displayLarge: AppTextStyles.displayLarge,
          headlineLarge: AppTextStyles.headlineLarge,
          headlineMedium: AppTextStyles.headlineMedium,
          titleLarge: AppTextStyles.titleLarge,
          titleMedium: AppTextStyles.titleMedium,
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
          labelLarge: AppTextStyles.labelLarge,
          labelMedium: AppTextStyles.labelMedium,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.blackColor,
          foregroundColor: AppColors.whiteColor,
          elevation: 0,
        ),
      ),
      routerConfig: router,
      builder: (ctx, child) => child!,
    );
  }
}
