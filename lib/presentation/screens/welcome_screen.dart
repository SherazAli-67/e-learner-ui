import 'package:e_learner/constants/string_const.dart';
import 'package:e_learner/core/app_colors.dart';
import 'package:e_learner/core/app_icons.dart';
import 'package:e_learner/core/app_textstyles.dart';
import 'package:e_learner/presentation/widgets/primary_button.dart';
import 'package:e_learner/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 24),
          child: Column(
            spacing: 24,
            children: [
              const SizedBox(height: 8),
              SvgPicture.asset(AppIcons.logoWithText, height: 40,),
              Expanded(child: _buildCollage()),
              Text(StringConst.welcomeHeadline, style: AppTextStyles.headlineLarge, textAlign: .center,),
              Text(StringConst.welcomeSubtitle, style: AppTextStyles.bodyMedium, textAlign: .center,),
              PrimaryButton(
                label: StringConst.getStarted,
                variant: .light,
                onPressed: () => context.go(NamedRoutes.home.routeName),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollage() {
    return Column(
      spacing: 12,
      children: [
        Expanded(
          child: Row(
            spacing: 12,
            children: [
              Expanded(child: _buildCollageTile(AppIcons.welcomeImg1)),
              Expanded(child: _buildCollageTile(AppIcons.welcomeImg3)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            spacing: 12,
            children: [
              Expanded(child: _buildCollageTile(AppIcons.welcomeImg2)),
              Expanded(child: _buildCollageTile(AppIcons.welcomeImg4)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCollageTile(String asset) {
    return ClipRRect(
      borderRadius: .circular(24),
      child: Image.asset(asset, width: double.infinity, height: double.infinity,),
    );
  }
}
