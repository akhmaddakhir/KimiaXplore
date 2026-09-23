import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_detail_header.dart';

import '../controllers/quiz_controller.dart';
import '../models/quiz_question_model.dart';
import '../widgets/quiz_explanation_sheet.dart';
import '../widgets/quiz_option_card.dart';
import '../widgets/quiz_question_header.dart';

class QuizDiscussionView extends GetView<QuizController> {
  const QuizDiscussionView({super.key});

  QuizOptionState _getOptionState(
    QuizQuestionModel question,
    int questionIndex,
    int optionIndex,
  ) {
    final selectedIndex = controller.getSelectedAnswer(questionIndex);

    if (optionIndex == question.correctOptionIndex) {
      return QuizOptionState.correct;
    }

    if (selectedIndex == optionIndex) {
      return QuizOptionState.incorrect;
    }

    return QuizOptionState.normal;
  }

  void _showExplanationSheet(BuildContext context, QuizQuestionModel question) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: AppColors.surface,
      barrierColor: AppColors.textDark.withValues(alpha: 0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return QuizExplanationSheet(explanation: question.explanation ?? '');
      },
    );
  }

  Widget _buildQuestion(
    BuildContext context,
    QuizQuestionModel question,
    int questionIndex,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuizQuestionHeader(
          questionNumber: questionIndex + 1,
          question: question.question,
          onReportPressed: () {},
        ),

        const SizedBox(height: AppSpacing.xl),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Column(
            children: List.generate(question.options.length, (optionIndex) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: QuizOptionCard(
                  label: question.options[optionIndex],
                  state: _getOptionState(question, questionIndex, optionIndex),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Align(
            alignment: Alignment.centerRight,
            child: AppButton.icon(
              height: 56,
              onPressed: () {
                _showExplanationSheet(context, question);
              },
              icon: Text(
                '?',
                style: AppTypography.heading2.copyWith(
                  color: AppColors.textDark,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppDetailHeader(title: 'quiz_evaluation_title'.tr),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(controller.totalQuestions, (
                        questionIndex,
                      ) {
                        final question = controller.questions[questionIndex];

                        return _buildQuestion(context, question, questionIndex);
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
