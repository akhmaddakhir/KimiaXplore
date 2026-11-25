import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

/// Kartu keterangan Bab 3D (berisi nama kategori, judul bab, dan progress bar).
class UnitBanner extends StatefulWidget {
  final String unitText;
  final String titleText;
  final double progress;
  final Color topColor;
  final Color bottomColor;
  final Color borderHighlightColor;
  final VoidCallback? onTapUnit;
  final VoidCallback? onTapGuidebook;

  const UnitBanner({
    super.key,
    this.unitText = 'BAB 1',
    this.titleText = '1. Pengenalan Kimia',
    this.progress = 0.0,
    this.topColor = AppColors.blue500,
    this.bottomColor = AppColors.blue700,
    this.borderHighlightColor = AppColors.blue300,
    this.onTapUnit,
    this.onTapGuidebook,
  });

  @override
  State<UnitBanner> createState() => _UnitBannerState();
}

class _UnitBannerState extends State<UnitBanner> {
  bool _pressed = false;
  Offset? _downPos;

  static const double _height = 110.0;
  static const double _depth = 6.0;
  static const double _radius = 20.0;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(_radius);
    final clampedProgress = widget.progress.clamp(0.0, 1.0);

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
        onTap: widget.onTapUnit,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: _height + _depth,
          child: Stack(
            children: [
              // Lapisan bawah (ketebalan 3D tanpa glow/drop shadow)
              Positioned(
                top: _depth,
                left: 0,
                right: 0,
                height: _height,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.bottomColor,
                    borderRadius: radius,
                  ),
                ),
              ),
              // Permukaan atas kartu bab
              AnimatedPositioned(
                duration: const Duration(milliseconds: 60),
                top: _pressed ? _depth : 0,
                left: 0,
                right: 0,
                height: _height,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.lerp(
                              widget.topColor,
                              widget.borderHighlightColor,
                              0.18,
                            ) ??
                            widget.topColor,
                        widget.topColor,
                      ],
                    ),
                    border: Border.all(
                      color: widget.borderHighlightColor.withValues(alpha: 0.45),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.unitText,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          color: AppColors.blue50,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.titleText,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          color: AppColors.surface,
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      // Progress bar di dalam kartu bab
                      Container(
                        height: 8,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: widget.bottomColor.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: clampedProgress,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
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
