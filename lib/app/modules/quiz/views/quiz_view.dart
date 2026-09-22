import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/app_step_header.dart';

import '../controllers/quiz_controller.dart';
import '../widgets/quiz_bottom_bar.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  final QuizController controller = Get.find<QuizController>();

  QuizBottomState _bottomState = QuizBottomState.answering;

  void _previewNextState() {
    setState(() {
      switch (_bottomState) {
        case QuizBottomState.answering:
          _bottomState = QuizBottomState.correct;
          break;

        case QuizBottomState.correct:
          _bottomState = QuizBottomState.incorrect;
          break;

        case QuizBottomState.incorrect:
          _bottomState = QuizBottomState.answering;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        bottom: false,
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

            QuizBottomBar(state: _bottomState, onPressed: _previewNextState),
          ],
        ),
      ),
    );
  }
}
