import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_main_header.dart';
import '../controllers/shop_controller.dart';
import '../models/premium_benefit_model.dart';
import 'shop_packages_view.dart';

class ShopView extends GetView<ShopController> {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const AppMainHeader(
              title: '',
              padding: EdgeInsets.fromLTRB(
                AppSpacing.xl,
                0,
                AppSpacing.xl,
                0,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.xs,
                  AppSpacing.xl,
                  AppSpacing.xl,
                ),
                child: Column(
                  children: [
                    Text(
                      'Nikmati bebas belajar\ntanpa batas dengan Premium',
                      textAlign: TextAlign.center,
                      style: AppTypography.heading2.copyWith(
                        color: AppColors.textDark,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _PremiumComparisonColumns(benefits: controller.benefits),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.sm,
                AppSpacing.xl,
                AppSpacing.lg,
              ),
              child: GestureDetector(
                onTap: () => Get.to(() => const ShopPackagesView()),
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.blue500,
                    borderRadius: BorderRadius.circular(16),
                    border: const Border(
                      bottom: BorderSide(color: AppColors.blue700, width: 4),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Lanjut',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PremiumComparisonColumns extends StatelessWidget {
  final List<PremiumBenefitModel> benefits;

  const _PremiumComparisonColumns({required this.benefits});

  static const double _freeColWidth = 74.0;
  static const double _premiumColWidth = 98.0;
  static const double _headerHeight = 62.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background kolom Gratis & Premium
        Positioned.fill(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Container(
                width: _freeColWidth,
                margin: const EdgeInsets.only(top: 14),
                decoration: BoxDecoration(
                  color: AppColors.border.withValues(alpha: 0.35),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
              ),
              Container(
                width: _premiumColWidth,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.blue300,
                      AppColors.lightTeal,
                      AppColors.blue100,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.fromLTRB(
                  6,
                  _headerHeight - 4,
                  6,
                  6,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Konten header & baris dengan garis pemisah penuh
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: _headerHeight,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Text(
                        'Manfaat',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w800,
                          fontSize: 15.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _freeColWidth,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Center(
                        child: Text(
                          'Gratis',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textMedium,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _premiumColWidth,
                    child: Center(
                      child: Text(
                        'Premium',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w900,
                          fontSize: 14.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: _premiumColWidth),
              child: Divider(
                color: AppColors.border,
                height: 1,
                thickness: 1,
              ),
            ),
            for (int i = 0; i < benefits.length; i++) ...[
              _BenefitRow(
                benefit: benefits[i],
                freeColWidth: _freeColWidth,
                premiumColWidth: _premiumColWidth,
              ),
              if (i < benefits.length - 1)
                const Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Divider(
                    color: AppColors.border,
                    height: 1,
                    thickness: 1,
                  ),
                ),
            ],
          ],
        ),
      ],
    );
  }
}

class _BenefitRow extends StatelessWidget {
  final PremiumBenefitModel benefit;
  final double freeColWidth;
  final double premiumColWidth;

  const _BenefitRow({
    required this.benefit,
    required this.freeColWidth,
    required this.premiumColWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 74),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: AppSpacing.md),
                child: Text(
                  benefit.title,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                    height: 1.3,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: freeColWidth,
              child: Center(
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: benefit.freeIncluded
                        ? AppColors.green50
                        : AppColors.textHint.withValues(alpha: 0.28),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    benefit.freeIncluded
                        ? Icons.check_rounded
                        : Icons.close_rounded,
                    size: 16,
                    color: benefit.freeIncluded
                        ? AppColors.green700
                        : AppColors.textDark,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: premiumColWidth,
              child: Center(
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.blue500, AppColors.teal],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    benefit.premiumIncluded
                        ? Icons.check_rounded
                        : Icons.close_rounded,
                    size: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
