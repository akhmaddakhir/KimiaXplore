import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../models/matter_state.dart';

class MatterStateCard extends StatelessWidget {
  const MatterStateCard({super.key, required this.state});

  final MatterState state;

  Color get _color {
    switch (state) {
      case MatterState.solid:
        return AppColors.green500;
      case MatterState.liquid:
        return AppColors.blue500;
      case MatterState.gas:
        return AppColors.orange;
    }
  }

  Color get _backgroundColor {
    switch (state) {
      case MatterState.solid:
        return AppColors.green50;
      case MatterState.liquid:
        return AppColors.blue50;
      case MatterState.gas:
        return AppColors.yellow50;
    }
  }

  IconData get _icon {
    switch (state) {
      case MatterState.solid:
        return Icons.ac_unit_rounded;
      case MatterState.liquid:
        return Icons.water_drop_rounded;
      case MatterState.gas:
        return Icons.air_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(color: _color.withValues(alpha: 0.25), width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Icon(_icon, color: _color, size: 26),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.label,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  state.particleBehavior,
                  style: AppTypography.caption.copyWith(
                    color: _color,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  state.description,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textMedium,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
