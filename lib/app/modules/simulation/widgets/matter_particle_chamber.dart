import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../models/matter_state.dart';

class MatterParticleChamber extends StatefulWidget {
  const MatterParticleChamber({
    super.key,
    required this.state,
    required this.temperature,
  });

  final MatterState state;
  final double temperature;

  @override
  State<MatterParticleChamber> createState() => _MatterParticleChamberState();
}

class _MatterParticleChamberState extends State<MatterParticleChamber>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color get _stateColor {
    switch (widget.state) {
      case MatterState.solid:
        return AppColors.green500;
      case MatterState.liquid:
        return AppColors.blue500;
      case MatterState.gas:
        return AppColors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.disableAnimationsOf(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(color: AppColors.border, width: 2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Pergerakan Partikel',
                  style: AppTypography.title.copyWith(
                    color: AppColors.textDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: _stateColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  widget.state.label,
                  style: AppTypography.caption.copyWith(
                    color: _stateColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AspectRatio(
            aspectRatio: 1.35,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.xl),
                border: Border.all(color: AppColors.border, width: 1.5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.xl),
                child: disableAnimations
                    ? CustomPaint(
                        painter: _MatterParticlePainter(
                          state: widget.state,
                          temperature: widget.temperature,
                          progress: 0,
                        ),
                      )
                    : AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: _MatterParticlePainter(
                              state: widget.state,
                              temperature: widget.temperature,
                              progress: _animationController.value,
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatterParticlePainter extends CustomPainter {
  const _MatterParticlePainter({
    required this.state,
    required this.temperature,
    required this.progress,
  });

  final MatterState state;
  final double temperature;
  final double progress;

  Color get particleColor {
    switch (state) {
      case MatterState.solid:
        return AppColors.green500;
      case MatterState.liquid:
        return AppColors.blue500;
      case MatterState.gas:
        return AppColors.orange;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    switch (state) {
      case MatterState.solid:
        _drawSolid(canvas, size);
        break;
      case MatterState.liquid:
        _drawLiquid(canvas, size);
        break;
      case MatterState.gas:
        _drawGas(canvas, size);
        break;
    }
  }

  void _drawParticle(Canvas canvas, Offset position, double radius) {
    final outerPaint = Paint()..color = particleColor.withValues(alpha: 0.18);

    final innerPaint = Paint()..color = particleColor;

    canvas.drawCircle(position, radius + 3, outerPaint);

    canvas.drawCircle(position, radius, innerPaint);
  }

  void _drawSolid(Canvas canvas, Size size) {
    const columns = 6;
    const rows = 4;

    final radius = math.min(size.width * 0.026, 9.0);
    final horizontalGap = size.width * 0.115;
    final verticalGap = size.height * 0.115;

    final totalWidth = horizontalGap * (columns - 1);
    final totalHeight = verticalGap * (rows - 1);

    final startX = (size.width - totalWidth) / 2;
    final startY = size.height * 0.54 - totalHeight / 2;

    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        final index = row * columns + column;

        final vibrationX = math.sin((progress * math.pi * 2) + index) * 1.8;

        final vibrationY = math.cos((progress * math.pi * 2) + index) * 1.8;

        _drawParticle(
          canvas,
          Offset(
            startX + column * horizontalGap + vibrationX,
            startY + row * verticalGap + vibrationY,
          ),
          radius,
        );
      }
    }
  }

  void _drawLiquid(Canvas canvas, Size size) {
    const columns = 6;
    const rows = 4;

    final radius = math.min(size.width * 0.025, 8.5);
    final horizontalGap = size.width * 0.125;
    final verticalGap = size.height * 0.13;

    final totalWidth = horizontalGap * (columns - 1);
    final startX = (size.width - totalWidth) / 2;
    final startY = size.height * 0.46;

    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        final index = row * columns + column;

        final movementX = math.sin(progress * math.pi * 2 + index * 0.8) * 7;

        final movementY = math.cos(progress * math.pi * 2 + index * 0.55) * 4;

        final rowOffset = row.isOdd ? horizontalGap * 0.25 : 0.0;

        _drawParticle(
          canvas,
          Offset(
            startX + column * horizontalGap + rowOffset + movementX,
            startY + row * verticalGap + movementY,
          ),
          radius,
        );
      }
    }
  }

  void _drawGas(Canvas canvas, Size size) {
    const columns = 6;
    const rows = 4;

    final radius = math.min(size.width * 0.023, 8.0);
    final horizontalGap = size.width / (columns + 1);
    final verticalGap = size.height / (rows + 1);

    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        final index = row * columns + column;

        final movementX =
            math.sin(progress * math.pi * 2 + index * 1.17) *
            horizontalGap *
            0.22;

        final movementY =
            math.cos(progress * math.pi * 2 + index * 0.91) *
            verticalGap *
            0.25;

        _drawParticle(
          canvas,
          Offset(
            horizontalGap * (column + 1) + movementX,
            verticalGap * (row + 1) + movementY,
          ),
          radius,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _MatterParticlePainter oldDelegate) {
    return oldDelegate.state != state ||
        oldDelegate.temperature != temperature ||
        oldDelegate.progress != progress;
  }
}
