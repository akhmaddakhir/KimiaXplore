import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_activity_card.dart';
import '../widgets/profile_stat_badge_card.dart';
import 'edit_avatar_view.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Bagian atas ala Duolingo: full-bleed hero dengan back, nama, settings, dan avatar dari asset
          Obx(
            () => Container(
              width: double.infinity,
              color: controller.selectedAvatarBg.value,
              child: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                        vertical: AppSpacing.md,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (Navigator.canPop(context)) {
                                Get.back<void>();
                              }
                            },
                            child: const SizedBox(
                              width: 36,
                              height: 36,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  color: AppColors.textDark,
                                  size: 26,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              controller.userName.value,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.heading2.copyWith(
                                color: AppColors.textDark,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
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
                                  Icons.settings_outlined,
                                  color: AppColors.textDark,
                                  size: 26,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Get.to(() => const EditAvatarView()),
                      child: SizedBox(
                        width: double.infinity,
                        height: 172,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SvgPicture.asset(
                            controller.selectedAvatarAsset.value,
                            width: 168,
                            height: 168,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                  vertical: AppSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: ProfileStatBadgeCard(
                              value: '${controller.completedTopics.value}',
                              label: 'profile_completed_topics'.tr,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: ProfileStatBadgeCard(
                              value: '${controller.totalBadges.value}',
                              label: 'profile_total_badges'.tr,
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
    );
  }
}
