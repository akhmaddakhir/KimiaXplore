import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../models/premium_benefit_model.dart';

class ShopComparisonTable extends StatelessWidget {
  final List<PremiumBenefitModel> benefits;

  const ShopComparisonTable({super.key, required this.benefits});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(color: AppColors.blue100, width: 2),
        boxShadow: const [
          BoxShadow(
            color: AppColors.blue100,
            offset: Offset(0, 5),
            blurRadius: 0,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildHeader(),

          for (int i = 0; i < benefits.length; i++)
            _buildRow(benefits[i], isLast: i == benefits.length - 1),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: 18,
              ),
              color: AppColors.background,
              alignment: Alignment.centerLeft,
              child: Text(
                'shop_benefits'.tr,
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 18,
              ),
              color: AppColors.background,
              alignment: Alignment.center,
              child: Text(
                'shop_free'.tr,
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMedium,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 18,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.blue100, AppColors.blue50],
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'shop_premium'.tr,
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.blue700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(PremiumBenefitModel benefit, {required bool isLast}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: 18,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: isLast
                    ? null
                    : const Border(
                        bottom: BorderSide(color: AppColors.border, width: 1),
                      ),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                benefit.localizedTitle,
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                  height: 1.3,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: isLast
                    ? null
                    : const Border(
                        bottom: BorderSide(color: AppColors.border, width: 1),
                      ),
              ),
              alignment: Alignment.center,
              child: benefit.freeIncluded
                  ? _buildCheckIcon(
                      backgroundColor: AppColors.green50,
                      borderColor: AppColors.green500,
                      iconColor: AppColors.green700,
                    )
                  : _buildCrossIcon(),
            ),
          ),

          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.blue50,
                border: isLast
                    ? null
                    : const Border(
                        bottom: BorderSide(color: AppColors.blue100, width: 1),
                      ),
              ),
              alignment: Alignment.center,
              child: benefit.premiumIncluded
                  ? _buildCheckIcon(
                      backgroundColor: AppColors.blue500,
                      borderColor: AppColors.blue500,
                      iconColor: AppColors.surface,
                      emphasized: true,
                    )
                  : _buildCrossIcon(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckIcon({
    required Color backgroundColor,
    required Color borderColor,
    required Color iconColor,
    bool emphasized = false,
  }) {
    return Container(
      width: emphasized ? 32 : 28,
      height: emphasized ? 32 : 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: emphasized
            ? const [
                BoxShadow(
                  color: AppColors.blue100,
                  offset: Offset(0, 3),
                  blurRadius: 0,
                ),
              ]
            : null,
      ),
      child: Icon(
        Icons.check_rounded,
        size: emphasized ? 20 : 17,
        color: iconColor,
      ),
    );
  }

  Widget _buildCrossIcon() {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.background,
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: const Icon(
        Icons.close_rounded,
        size: 16,
        color: AppColors.textHint,
      ),
    );
  }
}
