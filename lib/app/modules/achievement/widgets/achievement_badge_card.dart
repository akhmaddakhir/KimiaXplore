import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../models/achievement_model.dart';
import 'locked_badge_silhouette.dart';

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

  static const double _badgeWidth = 108.0;
  static const double _badgeHeight = 126.0;

  Widget _buildImageContent() {
    final item = widget.achievement;
    final asset = item.imageAsset;

    if (asset == null || asset.isEmpty) {
      return const SizedBox.shrink();
    }

    final isSvg = asset.toLowerCase().endsWith('.svg');

    if (!item.isUnlocked && isSvg) {
      return LockedBadgeSilhouette(
        assetPath: asset,
        width: _badgeWidth,
        height: _badgeHeight,
      );
    }

    final image = isSvg
        ? SvgPicture.asset(
            asset,
            width: _badgeWidth,
            height: _badgeHeight,
            fit: BoxFit.contain,
          )
        : Image.asset(
            asset,
            width: _badgeWidth,
            height: _badgeHeight,
            fit: BoxFit.contain,
          );

    return item.isUnlocked
        ? image
        : ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Color(0xFFD0DBE6),
              BlendMode.srcIn,
            ),
            child: image,
          );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.achievement;
    final unlocked = item.isUnlocked;

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
            SizedBox(
              width: _badgeWidth,
              height: _badgeHeight,
              child: AnimatedScale(
                scale: _pressed ? 0.94 : 1.0,
                duration: const Duration(milliseconds: 80),
                child: _buildImageContent(),
              ),
            ),
            const SizedBox(height: 2),
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
