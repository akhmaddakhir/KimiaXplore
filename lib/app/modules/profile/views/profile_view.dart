import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../widgets/app_main_header.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppMainHeader(
              title: 'Profile',
              actions: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: controller.openSettings,
                  child: const SizedBox(
                    width: 36,
                    height: 36,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.settings_rounded,
                        color: AppColors.textDark,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ],
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
