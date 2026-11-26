import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../models/pricing_package_model.dart';

class PricingPackageCard extends StatelessWidget {
  final PricingPackageModel package;
  final bool isSelected;
  final bool showPopularTag;
  final VoidCallback? onTap;

  const PricingPackageCard({
    super.key,
    required this.package,
    this.isSelected = false,
    this.showPopularTag = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasOriginalPrice =
        package.originalPrice != null &&
        package.originalPrice!.trim().isNotEmpty;
    final subtitleText =
        (package.description != null && package.description!.trim().isNotEmpty)
        ? package.description!
        : 'Akses premium ${package.localizedDuration}';

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              showPopularTag ? 22 : AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.blue50 : AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isSelected ? AppColors.blue500 : AppColors.border,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        package.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.heading2.copyWith(
                          color: AppColors.textDark,
                          fontSize: 18.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (hasOriginalPrice)
                          Text(
                            package.originalPrice!,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textHint,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppColors.textHint,
                            ),
                          ),
                        Text(
                          package.price,
                          style: AppTypography.heading2.copyWith(
                            color: isSelected
                                ? AppColors.blue500
                                : AppColors.textDark,
                            fontSize: 18.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  subtitleText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textMedium,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (showPopularTag)
            Positioned(
              top: -12,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.yellow100,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  border: Border.all(
                    color: AppColors.lightOrange,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  'Paling Populer',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.darkOrange,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
