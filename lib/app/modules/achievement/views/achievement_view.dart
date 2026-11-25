import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_main_header.dart';
import '../controllers/achievement_controller.dart';
import '../widgets/achievement_badge_card.dart';
import '../widgets/personal_record_card.dart';

class AchievementView extends GetView<AchievementController> {
  const AchievementView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AchievementController>()) {
      Get.put(AchievementController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppMainHeader(
              title: 'Achievement',
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: AppSpacing.sm,
                  bottom: AppSpacing.xxxl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                      ),
                      child: Text(
                        'Rekor Personal',
                        style: AppTypography.heading2.copyWith(
                          color: AppColors.textDark,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      height: 212,
                      child: Obx(
                        () => ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xl,
                          ),
                          itemCount: controller.personalRecords.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: AppSpacing.md),
                          itemBuilder: (context, index) {
                            final record = controller.personalRecords[index];
                            return PersonalRecordCard(
                              record: record,
                              onTap: () {},
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                      ),
                      child: Text(
                        'Penghargaan',
                        style: AppTypography.heading2.copyWith(
                          color: AppColors.textDark,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                      ),
                      child: Obx(
                        () => GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.achievements.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: AppSpacing.md,
                            mainAxisSpacing: AppSpacing.lg,
                            mainAxisExtent: 158,
                          ),
                          itemBuilder: (context, index) {
                            final item = controller.achievements[index];
                            return AchievementBadgeCard(
                              achievement: item,
                              onTap: () {},
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
