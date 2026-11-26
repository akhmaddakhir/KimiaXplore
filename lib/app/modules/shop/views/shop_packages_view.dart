import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_detail_header.dart';
import '../controllers/shop_controller.dart';
import '../widgets/pricing_package_card.dart';

class ShopPackagesView extends GetView<ShopController> {
  const ShopPackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const AppDetailHeader(
              title: 'Pilih Paket Premium',
              subtitle: 'Untuk pengalaman belajar maksimal',
            ),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.blue500,
                onRefresh: controller.loadPackages,
                child: Obx(() {
                  final list = controller.orderedPackages;

                  if (controller.isLoading.value && list.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.blue500,
                      ),
                    );
                  }

                  if (list.isEmpty) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(AppSpacing.xxl),
                      children: [
                        Center(
                          child: Text(
                            'Belum ada paket langganan tersedia.',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textMedium,
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      AppSpacing.lg,
                      AppSpacing.xl,
                      AppSpacing.xl,
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < list.length; i++) ...[
                          Builder(
                            builder: (context) {
                              final package = list[i];
                              final isQuantum =
                                  package.id.toLowerCase().contains('quantum') ||
                                  package.title.toLowerCase().contains('quantum');
                              final showPopular =
                                  isQuantum || (i == 0 && package.isPopular);

                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.lg,
                                ),
                                child: Obx(
                                  () => PricingPackageCard(
                                    package: package,
                                    isSelected:
                                        controller.selectedPackageId.value ==
                                        package.id,
                                    showPopularTag: showPopular,
                                    onTap: () =>
                                        controller.selectPackage(package.id),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  );
                }),
              ),
            ),
            // Tombol Beli di bawah (tanpa maskot di atasnya)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.sm,
                AppSpacing.xl,
                AppSpacing.lg,
              ),
              child: Obx(() {
                final loading = controller.isLoading.value;
                return SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: GestureDetector(
                    onTap: loading ? null : controller.subscribeCurrentPackage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.blue500,
                        borderRadius: BorderRadius.circular(16),
                        border: const Border(
                          bottom: BorderSide(
                            color: AppColors.blue700,
                            width: 4,
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: loading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Beli',
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamily,
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
