import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_typography.dart';

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 52,
    this.borderRadius = AppRadius.xl,
    required this.gradientColors,
    required this.shadowColor,
    this.textColor = AppColors.surface,
  });

  const AppButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 52,
    this.borderRadius = AppRadius.button,
    this.textColor = AppColors.surface,
  }) : gradientColors = const [AppColors.lightBlue, AppColors.blue500],
       shadowColor = AppColors.blue700;

  final String label;
  final VoidCallback? onPressed;

  final double height;
  final double borderRadius;

  final List<Color> gradientColors;
  final Color shadowColor;
  final Color textColor;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  static const double _shadowDepth = 6;

  bool _isPressed = false;

  bool get _isEnabled => widget.onPressed != null;

  void _handleHighlightChanged(bool isHighlighted) {
    if (!_isEnabled || _isPressed == isHighlighted) return;

    setState(() {
      _isPressed = isHighlighted;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pressedOffset = (_isEnabled && _isPressed) ? _shadowDepth : 0.0;
    final shadowOffset = (_isEnabled && !_isPressed) ? _shadowDepth : 0.0;

    final currentGradient = _isEnabled
        ? widget.gradientColors
        : const [AppColors.border, AppColors.border];

    final currentShadowColor = _isEnabled
        ? widget.shadowColor
        : Colors.transparent;

    final currentTextColor = _isEnabled ? widget.textColor : AppColors.textHint;

    return SizedBox(
      width: double.infinity,
      height: widget.height + _shadowDepth,
      child: Align(
        alignment: Alignment.topCenter,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeInOut,
          width: double.infinity,
          height: widget.height,
          transform: Matrix4.translationValues(0, pressedOffset, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: currentGradient,
            ),
            boxShadow: [
              BoxShadow(
                color: currentShadowColor,
                offset: Offset(0, shadowOffset),
                blurRadius: 0,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: widget.onPressed,
              onHighlightChanged: _handleHighlightChanged,
              splashFactory: NoSplash.splashFactory,
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              child: Center(
                child: Text(
                  widget.label,
                  style: AppTypography.button.copyWith(color: currentTextColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
