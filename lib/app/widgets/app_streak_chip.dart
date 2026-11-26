import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../modules/home/controllers/home_controller.dart';
import '../theme/app_colors.dart';
import 'app_stat_chip.dart';

class AppStreakChip extends StatelessWidget {
  const AppStreakChip({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<HomeController>()) {
      return const SizedBox.shrink();
    }

    final homeController = Get.find<HomeController>();

    return Obx(() {
      final status = homeController.streakStatus.value;
      final String iconAsset;
      final Color backgroundColor;
      final Color borderColor;
      final Color textColor;

      switch (status) {
        case StreakStatus.active:
          iconAsset = 'assets/icons/streak_icon.svg';
          backgroundColor = AppColors.yellow50;
          borderColor = AppColors.lightOrange;
          textColor = AppColors.darkOrange;
        case StreakStatus.frozen:
          iconAsset = 'assets/icons/streak_icon_freeze.svg';
          backgroundColor = AppColors.blue50;
          borderColor = AppColors.blue100;
          textColor = AppColors.blue700;
        case StreakStatus.off:
          iconAsset = 'assets/icons/streak_icon_off.svg';
          backgroundColor = AppColors.surface;
          borderColor = AppColors.border;
          textColor = AppColors.textMedium;
      }

      return AppStatChip(
        icon: SvgPicture.asset(
          iconAsset,
          width: 28,
          height: 28,
        ),
        value: '${homeController.streakCount.value}',
        tooltip: 'Streak',
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        textColor: textColor,
        fontSize: 16,
        iconSpacing: 4,
        padding: const EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 4,
        ),
        onTap: onTap ?? () {},
      );
    });
  }
}
