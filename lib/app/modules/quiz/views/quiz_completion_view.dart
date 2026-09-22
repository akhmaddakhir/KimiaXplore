import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../controllers/quiz_controller.dart';

class QuizCompletionView extends GetView<QuizController> {
  const QuizCompletionView({super.key, this.mascot, required this.onContinue});

  final Widget? mascot;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.blue100, AppColors.background],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                  ),
                  child: Column(
                    children: [
                      const Spacer(flex: 2),
                      SizedBox(
                        height: 240,
                        width: 240,
                        child: mascot ?? const SizedBox.shrink(),
                      ),
                      const Spacer(flex: 2),
                      Text(
                        'Latihan selesai!',
                        textAlign: TextAlign.center,
                        style: AppTypography.heading1.copyWith(
                          color: AppColors.textDark,
                          fontSize: 32,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: AppColors.background,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xl,
                    AppSpacing.xl,
                    AppSpacing.xl,
                    AppSpacing.xl,
                  ),
                  child: Column(
                    children: [
                      const Spacer(),
                      Text(
                        'Skor Total',
                        style: AppTypography.title.copyWith(
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Obx(() {
                        final totalQuestions = controller.totalQuestions;

                        final totalScore = totalQuestions == 0
                            ? 0
                            : ((controller.score.value / totalQuestions) * 100)
                                  .round();

                        return Text(
                          '$totalScore',
                          style: AppTypography.heading1.copyWith(
                            color: AppColors.blue500,
                            fontSize: 64,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        );
                      }),
                      const Spacer(flex: 2),
                      AppButton.primary(label: 'Lanjut', onPressed: onContinue),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
