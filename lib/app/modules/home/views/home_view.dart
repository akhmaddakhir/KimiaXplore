import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../widgets/app_main_header.dart';
import '../../../widgets/app_stat_chip.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppMainHeader(
              title: 'Home',
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
              actions: [
                Obx(
                  () => AppStatChip(
                    icon: const Icon(
                      Icons.event_available_rounded,
                      size: 18,
                      color: AppColors.blue500,
                    ),
                    value: '${controller.studyProgress.value}',
                    tooltip: 'Progres Belajar',
                    backgroundColor: AppColors.blue50,
                    borderColor: AppColors.blue100,
                    textColor: AppColors.blue500,
                    onTap: () {
                    },
                  ),
                ),
              ],
            ),

            const Expanded(
              child: Center(
                child: Text(
                  'HomeView is working',
                  style: TextStyle(fontSize: 20, color: AppColors.textMedium),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
