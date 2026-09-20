import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';

class OnboardingOptionCard extends StatelessWidget {
  const OnboardingOptionCard({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.height = 52,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.blue50 : AppColors.surface,
          foregroundColor: isSelected
              ? AppColors.textDark
              : AppColors.textMedium,
          side: BorderSide(
            color: isSelected ? AppColors.blue700 : AppColors.border,
            width: 2.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          textStyle: AppTypography.option,
        ),
        child: Text(label),
      ),
    );
  }
}
