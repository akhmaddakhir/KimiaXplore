import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../home/models/topic_model.dart';

class TopicSummary extends StatelessWidget {
  const TopicSummary({super.key, required this.topic});

  final TopicModel topic;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.green50,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: AppColors.green100, width: 1.5),
          ),
          child: Text(
            'material_chemistry_level'.trParams({
              'level': topic.localizedLevel,
            }),
            style: AppTypography.caption.copyWith(
              color: AppColors.darkTeal,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        Text(
          topic.localizedTitle,
          style: AppTypography.heading1.copyWith(color: AppColors.textDark),
        ),

        const SizedBox(height: AppSpacing.sm),

        Text(
          topic.localizedDescription,
          style: AppTypography.bodySmall.copyWith(color: AppColors.textMedium),
        ),

        const SizedBox(height: AppSpacing.md),

        Text(
          '${topic.totalLessons} ${'home_lessons'.tr} • '
          '${topic.localizedLevel}',
          style: AppTypography.caption.copyWith(color: AppColors.textMedium),
        ),
      ],
    );
  }
}
