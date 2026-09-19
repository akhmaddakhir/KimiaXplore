import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_step_header.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppStepHeader.steps(
              currentStep: 1,
              totalSteps: 7,
              onBackPressed: controller.previousPage,
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    // Onboarding page content
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: SizedBox(
                width: double.infinity,
                child: AppButton.primary(
                  label: 'Lanjut',
                  onPressed: controller.nextPage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
