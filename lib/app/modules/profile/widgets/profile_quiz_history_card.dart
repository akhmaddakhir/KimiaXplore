import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';
import '../controllers/profile_controller.dart';
import '../models/quiz_history_model.dart';

class ProfileQuizHistoryCard extends GetView<ProfileController> {
  const ProfileQuizHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = controller.quizHistories;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: AppColors.border, width: 2.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header: Evaluasi di kiri, Akurasi di kanan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Evaluasi',
                  style: AppTypography.heading2.copyWith(
                    color: AppColors.textDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  'Skor',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    color: AppColors.textHint,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Daftar Riwayat Kuis
            if (items.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'Belum ada riwayat kuis',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      color: AppColors.textHint,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            else
              ...List.generate(items.length, (index) {
                final history = items[index];
                return _buildHistoryItem(index, history);
              }),
          ],
        ),
      );
    });
  }

  Widget _buildHistoryItem(int index, QuizHistoryModel history) {
    // Kalo betul lebih banyak (>= 50%) maka hijau, selain itu merah
    final Color accuracyColor = history.isMajorityCorrect
        ? AppColors.green500
        : AppColors.errorRed;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.openQuizDiscussion(history),
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Nomor di kiri
                SizedBox(
                  width: 32,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textHint,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Judul Topik di tengah
                Expanded(
                  child: Text(
                    history.title,
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                      height: 1.35,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Akurasi di kanan
                Text(
                  history.accuracyText,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: accuracyColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
