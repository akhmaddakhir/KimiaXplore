import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_step_header.dart';
import '../controllers/onboarding_controller.dart';
import '../models/onboarding_question.dart';
import '../widgets/onboarding_option.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Obx(
              () => AppStepHeader.steps(
                currentStep: controller.currentPage.value + 1,
                totalSteps: controller.totalPages,
                onBackPressed: controller.previousPage,
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  physics: const NeverScrollableScrollPhysics(),
                  children: controller.questions
                      .map((question) => _buildQuestionPage(question))
                      .toList(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: SizedBox(
                width: double.infinity,
                child: Obx(
                  () => AppButton.primary(
                    label: controller.isLastPage ? 'Selesai' : 'Lanjut',
                    onPressed: controller.canContinue
                        ? controller.nextPage
                        : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionPage(OnboardingQuestion question) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            question.title,
            style: AppTypography.heading2.copyWith(color: AppColors.textDark),
          ),
          const SizedBox(height: 24),
          ...question.options.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Obx(
                () => OnboardingOptionCard(
                  label: option.title,
                  isSelected: controller.isOptionSelectedForQuestion(
                    question.id,
                    option.id,
                  ),
                  onTap: () => controller.selectAnswerForQuestion(
                    question.id,
                    option.id,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
