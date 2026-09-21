import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_detail_header.dart';
import '../controllers/topic_controller.dart';

class TopicView extends GetView<TopicController> {
  const TopicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppDetailHeader(title: 'Detail Topik'),

            Expanded(
              child: Obx(() {
                final currentTopic = controller.topic.value;

                if (currentTopic == null) {
                  return const Center(
                    child: Text(
                      'Pilih materi terlebih dahulu',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        color: AppColors.textMedium,
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentTopic.title,
                        style: AppTypography.heading1.copyWith(
                          color: AppColors.textDark,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.sm),

                      Text(
                        currentTopic.subtitle,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textMedium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.md),

                      Text(
                        currentTopic.description,
                        style: AppTypography.body.copyWith(
                          color: AppColors.textMedium,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
