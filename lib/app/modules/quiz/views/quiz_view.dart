import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/app_step_header.dart';

import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            Obx(
              () => AppStepHeader.steps(
                currentStep: controller.currentQuestionNumber,
                totalSteps: controller.totalQuestions,
                backIcon: Icons.close_rounded,
                progressColor: AppColors.blue500,
                trackColor: AppColors.border,
                onBackPressed: () => Get.back(),
              ),
            ),

            const Expanded(child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
