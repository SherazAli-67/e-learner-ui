import 'package:e_learner/core/app_colors.dart';
import 'package:e_learner/core/app_textstyles.dart';
import 'package:flutter/material.dart';

enum PrimaryButtonVariant {
  primary,
  light,
  dark,
  outlined,
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final PrimaryButtonVariant variant;
  final double? width;
  final double height;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = .primary,
    this.width,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: Material(
        color: _backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(16),
          side: variant == .outlined
              ? const BorderSide(color: AppColors.borderColor)
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: .circular(16),
          child: Center(child: Text(label, style: _textStyle,)),
        ),
      ),
    );
  }

  Color get _backgroundColor => switch (variant) {
        .primary => AppColors.primaryColor,
        .light => AppColors.whiteColor,
        .dark => AppColors.cardColor,
        .outlined => Colors.transparent,
      };

  TextStyle get _textStyle => switch (variant) {
        .primary => AppTextStyles.button,
        .light => AppTextStyles.button,
        .dark => AppTextStyles.button.copyWith(color: AppColors.whiteColor),
        .outlined => AppTextStyles.labelMedium,
      };
}
