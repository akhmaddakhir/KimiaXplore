import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';
import '../models/topic_activity_type.dart';

class TopicActivityCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final double shadowDepth;
  final Color shadowColor;
  final Color borderColor;

  const TopicActivityCard({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.shadowDepth = 4.0,
    this.shadowColor = AppColors.border,
    this.borderColor = AppColors.border,
  });

  factory TopicActivityCard.fromType({
    Key? key,
    required TopicActivityType type,
    VoidCallback? onTap,
    String? customSubtitle,
    Widget? trailing,
    double shadowDepth = 4.0,
  }) {
    return TopicActivityCard(
      key: key,
      title: type.title,
      subtitle: customSubtitle ?? type.subtitle,
      trailing: trailing,
      onTap: onTap,
      shadowDepth: shadowDepth,
    );
  }

  @override
  State<TopicActivityCard> createState() => _TopicActivityCardState();
}

class _TopicActivityCardState extends State<TopicActivityCard> {
  bool _isPressed = false;
  DateTime? _pressStartTime;

  static const int _minPressDuration = 160;

  void _handleTapDown(TapDownDetails details) {
    _pressStartTime = DateTime.now();

    if (_isPressed) return;

    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapCancel() {
    _pressStartTime = null;

    if (!_isPressed) return;

    setState(() {
      _isPressed = false;
    });
  }

  Future<void> _handleTap() async {
    final startTime = _pressStartTime;

    if (startTime != null) {
      final elapsed = DateTime.now().difference(startTime).inMilliseconds;

      if (elapsed < _minPressDuration) {
        await Future.delayed(
          Duration(milliseconds: _minPressDuration - elapsed),
        );
      }
    }

    if (!mounted) return;

    setState(() {
      _isPressed = false;
    });

    _pressStartTime = null;

    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final pressedOffset = _isPressed ? widget.shadowDepth : 0.0;
    final shadowOffset = _isPressed ? 0.0 : widget.shadowDepth;

    return Padding(
      padding: EdgeInsets.only(bottom: widget.shadowDepth),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(0, pressedOffset, 0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: widget.borderColor, width: 2),
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
            onTapCancel: _handleTapCancel,
            onTap: _handleTap,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            splashColor: widget.borderColor.withValues(alpha: 0.6),
            highlightColor: widget.borderColor.withValues(alpha: 0.3),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: AppTypography.title.copyWith(
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        if (widget.subtitle != null &&
                            widget.subtitle!.isNotEmpty) ...[
                          const SizedBox(height: 6),

                          Text(
                            widget.subtitle!,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textMedium,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  widget.trailing ??
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.textMedium,
                        size: 20,
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
