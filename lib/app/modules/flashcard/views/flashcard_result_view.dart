import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/activity_navigation.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../../quiz/widgets/quiz_result_stat_card.dart';
import '../controllers/flashcard_controller.dart';

class FlashcardResultView extends GetView<FlashcardController> {
  const FlashcardResultView({
    super.key,
    this.mascot,
    required this.onRetry,
    required this.onFinish,
  });

  final Widget? mascot;
  final VoidCallback onRetry;
  final VoidCallback onFinish;

  bool get isRecommended {
    final arguments = Get.arguments;

    return arguments is ActivityNavigation && arguments.isRecommended;
  }

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
                          'Flashcard Selesai!',
                          textAlign: TextAlign.center,
                          style: AppTypography.heading1.copyWith(
                            color: AppColors.textDark,
                            fontSize: 32,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.lg),

                        Text(
                          'Kamu sudah mempelajari semua kartu.',
                          textAlign: TextAlign.center,
                          style: AppTypography.body.copyWith(
                            color: AppColors.textMedium,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.xxxl),

                        Obx(() {
                          final memorizedCount = controller.memorizedCount;

                          final notMemorizedCount =
                              controller.notMemorizedCount;

                          return ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 160),
                            child: Column(
                              children: [
                                QuizResultStatCard(
                                  label: 'Hafal',
                                  value: memorizedCount,
                                  icon: Icons.check_rounded,
                                  backgroundColor: AppColors.green50,
                                  foregroundColor: AppColors.green700,
                                  borderColor: AppColors.green100,
                                ),

                                const SizedBox(height: AppSpacing.md),

                                QuizResultStatCard(
                                  label: 'Belum Hafal',
                                  value: notMemorizedCount,
                                  icon: Icons.refresh_rounded,
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
            child: Obx(() {
              final hasNotMemorized = controller.notMemorizedCount > 0;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasNotMemorized) ...[
                    AppButton.outline(
                      label: 'Ulangi yang Belum Hafal',
                      onPressed: onRetry,
                    ),

                    const SizedBox(height: AppSpacing.lg),
                  ],

                  AppButton.primary(
                    label: isRecommended ? 'Kembali ke Topik' : 'Selesai',
                    onPressed: onFinish,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
