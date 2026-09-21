import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_detail_header.dart';
import '../controllers/topic_controller.dart';
import '../models/topic_activity_type.dart';
import '../widgets/topic_activity_card.dart';
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
                          controller.onActivitySelected(
                            TopicActivityType.materi,
                          );
                        },
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      Text(
                        'Aktivitas',
                        style: AppTypography.heading2.copyWith(
                          color: AppColors.textDark,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.md),

                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: TopicActivityType.values.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppSpacing.md),
                        itemBuilder: (context, index) {
                          final activity = TopicActivityType.values[index];

                          return TopicActivityCard.fromType(
                            type: activity,
                            onTap: () {
                              controller.onActivitySelected(activity);
                            },
                          );
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
