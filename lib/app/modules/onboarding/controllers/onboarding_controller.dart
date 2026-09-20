import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/onboarding_question.dart';
import '../data/onboarding_questions.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();

  final currentPage = 0.obs;

  final questions = OnboardingQuestions.items;

  final answers = <String, String>{}.obs;

  int get totalPages => questions.length + 1;

  bool get isIntroPage => currentPage.value == 0;

  int get currentQuestionIndex => currentPage.value - 1;

  bool get isLastPage => currentPage.value == totalPages - 1;

  OnboardingQuestion? get currentQuestion {
    if (currentQuestionIndex < 0 || currentQuestionIndex >= questions.length) {
      return null;
    }

    return questions[currentQuestionIndex];
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void selectAnswerForQuestion(String questionId, String optionId) {
    final question = questions.firstWhereOrNull(
      (question) => question.id == questionId,
    );

    if (question == null) return;

    final isValidOption = question.options.any(
      (option) => option.id == optionId,
    );

    if (!isValidOption) return;

    answers[questionId] = optionId;
  }

  bool isOptionSelectedForQuestion(String questionId, String optionId) {
    return answers[questionId] == optionId;
  }

  bool get canContinue {
    if (isIntroPage) return true;

    final question = currentQuestion;

    if (question == null) return false;

    if (!question.isRequired) return true;

    return answers.containsKey(question.id);
  }

  void nextPage() {
    if (!canContinue) return;

    if (!isLastPage) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void completeOnboarding() {
    // Menyimpan jawaban onboarding.
    // Mengarahkan user ke Register page.
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
