import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../widgets/app_step_header.dart';

import '../controllers/quiz_controller.dart';
import '../widgets/quiz_bottom_bar.dart';
import '../widgets/quiz_option_card.dart';
import '../widgets/quiz_question_header.dart';
import 'quiz_completion_view.dart';
import 'quiz_result_view.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  final QuizController controller = Get.find<QuizController>();

  bool _showResult = false;

  QuizBottomState get _bottomState {
    if (!controller.isAnswerChecked.value) {
      return QuizBottomState.answering;
    }

    if (controller.isAnswerCorrect.value) {
      return QuizBottomState.correct;
    }

    return QuizBottomState.incorrect;
  }

  QuizOptionState _getOptionState(int index) {
    final question = controller.currentQuestion;

    if (question == null) {
      return QuizOptionState.normal;
    }

    final selectedIndex = controller.selectedOptionIndex.value;

    if (!controller.isAnswerChecked.value) {
      if (selectedIndex == index) {
        return QuizOptionState.selected;
      }

      return QuizOptionState.normal;
    }

    if (index == question.correctOptionIndex) {
      return QuizOptionState.correct;
    }

    if (selectedIndex == index) {
      return QuizOptionState.incorrect;
    }

    return QuizOptionState.normal;
  }

  void _handleBottomButton() {
    if (!controller.isAnswerChecked.value) {
      controller.checkAnswer();
      return;
    }

    controller.nextQuestion();
  }

  void _showQuizResult() {
    setState(() {
      _showResult = true;
    });
  }

  void _exitQuiz() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isQuizFinished.value) {
        if (_showResult) {
          return QuizResultView(onContinue: _exitQuiz);
        }

        return QuizCompletionView(onContinue: _showQuizResult);
      }

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
                  onBackPressed: _exitQuiz,
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
                                  onTap: controller.isAnswerChecked.value
                                      ? null
                                      : () => controller.selectOption(index),
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
              Obx(
                () => QuizBottomBar(
                  state: _bottomState,
                  onPressed:
                      controller.isAnswerChecked.value ||
                          controller.canCheckAnswer
                      ? _handleBottomButton
                      : null,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
