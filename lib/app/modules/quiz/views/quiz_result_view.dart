import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';

import '../controllers/quiz_controller.dart';
import '../widgets/quiz_result_stat_card.dart';

class QuizResultView extends GetView<QuizController> {
  const QuizResultView({
    super.key,
    this.mascot,
    this.onDiscussion,
    required this.onContinue,
  });

  final Widget? mascot;
  final VoidCallback? onDiscussion;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.xl,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Column(
                      children: [
                        const SizedBox(height: AppSpacing.xxl),
                        SizedBox(
                          width: 180,
                          height: 180,
                          child: mascot ?? const SizedBox.shrink(),
                        ),
                        const SizedBox(height: AppSpacing.xxxl),
                        Text(
                          'Saatnya evaluasi',
                          textAlign: TextAlign.center,
                          style: AppTypography.heading1.copyWith(
                            color: AppColors.textDark,
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxxl),
                        const SizedBox(height: AppSpacing.lg),
                        Obx(() {
                          final correctAnswers = controller.score.value;

                          final incorrectAnswers =
                              controller.totalQuestions - correctAnswers;

                          return ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 160),
                            child: Column(
                              children: [
                                QuizResultStatCard(
                                  label: 'Benar',
                                  value: correctAnswers,
                                  icon: Icons.check_rounded,
                                  backgroundColor: AppColors.green50,
                                  foregroundColor: AppColors.green700,
                                  borderColor: AppColors.green100,
                                ),
                                const SizedBox(height: AppSpacing.md),
                                QuizResultStatCard(
                                  label: 'Salah',
                                  value: incorrectAnswers,
                                  icon: Icons.close_rounded,
                                  backgroundColor: AppColors.red50,
                                  foregroundColor: AppColors.red700,
                                  borderColor: AppColors.red100,
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      child: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppButton.outline(label: 'Pembahasan', onPressed: onDiscussion),
                const SizedBox(height: AppSpacing.lg),
                AppButton.primary(label: 'Lanjut', onPressed: onContinue),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
