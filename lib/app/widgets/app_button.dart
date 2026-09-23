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
    this.textStyle,
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
    this.textStyle,
  }) : gradientColors = const [AppColors.lightBlue, AppColors.blue500],
       shadowColor = AppColors.blue700;

  const AppButton.outline({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 52,
    this.width,
    this.borderRadius = AppRadius.button,
    this.textColor = AppColors.blue500,
    this.icon,
    this.textStyle,
  }) : gradientColors = const [AppColors.surface, AppColors.surface],
       shadowColor = AppColors.blue100,
       border = const Border.fromBorderSide(
         BorderSide(color: AppColors.blue100, width: 2.0),
       );

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
       textStyle = null,
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
  final TextStyle? textStyle;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  static const double _shadowDepth = 4;
  static const int _minPressDuration = 160;

  bool _isPressed = false;
  DateTime? _pressStartTime;

  bool get _isEnabled => widget.onPressed != null;

  bool get _isIconOnly => widget.label.isEmpty;

  void _handleTapDown(TapDownDetails details) {
    if (!_isEnabled) return;
    _pressStartTime = DateTime.now();
    if (!_isPressed) {
      setState(() {
        _isPressed = true;
      });
    }
  }

  Future<void> _handleTapUp(TapUpDetails details) async {
    if (!_isEnabled) return;
    final startTime = _pressStartTime;
    if (startTime != null) {
      final elapsed = DateTime.now().difference(startTime).inMilliseconds;
      if (elapsed < _minPressDuration) {
        await Future.delayed(
          Duration(milliseconds: _minPressDuration - elapsed),
        );
      }
    }
    if (mounted && _isPressed) {
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
    if (!_isEnabled) return;
    if (!_isPressed) {
      setState(() {
        _isPressed = true;
      });
      await Future.delayed(const Duration(milliseconds: _minPressDuration));
      if (mounted) {
        setState(() {
          _isPressed = false;
        });
      }
    }
    widget.onPressed?.call();
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

    final currentBorder = _isEnabled
        ? widget.border
        : (widget.border != null
              ? const Border.fromBorderSide(
                  BorderSide(color: AppColors.border, width: 2.0),
                )
              : null);

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
            border: currentBorder,
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
              onTapDown: _isEnabled ? _handleTapDown : null,
              onTapUp: _isEnabled ? _handleTapUp : null,
              onTapCancel: _isEnabled ? _handleTapCancel : null,
              onTap: _isEnabled ? _handleTap : null,
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
                        style: (widget.textStyle ?? AppTypography.button)
                            .copyWith(color: currentTextColor),
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
