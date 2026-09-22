import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';

class QuizQuestionHeader extends StatelessWidget {
  const QuizQuestionHeader({
    super.key,
    required this.questionNumber,
    required this.question,
    this.onReportPressed,
  });

  final int questionNumber;
  final String question;
  final VoidCallback? onReportPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xl),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'No. $questionNumber',
                style: AppTypography.heading2.copyWith(
                  color: AppColors.textDark,
                ),
              ),

              _buildReportButton(),
            ],
          ),

          const SizedBox(height: AppSpacing.xl),

          Text(
            question,
            style: AppTypography.body.copyWith(
              color: AppColors.textDark,
              fontWeight: FontWeight.w700,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportButton() {
    return Material(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onReportPressed,
        borderRadius: BorderRadius.circular(12),
        splashColor: AppColors.blue100,
        highlightColor: AppColors.blue50,
        child: const SizedBox(
          width: 44,
          height: 44,
          child: Icon(
            Icons.outlined_flag_rounded,
            size: 26,
            color: AppColors.textDark,
          ),
        ),
      ),
    );
  }
}
