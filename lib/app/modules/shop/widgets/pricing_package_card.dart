import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../models/pricing_package_model.dart';

class PricingPackageCard extends StatelessWidget {
  final PricingPackageModel package;
  final bool isSelected;
  final VoidCallback? onTap;

  const PricingPackageCard({
    super.key,
    required this.package,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasBadge = package.localizedBadge != null;

    return Padding(
      padding: EdgeInsets.only(top: hasBadge ? AppSpacing.md : 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.blue50 : AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: isSelected ? AppColors.blue700 : AppColors.border,
                width: 2,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.lg,
                  ),
                  child: _buildContent(),
                ),
              ),
            ),
          ),

          if (hasBadge) _buildBadge(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                package.title,
                style: AppTypography.title.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            _buildPrice(),
          ],
        ),

        const SizedBox(height: AppSpacing.sm),

        Text(
          'shop_access_duration'.trParams({
            'duration': package.localizedDuration,
          }),
          style: AppTypography.bodySmall.copyWith(color: AppColors.textMedium),
        ),
      ],
    );
  }

  Widget _buildPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (package.originalPrice != null) ...[
          Text(
            package.originalPrice!,
            style: AppTypography.caption.copyWith(
              color: AppColors.textMedium,
              decoration: TextDecoration.lineThrough,
              decorationColor: AppColors.textMedium,
              decorationThickness: 1.5,
            ),
          ),

          const SizedBox(height: 2),
        ],

        Text(
          package.price,
          style: AppTypography.title.copyWith(
            color: AppColors.textDark,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildBadge() {
    return Positioned(
      top: -11,
      left: AppSpacing.lg,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.yellow100,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Text(
          package.localizedBadge!,
          style: AppTypography.caption.copyWith(
            color: AppColors.textDark,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
