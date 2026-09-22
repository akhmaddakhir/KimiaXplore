import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';

enum QuizOptionState { normal, selected, correct, incorrect }

class QuizOptionCard extends StatelessWidget {
  const QuizOptionCard({
    super.key,
    required this.label,
    this.state = QuizOptionState.normal,
    this.onTap,
  });

  final String label;
  final QuizOptionState state;
  final VoidCallback? onTap;

  Color get _backgroundColor {
    switch (state) {
      case QuizOptionState.normal:
        return AppColors.surface;

      case QuizOptionState.selected:
        return AppColors.blue50;

      case QuizOptionState.correct:
        return AppColors.green50;

      case QuizOptionState.incorrect:
        return AppColors.red50;
    }
  }

  Color get _borderColor {
    switch (state) {
      case QuizOptionState.normal:
        return AppColors.border;

      case QuizOptionState.selected:
        return AppColors.blue500;

      case QuizOptionState.correct:
        return AppColors.green500;

      case QuizOptionState.incorrect:
        return AppColors.red500;
    }
  }

  Color get _textColor {
    switch (state) {
      case QuizOptionState.normal:
        return AppColors.textMedium;

      case QuizOptionState.selected:
        return AppColors.textDark;

      case QuizOptionState.correct:
        return AppColors.textDark;

      case QuizOptionState.incorrect:
        return AppColors.textDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 56,
        minWidth: double.infinity,
      ),
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: _backgroundColor,
          foregroundColor: _textColor,

          side: BorderSide(color: _borderColor, width: 2),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),

          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

          alignment: Alignment.centerLeft,

          textStyle: AppTypography.option.copyWith(
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),

        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(label, textAlign: TextAlign.left),
        ),
      ),
    );
  }
}
