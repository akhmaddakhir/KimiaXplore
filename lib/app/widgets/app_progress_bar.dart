import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    super.key,
    required this.value,
    this.height = 14.0,
    this.progressColor = AppColors.green500,
    this.trackColor = AppColors.textHint,
  });

  final double value;
  final double height;
  final Color progressColor;
  final Color trackColor;

  @override
  Widget build(BuildContext context) {
    final clampedValue = value.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: trackColor,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: constraints.maxWidth * clampedValue,
                height: height,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
