import 'package:e_learner/constants/string_const.dart';
import 'package:e_learner/core/app_colors.dart';
import 'package:e_learner/core/app_textstyles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Center(child: Text(StringConst.homeTab, style: AppTextStyles.headlineMedium,)),
    );
  }
}
