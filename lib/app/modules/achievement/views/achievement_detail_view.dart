import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_stat_chip.dart';
import '../models/achievement_model.dart';
import '../widgets/locked_badge_silhouette.dart';

class AchievementDetailView extends StatelessWidget {
  final AchievementModel achievement;

  const AchievementDetailView({
    super.key,
    required this.achievement,
  });

  Widget _buildBadgeImage() {
    final asset = achievement.imageAsset;
    if (asset == null || asset.isEmpty) {
      return const SizedBox(width: 190, height: 224);
    }

    final isSvg = asset.toLowerCase().endsWith('.svg');

    if (!achievement.isUnlocked && isSvg) {
      return LockedBadgeSilhouette(
        assetPath: asset,
        width: 190,
        height: 224,
      );
    }

    final image = isSvg
        ? SvgPicture.asset(
            asset,
            width: 190,
            height: 224,
            fit: BoxFit.contain,
          )
        : Image.asset(
            asset,
            width: 190,
            height: 224,
            fit: BoxFit.contain,
          );

    return achievement.isUnlocked
        ? image
        : ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Color(0xFFD0DBE6),
              BlendMode.srcIn,
            ),
            child: image,
          );
  }

  void _handleShare(String descriptionText) {
    Clipboard.setData(
      ClipboardData(text: '${achievement.title} — $descriptionText'),
    );
    Get.snackbar(
      'Disalin',
      'Info pencapaian "${achievement.title}" disalin ke clipboard.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unlocked = achievement.isUnlocked;
    final badgeLabel = unlocked
        ? (achievement.unlockedDate ?? achievement.progressText.toUpperCase())
        : 'BELUM TERBUKA';

    final descriptionText = achievement.description.isNotEmpty
        ? achievement.description
        : unlocked
            ? 'Kamu meraih pencapaian ${achievement.title} (${achievement.progressText})!'
            : 'Terus belajar untuk membuka pencapaian ${achievement.title}!';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header ala AppDetailHeader: tombol back di kiri, tombol share di kanan
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      } else {
                        Get.back();
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
                  Material(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () => _handleShare(descriptionText),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.border,
                            width: 1.5,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.share_rounded,
                          color: AppColors.textDark,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Konten utama di tengah layar
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxl,
                    vertical: AppSpacing.xl,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildBadgeImage(),
                      const SizedBox(height: AppSpacing.xl),
                      // Chip tanggal / status ala AppStatChip
                      AppStatChip(
                        icon: Icon(
                          unlocked
                              ? Icons.calendar_today_rounded
                              : Icons.lock_outline_rounded,
                          size: 15,
                          color: unlocked
                              ? AppColors.blue500
                              : AppColors.textMedium,
                        ),
                        value: badgeLabel,
                        backgroundColor: unlocked
                            ? AppColors.blue50
                            : AppColors.surface,
                        borderColor: unlocked
                            ? AppColors.blue100
                            : AppColors.border,
                        textColor: unlocked
                            ? AppColors.blue700
                            : AppColors.textMedium,
                        fontSize: 13,
                        iconSpacing: 8,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      // Teks pencapaian besar di tengah
                      Text(
                        descriptionText,
                        textAlign: TextAlign.center,
                        style: AppTypography.heading2.copyWith(
                          color: AppColors.textDark,
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          height: 1.38,
                        ),
                      ),
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
