import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_typography.dart';

class AppStatChip extends StatelessWidget {
  const AppStatChip({
    super.key,
    required this.icon,
    required this.value,
    this.onTap,
    this.tooltip,
    this.backgroundColor = AppColors.surface,
    this.borderColor = AppColors.border,
    this.textColor = AppColors.textDark,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  });

  final Widget icon;
  final String value;
  final VoidCallback? onTap;
  final String? tooltip;

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppRadius.pill);

    final content = Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 6),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w800,
              color: textColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );

    Widget chip = Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: onTap == null
            ? content
            : InkWell(onTap: onTap, borderRadius: borderRadius, child: content),
      ),
    );

    if (tooltip != null && tooltip!.isNotEmpty) {
      chip = Tooltip(message: tooltip!, child: chip);
    }

    return chip;
  }
}
