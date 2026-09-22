import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../widgets/app_step_header.dart';

import '../controllers/quiz_controller.dart';
import '../widgets/quiz_bottom_bar.dart';
import '../widgets/quiz_option_card.dart';
import '../widgets/quiz_question_header.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  final QuizController controller = Get.find<QuizController>();

  int? _selectedOptionIndex;

  QuizBottomState _bottomState = QuizBottomState.answering;

  void _selectOption(int index) {
    if (_bottomState != QuizBottomState.answering) {
      return;
    }

    setState(() {
      _selectedOptionIndex = index;
    });
  }

  void _previewNextState() {
    if (_selectedOptionIndex == null) {
      return;
    }

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
          _selectedOptionIndex = null;
          break;
      }
    });
  }

  QuizOptionState _getOptionState(int index) {
    if (_selectedOptionIndex != index) {
      return QuizOptionState.normal;
    }

    switch (_bottomState) {
      case QuizBottomState.answering:
        return QuizOptionState.selected;

      case QuizBottomState.correct:
        return QuizOptionState.correct;

      case QuizBottomState.incorrect:
        return QuizOptionState.incorrect;
    }
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

            Expanded(
              child: Obx(() {
                final question = controller.currentQuestion;

                if (question == null) {
                  return const SizedBox.shrink();
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QuizQuestionHeader(
                        questionNumber: controller.currentQuestionNumber,
                        question: question.question,
                        onReportPressed: () {},
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xl,
                        ),
                        child: Column(
                          children: List.generate(question.options.length, (
                            index,
                          ) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.md,
                              ),
                              child: QuizOptionCard(
                                label: question.options[index],
                                state: _getOptionState(index),
                                onTap: () => _selectOption(index),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            QuizBottomBar(
              state: _bottomState,
              onPressed: _selectedOptionIndex == null
                  ? null
                  : _previewNextState,
            ),
          ],
        ),
      ),
    );
  }
}
