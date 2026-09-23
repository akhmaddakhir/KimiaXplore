import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';

class QuizExplanationSheet extends StatelessWidget {
  const QuizExplanationSheet({super.key, required this.explanation});

  final String explanation;

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * 0.5;

    return PopScope(
      canPop: false,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xxl),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xxl,
              AppSpacing.xl,
              AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'quiz_explanation'.tr,
                  style: AppTypography.heading1.copyWith(
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Flexible(
                  fit: FlexFit.loose,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      explanation.trim().isEmpty
                          ? 'quiz_explanation_unavailable'.tr
                          : explanation,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textDark,
                        height: 1.7,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Center(
                  child: Material(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      child: const SizedBox(
                        width: 56,
                        height: 48,
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 36,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
