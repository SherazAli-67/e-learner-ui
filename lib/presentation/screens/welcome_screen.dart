import 'package:e_learner/constants/string_const.dart';
import 'package:e_learner/core/app_colors.dart';
import 'package:e_learner/core/app_icons.dart';
import 'package:e_learner/core/app_textstyles.dart';
import 'package:e_learner/presentation/widgets/primary_button.dart';
import 'package:e_learner/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MediaQuery.disableAnimationsOf(context)) {
        _controller.value = 1;
        return;
      }
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              _buildAnimated(
                begin: 0,
                end: 0.2,
                child: SvgPicture.asset(AppIcons.logoWithText, height: 40,),
              ),
              Expanded(child: _buildCollage()),
              _buildAnimated(
                begin: 0.45,
                end: 0.7,
                slide: 24,
                child: Text(StringConst.welcomeHeadline, style: AppTextStyles.headlineLarge, textAlign: .center,),
              ),
              _buildAnimated(
                begin: 0.55,
                end: 0.8,
                slide: 20,
                child: Text(StringConst.welcomeSubtitle, style: AppTextStyles.bodyMedium, textAlign: .center,),
              ),
              _buildAnimated(
                begin: 0.7,
                end: 1,
                slide: 16,
                child: PrimaryButton(
                  label: StringConst.getStarted,
                  variant: .light,
                  onPressed: () => context.go(NamedRoutes.home.routeName),
                ),
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
              Expanded(child: _buildCollageTile(AppIcons.welcomeImg1, 0)),
              Expanded(child: _buildCollageTile(AppIcons.welcomeImg3, 1)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            spacing: 12,
            children: [
              Expanded(child: _buildCollageTile(AppIcons.welcomeImg2, 2)),
              Expanded(child: _buildCollageTile(AppIcons.welcomeImg4, 3)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCollageTile(String asset, int index) {
    final begin = 0.12 + (index * 0.06);
    final end = (begin + 0.28).clamp(0.0, 1.0);
    return _buildAnimated(
      begin: begin,
      end: end,
      scale: true,
      child: ClipRRect(
        borderRadius: .circular(24),
        child: Image.asset(asset, width: double.infinity, height: double.infinity,),
      ),
    );
  }

  Widget _buildAnimated({
    required double begin,
    required double end,
    required Widget child,
    double slide = 0,
    bool scale = false,
  }) {
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );
    return AnimatedBuilder(
      animation: curved,
      builder: (_, child) {
        final t = curved.value;
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, slide * (1 - t)),
            child: scale
                ? Transform.scale(scale: 0.96 + (0.04 * t), child: child)
                : child,
          ),
        );
      },
      child: child,
    );
  }
}
