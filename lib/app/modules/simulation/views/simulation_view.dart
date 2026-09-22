import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_detail_header.dart';
import '../controllers/simulation_controller.dart';
import '../widgets/matter_particle_chamber.dart';
import '../widgets/matter_state_card.dart';
import '../widgets/temperature_control.dart';

class SimulationView extends GetView<SimulationController> {
  const SimulationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isStatesOfMatter) {
        return _UnavailableSimulationView(title: controller.title);
      }

      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              AppDetailHeader(title: controller.title),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xl,
                    AppSpacing.md,
                    AppSpacing.xl,
                    AppSpacing.xxl,
                  ),
                  child: Obx(() {
                    final state = controller.matterState;
                    final temperature = controller.temperature.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lihat partikel berubah',
                          style: AppTypography.heading1.copyWith(
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Geser suhu dan amati bagaimana susunan serta gerakan partikel berubah dari padat, cair, hingga gas.',
                          style: AppTypography.body.copyWith(
                            color: AppColors.textMedium,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        MatterParticleChamber(
                          state: state,
                          temperature: temperature,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        TemperatureControl(
                          temperature: temperature,
                          state: state,
                          min: SimulationController.minTemperature,
                          max: SimulationController.maxTemperature,
                          onChanged: controller.updateTemperature,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        MatterStateCard(state: state),
                        const SizedBox(height: AppSpacing.xl),
                        AppButton.outline(
                          label: 'Reset Simulasi',
                          icon: const Icon(
                            Icons.refresh_rounded,
                            color: AppColors.blue500,
                            size: 22,
                          ),
                          onPressed: controller.resetTemperature,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _UnavailableSimulationView extends StatelessWidget {
  const _UnavailableSimulationView({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppDetailHeader(title: title),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: AppColors.blue50,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: const Icon(
                        Icons.science_rounded,
                        size: 44,
                        color: AppColors.blue500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      'Simulasi belum tersedia',
                      textAlign: TextAlign.center,
                      style: AppTypography.heading2.copyWith(
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Eksperimen ini masih disiapkan. Coba Wujud Zat terlebih dahulu.',
                      textAlign: TextAlign.center,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppButton.outline(
                      label: 'Kembali ke Lab',
                      onPressed: Get.back,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
