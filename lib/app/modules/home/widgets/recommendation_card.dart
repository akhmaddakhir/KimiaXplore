import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_progress_bar.dart';
import '../models/topic_model.dart';

class RecommendationCard extends StatelessWidget {
  final TopicModel topic;
  final bool isContinuing;
  final String? customCategory;
  final String? customButtonLabel;
  final VoidCallback? onButtonPressed;

  const RecommendationCard({
    super.key,
    required this.topic,
    this.isContinuing = false,
    this.customCategory,
    this.customButtonLabel,
    this.onButtonPressed,
  });

  bool get _hasProgress => isContinuing;

  String get _category {
    if (customCategory != null) {
      return customCategory!;
    }

    return _hasProgress
        ? 'home_continue_learning'.tr
        : 'home_recommended_topic'.tr;
  }

  String get _buttonLabel {
    if (customButtonLabel != null) {
      return customButtonLabel!;
    }

    return _hasProgress ? 'home_continue'.tr : 'home_try_now'.tr;
  }

  IconData _getTopicIcon(String topicId) {
    switch (topicId) {
      case 'atomic_structure':
        return Icons.bubble_chart_rounded;
      case 'periodic_table':
        return Icons.grid_view_rounded;
      case 'chemical_bonding':
        return Icons.hub_rounded;
      default:
        return Icons.science_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageAsset = topic.imageAsset;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: AppColors.border, width: 2),
          boxShadow: const [
            BoxShadow(
              color: AppColors.border,
              offset: Offset(0, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _category,
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF758A83),
                    letterSpacing: 0.2,
                  ),
                ),
                if (_hasProgress)
                  Text(
                    '${(topic.progress * 100).toInt()}% ${'home_completed'.tr}',
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.green700,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: _hasProgress ? AppColors.green50 : AppColors.blue50,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: _hasProgress
                          ? AppColors.green100
                          : AppColors.blue100,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: (imageAsset != null && imageAsset.isNotEmpty)
                        ? Image.asset(imageAsset, fit: BoxFit.contain)
                        : Icon(
                            _getTopicIcon(topic.id),
                            color: _hasProgress
                                ? AppColors.green700
                                : AppColors.blue500,
                            size: 32,
                          ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.localizedTitle,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E352F),
                          height: 1.25,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        topic.localizedDescription,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF758A83),
                          height: 1.35,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (_hasProgress) ...[
              AppProgressBar(
                value: topic.progress,
                height: 10,
                progressColor: AppColors.green500,
              ),

              const SizedBox(height: 14),
            ],

            SizedBox(
              width: double.infinity,
              child: AppButton.primary(
                label: _buttonLabel,
                height: 48,
                textStyle: AppTypography.option,
                onPressed: onButtonPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
