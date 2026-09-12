import 'package:e_learner/constants/string_const.dart';
import 'package:e_learner/core/app_colors.dart';
import 'package:e_learner/core/app_textstyles.dart';
import 'package:flutter/material.dart';

class PlaceholderTabScreen extends StatelessWidget {
  final String title;

  const PlaceholderTabScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Center(
        child: Column(
          spacing: 8,
          mainAxisSize: .min,
          children: [
            Text(title, style: AppTextStyles.headlineMedium,),
            Text(StringConst.comingSoon, style: AppTextStyles.bodyMedium,),
          ],
        ),
      ),
    );
  }
}
