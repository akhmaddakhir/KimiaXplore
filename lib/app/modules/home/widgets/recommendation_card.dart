import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_progress_bar.dart';
import '../models/topic_model.dart';

class RecommendationCard extends StatelessWidget {
  final TopicModel topic;
  final String? customCategory;
  final String? customButtonLabel;
  final VoidCallback? onButtonPressed;

  const RecommendationCard({
    super.key,
    required this.topic,
    this.customCategory,
    this.customButtonLabel,
    this.onButtonPressed,
  });

  bool get _hasProgress => topic.completedLessons > 0;

  String get _category {
    if (customCategory != null) {
      return customCategory!;
    }

    return _hasProgress ? 'Lanjutkan belajar' : 'Rekomendasi materi';
  }

  String get _buttonLabel {
    if (customButtonLabel != null) {
      return customButtonLabel!;
    }

    return _hasProgress ? 'Lanjutkan' : 'Coba Sekarang';
  }

  @override
  Widget build(BuildContext context) {
    final imageAsset = topic.imageAsset;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: AppColors.border, width: 2),
          boxShadow: const [
            BoxShadow(
              color: AppColors.border,
              offset: Offset(0, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: imageAsset != null && imageAsset.isNotEmpty
                      ? Image.asset(imageAsset, fit: BoxFit.contain)
                      : const SizedBox.shrink(),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.title,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E352F),
                          height: 1.25,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        topic.subtitle,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF758A83),
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        topic.description,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF758A83),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (_hasProgress) ...[
              AppProgressBar(value: topic.progress),

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
