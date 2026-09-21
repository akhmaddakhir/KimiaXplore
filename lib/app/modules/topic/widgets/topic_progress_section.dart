import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_progress_bar.dart';

class TopicProgressSection extends StatelessWidget {
  const TopicProgressSection({
    super.key,
    required this.completed,
    required this.total,
  });

  final int completed;
  final int total;

  double get _progress => total > 0 ? (completed / total).clamp(0.0, 1.0) : 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress Belajar',
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            Text(
              '$completed/$total',
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        AppProgressBar(value: _progress),
      ],
    );
  }
}
