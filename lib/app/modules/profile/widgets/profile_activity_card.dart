import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';
import '../controllers/profile_controller.dart';
import '../models/profile_activity_model.dart';

class ProfileActivityCard extends GetView<ProfileController> {
  const ProfileActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final activities = controller.activities;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: AppColors.border, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'profile_recent_activity'.tr,
              style: AppTypography.heading2.copyWith(
                color: AppColors.textDark,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            if (controller.isLoadingProfile.value && activities.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.blue500),
                ),
              )
            else if (activities.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'profile_no_activity'.tr,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                ),
              )
            else
              ...List.generate(activities.length, (index) {
                final activity = activities[index];

                return _ActivityItem(
                  activity: activity,
                  showDivider: index < activities.length - 1,
                );
              }),
          ],
        ),
      );
    });
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({required this.activity, required this.showDivider});

  final ProfileActivityModel activity;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(_icon, color: _iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.activityTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      activity.topicTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                    if (activity.timeText.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        activity.timeText,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                activity.statusText,
                style: AppTypography.bodySmall.copyWith(
                  color: activity.isCompleted
                      ? AppColors.green700
                      : AppColors.blue500,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        if (showDivider) const Divider(height: 1, color: AppColors.border),
      ],
    );
  }

  IconData get _icon {
    switch (activity.activityType) {
      case 'material':
        return Icons.menu_book_rounded;

      case 'quiz':
        return Icons.quiz_outlined;

      case 'flashcard':
        return Icons.style_outlined;

      case 'simulation':
        return Icons.science_outlined;

      default:
        return Icons.history_rounded;
    }
  }

  Color get _backgroundColor {
    switch (activity.activityType) {
      case 'material':
        return AppColors.blue50;

      case 'quiz':
        return AppColors.green50;

      case 'flashcard':
        return AppColors.yellow50;

      default:
        return AppColors.blue50;
    }
  }

  Color get _iconColor {
    switch (activity.activityType) {
      case 'material':
        return AppColors.blue500;

      case 'quiz':
        return AppColors.green700;

      case 'flashcard':
        return AppColors.yellow700;

      default:
        return AppColors.blue500;
    }
  }
}
