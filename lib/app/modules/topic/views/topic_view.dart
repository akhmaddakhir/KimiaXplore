import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_detail_header.dart';
import '../controllers/topic_controller.dart';
import '../widgets/topic_overview_card.dart';
import '../widgets/topic_summary.dart';

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
            const AppDetailHeader(title: 'Detail'),

            Expanded(
              child: Obx(() {
                final topic = controller.topic.value;

                if (topic == null) {
                  return Center(
                    child: Text(
                      'Pilih materi terlebih dahulu',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xl,
                    AppSpacing.sm,
                    AppSpacing.xl,
                    AppSpacing.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.sm),

                      TopicSummary(topic: topic),

                      const SizedBox(height: AppSpacing.xl),

                      TopicOverviewCard(
                        topic: topic,
                        onStartPressed: () {
                          // Mengarahkan ke aktivitas rekomendsi topik
                        },
                      ),

                      const SizedBox(height: AppSpacing.xl),
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
