import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

enum PathNodeType { star, trophy, locked, special, jump }

class PathNodeData {
  final PathNodeType type;
  final bool done;
  final String title;
  final String description;

  const PathNodeData(
    this.type, {
    this.done = false,
    this.title = '',
    this.description = '',
  });
}

/// Satu kotak 3D perspektif di learning path (efek pedestal 3D + animasi tekan).
class PathNode extends StatefulWidget {
  final PathNodeType type;
  final bool done;
  final bool isSelected;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final double depth;
  final double borderRadius;

  const PathNode({
    super.key,
    required this.type,
    this.done = false,
    this.isSelected = false,
    this.onTap,
    this.width = 86,
    this.height = 70,
    this.depth = 8,
    this.borderRadius = 18,
  });

  @override
  State<PathNode> createState() => _PathNodeState();
}

class _PathNodeState extends State<PathNode> {
  bool _pressed = false;
  Offset? _downPos;

  Color get _top {
    switch (widget.type) {
      case PathNodeType.star:
      case PathNodeType.trophy:
        return AppColors.blue500;
      case PathNodeType.special:
        return AppColors.orange;
      case PathNodeType.jump:
        return AppColors.green500;
      case PathNodeType.locked:
        return AppColors.border;
    }
  }

  Color get _bottom {
    switch (widget.type) {
      case PathNodeType.star:
      case PathNodeType.trophy:
        return AppColors.blue700;
      case PathNodeType.special:
        return AppColors.darkOrange;
      case PathNodeType.jump:
        return AppColors.green700;
      case PathNodeType.locked:
        return AppColors.textHint;
    }
  }

  IconData get _icon {
    switch (widget.type) {
      case PathNodeType.star:
      case PathNodeType.trophy:
      case PathNodeType.special:
        return Icons.check_rounded;
      case PathNodeType.jump:
        return Icons.fast_forward_rounded;
      case PathNodeType.locked:
        return Icons.lock_rounded;
    }
  }

  Color get _iconColor =>
      widget.type == PathNodeType.locked ? AppColors.textMedium : AppColors.surface;

  Color get _highlight {
    switch (widget.type) {
      case PathNodeType.star:
      case PathNodeType.trophy:
        return AppColors.blue300;
      case PathNodeType.special:
        return AppColors.lightOrange;
      case PathNodeType.jump:
        return AppColors.green300;
      case PathNodeType.locked:
        return AppColors.surface;
    }
  }

