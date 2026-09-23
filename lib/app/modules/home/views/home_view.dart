import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_main_header.dart';
import '../../../widgets/app_stat_chip.dart';
import '../controllers/home_controller.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/topic_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppMainHeader(
              title: 'Home',
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
              actions: [
                Obx(
                  () => AppStatChip(
                    icon: const Icon(
                      Icons.event_available_rounded,
                      size: 18,
                      color: AppColors.green700,
                    ),
                    value: '${controller.studyProgress.value}',
                    tooltip: 'home_study_progress'.tr,
                    backgroundColor: AppColors.green50,
                    borderColor: AppColors.green100,
                    textColor: AppColors.green700,
                    onTap: () {},
                  ),
                ),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.green500,
                onRefresh: controller.loadHomeData,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.sm,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Obx(
                        () => Text(
                          'home_greeting'.trParams({
                            'name': controller.userName.value,
                          }),
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF758A83),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'home_explore_prompt'.tr,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E352F),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(() {
                        final topic = controller.recommendedTopic.value;

                        if (topic == null) {
                          return const SizedBox.shrink();
                        }

                        return RecommendationCard(
                          topic: topic,
                          isContinuing: controller.hasUserProgress.value,
                          onButtonPressed: controller.onRecommendedTopicPressed,
                        );
                      }),
                      const SizedBox(height: 28),
                      Text(
                        'home_chemistry_foundations'.tr,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E352F),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'home_foundations_desc'.tr,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF758A83),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.topics.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            final topic = controller.topics[index];

                            return TopicCard(
                              topic: topic,
                              onTap: () {
                                controller.onTopicSelected(topic);
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
