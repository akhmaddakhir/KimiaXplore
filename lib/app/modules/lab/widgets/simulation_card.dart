import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';
import '../models/simulation_model.dart';

class SimulationCard extends StatefulWidget {
  final SimulationModel simulation;
  final VoidCallback? onTap;
  final double shadowDepth;
  final Color shadowColor;
  final Color borderColor;

  const SimulationCard({
    super.key,
    required this.simulation,
    this.onTap,
    this.shadowDepth = 6.0,
    this.shadowColor = AppColors.border,
    this.borderColor = AppColors.border,
  });

  @override
  State<SimulationCard> createState() => _SimulationCardState();
}

class _SimulationCardState extends State<SimulationCard> {
  bool _isPressed = false;
  DateTime? _pressStartTime;

  void _handleTapDown(TapDownDetails details) {
    _pressStartTime = DateTime.now();
    if (!_isPressed) {
      setState(() {
        _isPressed = true;
      });
    }
  }

  Future<void> _handleTapUp(TapUpDetails details) async {
    final startTime = _pressStartTime;
    if (startTime != null) {
      final elapsed = DateTime.now().difference(startTime).inMilliseconds;
      const minPressDuration = 160;
      if (elapsed < minPressDuration) {
        await Future.delayed(
          Duration(milliseconds: minPressDuration - elapsed),
        );
      }
    }
    if (mounted) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  void _handleTapCancel() {
    if (mounted && _isPressed) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  Future<void> _handleTap() async {
    if (!_isPressed) {
      setState(() {
        _isPressed = true;
      });
      await Future.delayed(const Duration(milliseconds: 160));
      if (mounted) {
        setState(() {
          _isPressed = false;
        });
      }
    }
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final pressedOffset = _isPressed ? widget.shadowDepth : 0.0;
    final shadowOffset = !_isPressed ? widget.shadowDepth : 0.0;

    return Padding(
      padding: EdgeInsets.only(bottom: widget.shadowDepth),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(0, pressedOffset, 0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: widget.borderColor, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: widget.shadowColor,
              offset: Offset(0, shadowOffset),
              blurRadius: 0,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            onTap: _handleTap,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            splashColor: widget.borderColor.withValues(alpha: 0.6),
            highlightColor: widget.borderColor.withValues(alpha: 0.3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      top: 20.0,
                      bottom: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.simulation.title,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E352F),
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.simulation.description,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF758A83),
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Padding(
                  padding: const EdgeInsets.only(right: 16.0, bottom: 6.0),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child:
                        (widget.simulation.imageAsset != null &&
                            widget.simulation.imageAsset!.isNotEmpty)
                        ? Image.asset(
                            widget.simulation.imageAsset!,
                            fit: BoxFit.contain,
                            alignment: Alignment.bottomCenter,
                          )
                        : const SizedBox.shrink(),
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
