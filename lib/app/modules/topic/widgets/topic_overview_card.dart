import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../../home/models/topic_model.dart';

class TopicOverviewCard extends StatelessWidget {
  const TopicOverviewCard({
    super.key,
    required this.topic,
    this.onStartPressed,
    this.customCategory,
    this.customButtonLabel,
  });

  final TopicModel topic;
  final VoidCallback? onStartPressed;
  final String? customCategory;
  final String? customButtonLabel;

  bool get _hasProgress => topic.completedLessons > 0;

  String get _category =>
      customCategory ??
      (_hasProgress ? 'Lanjutkan aktivitas' : 'Rekomendasi aktivitas');

  String get _title =>
      _hasProgress ? 'Lanjutkan Belajar' : 'Mulai Pembelajaran';

  String get _buttonLabel =>
      customButtonLabel ?? (_hasProgress ? 'Lanjutkan' : 'Mulai Sekarang');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        width: double.infinity,
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
            _buildCategory(),

            const SizedBox(height: 16),

            _buildContent(),

            const SizedBox(height: 16),

            if (_hasProgress) ...[_buildProgress(), const SizedBox(height: 14)],

            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory() {
    return Text(
      _category,
      style: const TextStyle(
        fontFamily: AppTypography.fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF758A83),
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildContent() {
    final imageAsset = topic.imageAsset;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (imageAsset != null && imageAsset.isNotEmpty) ...[
          SizedBox(
            width: 72,
            height: 72,
            child: Image.asset(imageAsset, fit: BoxFit.contain),
          ),

          const SizedBox(width: 16),
        ],

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _title,
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E352F),
                  height: 1.25,
                ),
              ),

              const SizedBox(height: 6),

              Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF758A83),
                    height: 1.3,
                  ),
                  children: [
                    const TextSpan(text: 'Materi'),
                    _buildInlineArrow(),
                    const TextSpan(text: 'Flashcard'),
                    _buildInlineArrow(),
                    const TextSpan(text: 'Kuis'),
                    _buildInlineArrow(),
                    const TextSpan(text: 'Simulasi'),
                  ],
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Pelajari materi dari awal secara bertahap untuk pemahaman yang optimal.',
                style: TextStyle(
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
    );
  }

  Widget _buildProgress() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: LinearProgressIndicator(
        value: topic.progress,
        minHeight: 8,
        backgroundColor: AppColors.border,
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.green500),
      ),
    );
  }

  Widget _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: AppButton.primary(
        label: _buttonLabel,
        height: 48,
        textStyle: AppTypography.option,
        onPressed: onStartPressed,
      ),
    );
  }

  WidgetSpan _buildInlineArrow() {
    return const WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Icon(
          Icons.arrow_forward_rounded,
          size: 13,
          color: AppColors.textHint,
        ),
      ),
    );
  }
}
