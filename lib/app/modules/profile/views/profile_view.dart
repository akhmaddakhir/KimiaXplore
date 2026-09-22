import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../widgets/app_main_header.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_activity_card.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_stat_badge_card.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppMainHeader(
              title: 'Profile',
              actions: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.toNamed(AppRoutes.settings);
                  },
                  child: const SizedBox(
                    width: 36,
                    height: 36,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.settings_rounded,
                        color: AppColors.textDark,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ],
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.blue500,
                onRefresh: controller.loadProfileProgress,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.sm,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProfileHeaderCard(),
                      const SizedBox(height: 16),
                      Obx(
                        () => Row(
                          children: [
                            Expanded(
                              child: ProfileStatBadgeCard(
                                value: '${controller.completedTopics.value}',
                                label: 'Topik Selesai',
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: ProfileStatBadgeCard(
                                value: '${controller.totalBadges.value}',
                                label: 'Total Badge',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const ProfileActivityCard(),
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
