import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_main_header.dart';
import '../controllers/shop_controller.dart';
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
            Expanded(child: _buildContent()),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const AppMainHeader(
      title: 'KimiaXplore Premium',
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.md,
      ),
    );
  }

  Widget _buildContent() {
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

  Widget _buildIntroduction() {
    return const Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            'Makin Banyak Tanya, Makin Banyak Paham',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E352F),
              height: 1.25,
            ),
          ),
        ),

        SizedBox(height: AppSpacing.sm),

        SizedBox(
          width: double.infinity,
          child: Text(
            'Dapatkan akses AI Tutor lebih lengkap dengan batas penggunaan yang lebih besar.',
            textAlign: TextAlign.center,
            style: TextStyle(
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

  Widget _buildBottomBar() {
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
        label: 'Lihat Paket Premium',
        onPressed: controller.goToPackages,
      ),
    );
  }
}
