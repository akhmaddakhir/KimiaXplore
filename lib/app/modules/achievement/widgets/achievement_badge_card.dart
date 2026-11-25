import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';
import '../models/achievement_model.dart';

/// Kartu badge Penghargaan untuk grid 3 kolom di halaman Achievement.
class AchievementBadgeCard extends StatefulWidget {
  final AchievementModel achievement;
  final VoidCallback? onTap;

  const AchievementBadgeCard({
    super.key,
    required this.achievement,
    this.onTap,
  });

  @override
  State<AchievementBadgeCard> createState() => _AchievementBadgeCardState();
}

class _AchievementBadgeCardState extends State<AchievementBadgeCard> {
  bool _pressed = false;
  Offset? _downPos;

  static const double _badgeSize = 84.0;
  static const double _depth = 4.0;

  Widget _buildImageContent() {
    final item = widget.achievement;
    final asset = item.imageAsset;

    if (asset != null && asset.isNotEmpty) {
      final image = asset.toLowerCase().endsWith('.svg')
          ? SvgPicture.asset(asset, width: 58, height: 58, fit: BoxFit.contain)
          : Image.asset(asset, width: 58, height: 58, fit: BoxFit.contain);

      return item.isUnlocked
          ? image
          : Opacity(opacity: 0.4, child: image);
    }

    return Icon(
      item.isUnlocked ? Icons.image_outlined : Icons.lock_outline_rounded,
      size: 30,
      color: item.isUnlocked
          ? item.accentColor.withValues(alpha: 0.8)
          : AppColors.textHint,
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.achievement;
    final unlocked = item.isUnlocked;
    final radius = BorderRadius.circular(22);

    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (e) {
        _downPos = e.position;
        setState(() => _pressed = true);
      },
      onPointerMove: (e) {
        if (_pressed && _downPos != null) {
          if ((e.position - _downPos!).distance > 10) {
            setState(() => _pressed = false);
          }
        }
      },
      onPointerUp: (_) {
        if (_pressed) setState(() => _pressed = false);
      },
      onPointerCancel: (_) {
        if (_pressed) setState(() => _pressed = false);
      },
      child: GestureDetector(
        onTapDown: (_) {
          if (!_pressed) setState(() => _pressed = true);
        },
        onTapUp: (_) {
          if (_pressed) setState(() => _pressed = false);
        },
        onTapCancel: () {
          if (_pressed) setState(() => _pressed = false);
        },
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Slot gambar badge 3D + pill angka + tag BARU
            SizedBox(
              width: _badgeSize,
              height: _badgeSize + _depth + 6,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  // Lapisan bawah 3D
                  Positioned(
                    top: _depth,
                    child: Container(
                      width: _badgeSize,
                      height: _badgeSize,
                      decoration: BoxDecoration(
                        color: unlocked
                            ? item.accentColor.withValues(alpha: 0.35)
                            : AppColors.border,
                        borderRadius: radius,
                      ),
                    ),
                  ),
                  // Permukaan atas slot gambar
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 60),
                    top: _pressed ? _depth : 0,
                    child: Container(
                      width: _badgeSize,
                      height: _badgeSize,
                      decoration: BoxDecoration(
                        color: unlocked ? item.softColor : AppColors.surface,
                        borderRadius: radius,
                        border: Border.all(
                          color: unlocked
                              ? item.accentColor.withValues(alpha: 0.45)
                              : AppColors.border,
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: _buildImageContent(),
                    ),
                  ),
                  // Angka target di bagian bawah badge
                  if (item.badgeNumber != null &&
                      item.badgeNumber!.isNotEmpty &&
                      unlocked)
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 60),
                      top: (_pressed ? _depth : 0) + _badgeSize - 13,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: item.accentColor,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          border: Border.all(
                            color: AppColors.surface,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          item.badgeNumber!,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.surface,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),
                  // Tag "BARU" di kanan atas
                  if (item.isNew)
                    Positioned(
                      top: -5,
                      right: -8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.red500,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          border: Border.all(
                            color: AppColors.surface,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          'BARU',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.surface,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            // Nama achievement
            Text(
              item.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodySmall.copyWith(
                color: unlocked ? AppColors.textDark : AppColors.textMedium,
                fontWeight: FontWeight.w800,
                fontSize: 13.5,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 3),
            // Total isi di achievement (misal: "4 dari 10")
            Text(
              item.progressText,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.caption.copyWith(
                color: AppColors.textMedium,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
