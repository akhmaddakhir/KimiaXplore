import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({
    super.key,
    this.text = 'Atau',
    this.lineColor = AppColors.border,
    this.thickness = 1.5,
    this.textStyle,
    this.textPadding = const EdgeInsets.symmetric(horizontal: 16),
  });

  final String? text;
  final Color lineColor;
  final double thickness;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry textPadding;

  @override
  Widget build(BuildContext context) {
    if (text == null || text!.isEmpty) {
      return Divider(
        color: lineColor,
        thickness: thickness,
      );
    }

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: lineColor,
            thickness: thickness,
          ),
        ),
        Padding(
          padding: textPadding,
          child: Text(
            text!,
            style: textStyle ??
                AppTypography.bodySmall.copyWith(
                  color: AppColors.textHint,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Expanded(
          child: Divider(
            color: lineColor,
            thickness: thickness,
          ),
        ),
      ],
    );
  }
}
