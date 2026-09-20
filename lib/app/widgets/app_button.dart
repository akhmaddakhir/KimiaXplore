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
    this.width,
    this.borderRadius = AppRadius.button,
    required this.gradientColors,
    required this.shadowColor,
    this.textColor = AppColors.surface,
    this.border,
    this.icon,
  });

  const AppButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 52,
    this.width,
    this.borderRadius = AppRadius.button,
    this.textColor = AppColors.surface,
    this.border,
    this.icon,
  }) : gradientColors = const [AppColors.lightBlue, AppColors.blue500],
       shadowColor = AppColors.blue700;

  const AppButton.icon({
    super.key,
    required this.icon,
    required this.onPressed,
    this.height = 52,
    this.width,
    this.borderRadius = AppRadius.button,
    this.textColor = AppColors.textDark,
    this.border = const Border.fromBorderSide(
      BorderSide(color: AppColors.border, width: 2.0),
    ),
  }) : label = '',
       gradientColors = const [AppColors.surface, AppColors.surface],
       shadowColor = AppColors.border;

  final String label;
  final VoidCallback? onPressed;

  final double height;
  final double? width;
  final double borderRadius;

  final List<Color> gradientColors;
  final Color shadowColor;
  final Color textColor;
  final BoxBorder? border;

  final Widget? icon;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  static const double _shadowDepth = 6;

  bool _isPressed = false;

  bool get _isEnabled => widget.onPressed != null;

  bool get _isIconOnly => widget.label.isEmpty;

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

    final buttonWidth =
        widget.width ?? (_isIconOnly ? widget.height : double.infinity);

    return SizedBox(
      width: buttonWidth,
      height: widget.height + _shadowDepth,
      child: Align(
        alignment: Alignment.topCenter,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeInOut,
          width: buttonWidth,
          height: widget.height,
          transform: Matrix4.translationValues(0, pressedOffset, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: widget.border,
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      widget.icon!,
                      if (!_isIconOnly) const SizedBox(width: 12),
                    ],

                    if (!_isIconOnly)
                      Text(
                        widget.label,
                        style: AppTypography.button.copyWith(
                          color: currentTextColor,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
