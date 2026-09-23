import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const Spacer(flex: 3),

                        _buildMascotArea(),

                        const SizedBox(height: 32),

                        Text(
                          'welcome_explore_further'.tr,
                          textAlign: TextAlign.center,
                          style: AppTypography.heading1.copyWith(
                            color: AppColors.textDark,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'welcome_desc'.tr,
                          textAlign: TextAlign.center,
                          style: AppTypography.body.copyWith(
                            color: AppColors.textMedium,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const Spacer(flex: 4),

                        AppButton.primary(
                          label: 'welcome_start'.tr,
                          onPressed: controller.onStartPressed,
                        ),
                        const SizedBox(height: 14),
                        AppButton.outline(
                          label: 'welcome_have_account'.tr,
                          onPressed: controller.onLoginPressed,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMascotArea() {
    return const SizedBox(height: 260, width: 260);
  }
}
