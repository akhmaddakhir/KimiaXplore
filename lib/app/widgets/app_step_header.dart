import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

class AppStepHeader extends StatelessWidget {
  final double progress;
  final VoidCallback? onBackPressed;
  final double height;
  final Color progressColor;
  final Color trackColor;
  final Color arrowColor;
  final EdgeInsetsGeometry padding;

  const AppStepHeader({
    super.key,
    required this.progress,
    this.onBackPressed,
    this.height = 14.0,
    this.progressColor = AppColors.green500,
    this.trackColor = AppColors.textHint,
    this.arrowColor = AppColors.textDark,
    this.padding = const EdgeInsets.fromLTRB(
      AppSpacing.xl, // 24.0 (mentok sejajar margin kiri)
      AppSpacing.md, // 12.0
      AppSpacing.xl, // 24.0
      AppSpacing.md, // 12.0
    ),
  });

  /// Constructor helper jika ingin memakai hitungan step (misal step 1 dari 8)
  factory AppStepHeader.steps({
    Key? key,
    required int currentStep,
    required int totalSteps,
    VoidCallback? onBackPressed,
    double height = 14.0,
    Color progressColor = AppColors.green500,
    Color trackColor = AppColors.textHint,
    Color arrowColor = AppColors.textDark,
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(
      AppSpacing.xl, // 24.0
      AppSpacing.md, // 12.0
      AppSpacing.xl, // 24.0
      AppSpacing.md, // 12.0
    ),
  }) {
    final calculatedProgress = totalSteps > 0
        ? (currentStep / totalSteps).clamp(0.0, 1.0)
        : 0.0;

    return AppStepHeader(
      key: key,
      progress: calculatedProgress,
      onBackPressed: onBackPressed,
      height: height,
      progressColor: progressColor,
      trackColor: trackColor,
      arrowColor: arrowColor,
      padding: padding,
    );
  }

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);

    return Padding(
      padding: padding,
      child: Row(
        children: [
          SizedBox(
            width: 26,
            height: 26,
            child: OverflowBox(
              minWidth: 40,
              maxWidth: 40,
              minHeight: 40,
              maxHeight: 40,
              child: IconButton(
                onPressed: onBackPressed,
                icon: const Icon(Icons.arrow_back_rounded),
                color: arrowColor,
                iconSize: 26,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                splashRadius: 20,
              ),
            ),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: Container(
                height: height,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: trackColor,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: constraints.maxWidth * clampedProgress,
                        height: height,
                        decoration: BoxDecoration(
                          color: progressColor,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
