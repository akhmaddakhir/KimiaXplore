import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class SpeechBubble extends StatelessWidget {
  const SpeechBubble({
    super.key,
    required this.text,
    this.backgroundColor = AppColors.blue50,
    this.borderColor = AppColors.blue500,
    this.borderWidth = 2.0,
    this.radius = 12.0,
    this.tailWidth = 18.0,
    this.tailHeight = 10.0,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  });

  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final double tailWidth;
  final double tailHeight;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SpeechBubblePainter(
        color: backgroundColor,
        borderColor: borderColor,
        borderWidth: borderWidth,
        radius: radius,
        tailWidth: tailWidth,
        tailHeight: tailHeight,
      ),
      child: Padding(
        padding: padding.add(EdgeInsets.only(bottom: tailHeight)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style:
              textStyle ??
              AppTypography.title.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class SpeechBubblePainter extends CustomPainter {
  const SpeechBubblePainter({
    required this.color,
    required this.borderColor,
    this.borderWidth = 2.0,
    this.radius = 16.0,
    this.tailWidth = 18.0,
    this.tailHeight = 10.0,
  });

  final Color color;
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final double tailWidth;
  final double tailHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final inset = borderWidth / 2;

    final left = inset;
    final top = inset;
    final right = size.width - inset;

    final bodyBottom = size.height - tailHeight - inset;
    final tailBottom = size.height - inset;

    final centerX = size.width / 2;
    final halfTail = tailWidth / 2;

    final path = Path()
      ..moveTo(left + radius, top)
      ..lineTo(right - radius, top)
      ..arcToPoint(Offset(right, top + radius), radius: Radius.circular(radius))
      ..lineTo(right, bodyBottom - radius)
      ..arcToPoint(
        Offset(right - radius, bodyBottom),
        radius: Radius.circular(radius),
      )
      ..lineTo(centerX + halfTail, bodyBottom)
      ..lineTo(centerX, tailBottom)
      ..lineTo(centerX - halfTail, bodyBottom)
      ..lineTo(left + radius, bodyBottom)
      ..arcToPoint(
        Offset(left, bodyBottom - radius),
        radius: Radius.circular(radius),
      )
      ..lineTo(left, top + radius)
      ..arcToPoint(Offset(left + radius, top), radius: Radius.circular(radius))
      ..close();

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant SpeechBubblePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.radius != radius ||
        oldDelegate.tailWidth != tailWidth ||
        oldDelegate.tailHeight != tailHeight;
  }
}
