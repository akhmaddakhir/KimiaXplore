import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../widgets/app_button.dart';

class FlashcardBottomBar extends StatelessWidget {
  const FlashcardBottomBar({
    super.key,
    required this.isFlipped,
    required this.onNotMemorized,
    required this.onMemorized,
  });

  final bool isFlipped;
  final VoidCallback? onNotMemorized;
  final VoidCallback? onMemorized;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
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
          children: [
            Expanded(
              child: AppButton(
                label: 'Belum Hafal',
                height: 52,
                gradientColors: const [AppColors.surface, AppColors.surface],
                shadowColor: AppColors.red100,
                textColor: AppColors.red700,
                border: Border.all(color: AppColors.lightRed, width: 2),
                onPressed: isFlipped ? onNotMemorized : null,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppButton(
                label: 'Hafal',
                height: 52,
                gradientColors: const [
                  AppColors.lightGreen,
                  AppColors.green500,
                ],
                shadowColor: AppColors.green700,
                textColor: AppColors.surface,
                onPressed: isFlipped ? onMemorized : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
