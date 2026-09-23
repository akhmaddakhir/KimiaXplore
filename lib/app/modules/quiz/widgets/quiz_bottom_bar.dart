import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../widgets/app_button.dart';

enum QuizBottomState { answering, correct, incorrect }

class QuizBottomBar extends StatelessWidget {
  const QuizBottomBar({
    super.key,
    required this.state,
    required this.onPressed,
    this.mascot,
  });

  final QuizBottomState state;
  final VoidCallback? onPressed;
  final Widget? mascot;

  bool get _isAnswering => state == QuizBottomState.answering;

  Color get _backgroundColor {
    switch (state) {
      case QuizBottomState.answering:
        return AppColors.background;

      case QuizBottomState.correct:
        return AppColors.green100;

      case QuizBottomState.incorrect:
        return AppColors.red100;
    }
  }

  String get _buttonLabel {
    return _isAnswering ? 'quiz_check'.tr : 'quiz_continue'.tr;
  }

  List<Color> get _buttonGradient {
    switch (state) {
      case QuizBottomState.answering:
        return const [AppColors.lightBlue, AppColors.blue500];

      case QuizBottomState.correct:
        return const [AppColors.lightGreen, AppColors.green500];

      case QuizBottomState.incorrect:
        return const [AppColors.lightRed, AppColors.red500];
    }
  }

  Color get _buttonShadow {
    switch (state) {
      case QuizBottomState.answering:
        return AppColors.blue700;

      case QuizBottomState.correct:
        return AppColors.green700;

      case QuizBottomState.incorrect:
        return AppColors.red700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: double.infinity,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildMascot(),

            const SizedBox(width: AppSpacing.lg),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _buildButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMascot() {
    return SizedBox(
      width: 80,
      height: 100,
      child: mascot ?? const SizedBox.shrink(),
    );
  }

  Widget _buildButton() {
    return AppButton(
      label: _buttonLabel,
      height: 52,
      gradientColors: _buttonGradient,
      shadowColor: _buttonShadow,
      textColor: AppColors.surface,
      onPressed: onPressed,
    );
  }
}
