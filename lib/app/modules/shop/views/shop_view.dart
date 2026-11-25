import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_main_header.dart';
import '../controllers/shop_controller.dart';
import '../widgets/pricing_package_card.dart';

class ShopView extends GetView<ShopController> {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppMainHeader(
              title: 'shop_title'.tr,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.blue500,
                onRefresh: controller.loadPackages,
                child: Obx(() {
                  if (controller.isLoading.value && controller.packages.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.blue500,
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      AppSpacing.sm,
                      AppSpacing.xl,
                      AppSpacing.xxxl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BANDINGKAN PAKET',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textMedium,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        ...controller.packages.map(
                          (package) => Padding(
                            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                            child: Obx(
                              () => PricingPackageCard(
                                package: package,
                                isSelected:
                                    controller.selectedPackageId.value ==
                                    package.id,
                                isLoading: controller.isLoading.value,
                                onTap: () =>
                                    controller.selectPackage(package.id),
                                onSubscribe: () =>
                                    controller.subscribePackage(package),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
