import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../models/achievement_model.dart';

/// Kartu Rekor Personal bergaya 3D segar seperti Home.
class PersonalRecordCard extends StatefulWidget {
  final PersonalRecordModel record;
  final VoidCallback? onTap;

  const PersonalRecordCard({
    super.key,
    required this.record,
    this.onTap,
  });

  @override
  State<PersonalRecordCard> createState() => _PersonalRecordCardState();
}

class _PersonalRecordCardState extends State<PersonalRecordCard> {
  bool _pressed = false;
  Offset? _downPos;

  static const double _width = 160.0;
  static const double _height = 204.0;
  static const double _depth = 5.0;

  Widget _buildImageSlot() {
    final asset = widget.record.imageAsset;
    Widget inner;

    if (asset != null && asset.isNotEmpty) {
      inner = asset.toLowerCase().endsWith('.svg')
          ? SvgPicture.asset(asset, width: 64, height: 64, fit: BoxFit.contain)
          : Image.asset(asset, width: 64, height: 64, fit: BoxFit.contain);
    } else {
      inner = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 32,
            color: widget.record.accentColor.withValues(alpha: 0.75),
          ),
          const SizedBox(height: 4),
          Text(
            'Gambar',
            style: AppTypography.caption.copyWith(
              color: widget.record.accentColor,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            color: widget.record.softColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.record.accentColor.withValues(alpha: 0.25),
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: inner,
        ),
        if (widget.record.valueLabel != null &&
            widget.record.valueLabel!.isNotEmpty)
          Positioned(
            bottom: -10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: widget.record.accentColor,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(color: AppColors.surface, width: 2),
              ),
              child: Text(
                widget.record.valueLabel!,
                style: AppTypography.caption.copyWith(
                  color: AppColors.surface,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.xl);

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
        child: SizedBox(
          width: _width,
          height: _height + _depth,
          child: Stack(
            children: [
              // Lapisan bawah 3D
              Positioned(
                top: _depth,
                left: 0,
                right: 0,
                height: _height,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: radius,
                  ),
                ),
              ),
              // Permukaan kartu atas
              AnimatedPositioned(
                duration: const Duration(milliseconds: 60),
                top: _pressed ? _depth : 0,
                left: 0,
                right: 0,
                height: _height,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: radius,
                    border: Border.all(color: AppColors.border, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildImageSlot(),
                      const SizedBox(height: AppSpacing.sm),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.record.title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.record.date,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textMedium,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
