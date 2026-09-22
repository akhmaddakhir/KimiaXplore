import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/app_step_header.dart';
import '../controllers/flashcard_controller.dart';
import '../widgets/flashcard_bottom_bar.dart';

class FlashcardView extends GetView<FlashcardController> {
  const FlashcardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppStepHeader.steps(
              currentStep: 1,
              totalSteps: 10,
              backIcon: Icons.close_rounded,
              progressColor: AppColors.blue500,
              trackColor: AppColors.border,
              onBackPressed: () => Get.back(),
            ),
            const Expanded(child: SizedBox(width: double.infinity)),
            FlashcardBottomBar(onNotMemorized: () {}, onMemorized: () {}),
          ],
        ),
      ),
    );
  }
}
