import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../models/matter_state.dart';

class TemperatureControl extends StatelessWidget {
  const TemperatureControl({
    super.key,
    required this.temperature,
    required this.state,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final double temperature;
  final MatterState state;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  Color get _stateColor {
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
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(color: AppColors.border, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Suhu',
                  style: AppTypography.title.copyWith(
                    color: AppColors.textDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: _stateColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  '${temperature.round()}°C',
                  style: AppTypography.title.copyWith(
                    color: _stateColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: _stateColor,
              inactiveTrackColor: AppColors.border,
              thumbColor: _stateColor,
              overlayColor: _stateColor.withValues(alpha: 0.12),
              trackHeight: 8,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 11),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            ),
            child: Slider(
              value: temperature,
              min: min,
              max: max,
              divisions: (max - min).round(),
              onChanged: onChanged,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Row(
              children: [
                Text(
                  '-20°C',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMedium,
                  ),
                ),
                Spacer(),
                Text(
                  '0°C',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMedium,
                  ),
                ),
                Spacer(),
                Text(
                  '100°C',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMedium,
                  ),
                ),
                Spacer(),
                Text(
                  '120°C',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Simulasi menggunakan air sebagai contoh pada kondisi normal.',
            style: AppTypography.caption.copyWith(color: AppColors.textMedium),
          ),
        ],
      ),
    );
  }
}