  Widget _buildNodeContent(double w, double h) {
    if (widget.type == PathNodeType.special) {
      return Container(
        width: w * 0.62,
        height: h * 0.62,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.darkOrange.withValues(alpha: 0.45),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.yellow100.withValues(alpha: 0.95),
              blurRadius: 12,
              spreadRadius: 1.5,
            ),
            BoxShadow(
              color: AppColors.surface.withValues(alpha: 0.9),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
      );
    }

    // Lapisan plateau dalam agar terlihat seperti tombol/pedestal 3D bertingkat
    return Container(
      width: w * 0.72,
      height: h * 0.72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _highlight.withValues(alpha: widget.type == PathNodeType.locked ? 0.7 : 0.45),
            _top,
          ],
        ),
        border: Border.all(
          color: _highlight.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        _icon,
        size: widget.type == PathNodeType.locked ? 22 : 26,
        color: _iconColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.width, h = widget.height, d = widget.depth;
    final radius = BorderRadius.circular(widget.borderRadius);
    final locked = widget.type == PathNodeType.locked;
    final isSpecial = widget.type == PathNodeType.special;
    final isDown = _pressed || widget.isSelected;

    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: locked
          ? null
          : (e) {
              _downPos = e.position;
              setState(() => _pressed = true);
            },
      onPointerMove: locked
          ? null
          : (e) {
              if (_pressed && _downPos != null) {
                if ((e.position - _downPos!).distance > 10) {
                  setState(() => _pressed = false);
                }
              }
            },
      onPointerUp: locked
          ? null
          : (_) {
              if (_pressed) setState(() => _pressed = false);
            },
      onPointerCancel: locked
          ? null
          : (_) {
              if (_pressed) setState(() => _pressed = false);
            },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: locked
            ? null
            : (_) {
                if (!_pressed) setState(() => _pressed = true);
              },
        onTapUp: locked
            ? null
            : (_) {
                if (_pressed) setState(() => _pressed = false);
              },
        onTapCancel: () {
          if (_pressed) setState(() => _pressed = false);
        },
        onTap: locked ? null : widget.onTap,
        child: Padding(
          padding: EdgeInsets.only(top: isSpecial ? 38 : 0),
          child: SizedBox(
            width: w,
            height: h + d,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Ketebalan sisi 3D bawah (tanpa glow/drop shadow)
                Positioned(
                  top: d,
                  child: Container(
                    width: w,
                    height: h,
                    decoration: BoxDecoration(
                      color: _bottom,
                      borderRadius: radius,
                    ),
                  ),
                ),
                // Permukaan atas 3D (turun saat ditekan atau sedang terpilih)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 60),
                  top: isDown ? d : 0,
                  child: Container(
                    width: w,
                    height: h,
                    decoration: BoxDecoration(
                      borderRadius: radius,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.lerp(_top, _highlight, 0.25) ?? _top,
                          _top,
                        ],
                      ),
                      border: Border.all(
                        color: _highlight.withValues(alpha: 0.65),
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _buildNodeContent(w, h),
                  ),
                ),
                if (isSpecial) ...[
                  // Efek pancaran cahaya naik dari lubang kotak
                  Positioned(
                    top: -18,
                    left: (w - 40) / 2,
                    child: IgnorePointer(
                      child: Container(
                        width: 40,
                        height: 38,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                            bottom: Radius.circular(10),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColors.surface.withValues(alpha: 0.8),
                              AppColors.yellow100.withValues(alpha: 0.35),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Maskot KimiaXplore melayang di atas kotak 3D
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 60),
                    top: isDown ? -34 + d : -36,
                    left: (w - 44) / 2,
                    child: IgnorePointer(
                      child: SvgPicture.asset(
                        'assets/images/app_mascot.svg',
                        width: 44,
                        height: 44,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Bubble "LOMPAT KE SINI?" dengan panah kecil di bawah.
class JumpBubble extends StatelessWidget {
  final String text;
  const JumpBubble({super.key, this.text = 'LOMPAT KE SINI?'});

  static const _bg = AppColors.surface;
  static const _border = AppColors.border;
  static const _green = AppColors.green700;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _bg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _border, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: AppTypography.fontFamily,
              color: _green,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
        // Panah bubble (menimpa garis border bawah agar menyatu)
        Transform.translate(
          offset: const Offset(0, -2),
          child: CustomPaint(
            size: const Size(20, 10),
            painter: _BubbleTailPainter(fill: _bg, stroke: _border),
          ),
        ),
      ],
    );
  }
}

class _BubbleTailPainter extends CustomPainter {
  final Color fill;
  final Color stroke;
  _BubbleTailPainter({required this.fill, required this.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0);

    canvas.drawPath(Path.from(path)..close(), Paint()..color = fill);
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeJoin = StrokeJoin.round
        ..color = stroke,
    );
  }

  @override
  bool shouldRepaint(covariant _BubbleTailPainter old) =>
      old.fill != fill || old.stroke != stroke;
}

/// Tombol "Lompat ke sini" = bubble + node hijau.
class JumpNode extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onTap;
  const JumpNode({super.key, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const JumpBubble(),
        const SizedBox(height: 2),
        PathNode(
          type: PathNodeType.jump,
          isSelected: isSelected,
          onTap: onTap,
        ),
      ],
    );
  }
}

/// Kartu pop-up keterangan yang muncul tepat di bawah card yang diklik.
class NodeCalloutCard extends StatelessWidget {
  final PathNodeType type;
  final String title;
  final String description;
  final String buttonLabel;
  final double arrowOffsetX;
  final VoidCallback? onActionTap;

  const NodeCalloutCard({
    super.key,
    required this.type,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.arrowOffsetX,
    this.onActionTap,
  });

  Color get _bgColor {
    switch (type) {
      case PathNodeType.star:
      case PathNodeType.trophy:
        return AppColors.blue500;
      case PathNodeType.special:
        return AppColors.orange;
      case PathNodeType.jump:
        return AppColors.green500;
      case PathNodeType.locked:
        return AppColors.textMedium;
    }
  }

  Color get _bottomColor {
    switch (type) {
      case PathNodeType.star:
      case PathNodeType.trophy:
        return AppColors.blue700;
      case PathNodeType.special:
        return AppColors.darkOrange;
      case PathNodeType.jump:
        return AppColors.green700;
      case PathNodeType.locked:
        return AppColors.textDark;
    }
  }

  Color get _subtitleColor {
    switch (type) {
      case PathNodeType.star:
      case PathNodeType.trophy:
        return AppColors.blue50;
      case PathNodeType.special:
        return AppColors.yellow50;
      case PathNodeType.jump:
        return AppColors.green50;
      case PathNodeType.locked:
        return AppColors.background;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Panah segitiga menghadap ke atas, tepat menunjuk ke tengah node
        SizedBox(
          height: 10,
          child: CustomPaint(
            painter: _CalloutArrowPainter(
              color: _bgColor,
              centerX: arrowOffsetX,
            ),
          ),
        ),
        // Body card 3D
        Container(
          decoration: BoxDecoration(
            color: _bottomColor,
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.only(bottom: 5),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _bgColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    color: AppColors.surface,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      color: _subtitleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                _CalloutActionButton(
                  label: buttonLabel,
                  textColor: _bottomColor,
                  onTap: onActionTap,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CalloutArrowPainter extends CustomPainter {
  final Color color;
  final double centerX;

  _CalloutArrowPainter({required this.color, required this.centerX});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = centerX.clamp(24.0, size.width - 24.0);
    final path = Path()
      ..moveTo(cx - 11, size.height)
      ..lineTo(cx, 0)
      ..lineTo(cx + 11, size.height)
      ..close();

    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _CalloutArrowPainter old) =>
      old.color != color || old.centerX != centerX;
}

class _CalloutActionButton extends StatefulWidget {
  final String label;
  final Color textColor;
  final VoidCallback? onTap;

  const _CalloutActionButton({
    required this.label,
    required this.textColor,
    this.onTap,
  });

  @override
  State<_CalloutActionButton> createState() => _CalloutActionButtonState();
}

class _CalloutActionButtonState extends State<_CalloutActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    const double depth = 4.0;
    const double height = 46.0;
    final radius = BorderRadius.circular(14);

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: height + depth,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: depth,
              left: 0,
              right: 0,
              height: height,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: radius,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 60),
              top: _pressed ? depth : 0,
              left: 0,
              right: 0,
              height: height,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: radius,
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    color: widget.textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
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

/// Node dengan cincin progres (untuk node yang sedang aktif).
class ActiveRing extends StatelessWidget {
  final Widget child;
  final double progress; // 0..1
  const ActiveRing({super.key, required this.child, this.progress = 0.35});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 102,
          height: 94,
          child: CustomPaint(painter: _RingPainter(progress)),
        ),
        child,
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  static const int _dashCount = 8;

  _RingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(4);
    final step = (2 * math.pi) / _dashCount;
    const sweepAngle = 0.50;

    final bg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round
      ..color = AppColors.border;

    final fg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round
      ..color = AppColors.orange;

    final filledCount = progress <= 0
        ? 0
        : (progress * _dashCount).round().clamp(0, _dashCount);

    for (int i = 0; i < _dashCount; i++) {
      final startAngle = -math.pi / 2 + (i * step) + (step - sweepAngle) / 2;
      final isFilled = i < filledCount;
      canvas.drawArc(rect, startAngle, sweepAngle, false, isFilled ? fg : bg);
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) => old.progress != progress;
}
