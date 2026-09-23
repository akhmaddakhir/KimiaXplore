import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_main_header.dart';
import '../controllers/shop_controller.dart';
import '../widgets/pricing_package_card.dart';
import '../widgets/shop_comparison_table.dart';

class ShopView extends GetView<ShopController> {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: Obx(() {
                if (controller.currentStep.value == 1) {
                  return _buildPackageStep();
                }

                return _buildBenefitStep();
              }),
            ),

            Obx(
              () => controller.currentStep.value == 0
                  ? _buildBenefitBottomBar()
                  : _buildPackageBottomBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AppMainHeader(
      title: 'shop_title'.tr,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.md,
      ),
    );
  }

  Widget _buildBenefitStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.md),

          _buildIntroduction(),

          const SizedBox(height: AppSpacing.xl),

          ShopComparisonTable(benefits: controller.benefits),

          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildPackageStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.md),

          SizedBox(
            width: double.infinity,
            child: Text(
              'shop_choose_plan'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E352F),
                height: 1.25,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          SizedBox(
            width: double.infinity,
            child: Text(
              'shop_choose_desc'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF758A83),
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          ...controller.packages.map(
            (package) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Obx(
                () => PricingPackageCard(
                  package: package,
                  isSelected: controller.selectedPackageId.value == package.id,
                  onTap: () {
                    controller.selectPackage(package.id);
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            'shop_intro_title'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E352F),
              height: 1.25,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        SizedBox(
          width: double.infinity,
          child: Text(
            'shop_intro_desc'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF758A83),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitBottomBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      color: AppColors.background,
      child: AppButton.primary(
        label: 'shop_view_plans'.tr,
        onPressed: controller.goToPackages,
      ),
    );
  }

  Widget _buildPackageBottomBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      color: AppColors.background,
      child: AppButton.primary(
        label: 'shop_continue'.tr,
        onPressed: () {
          // Payment.
        },
      ),
    );
  }
}
