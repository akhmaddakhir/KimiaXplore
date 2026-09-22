import 'package:get/get.dart';

import '../data/quiz_data.dart';
import '../models/quiz_question_model.dart';

class QuizController extends GetxController {
  final questions = <QuizQuestionModel>[].obs;

  final currentQuestionIndex = 0.obs;

  final selectedOptionIndex = RxnInt();

  final isAnswerChecked = false.obs;
  final isAnswerCorrect = false.obs;

  final score = 0.obs;

  final isQuizFinished = false.obs;

  QuizQuestionModel? get currentQuestion {
    if (questions.isEmpty) {
      return null;
    }

    if (currentQuestionIndex.value >= questions.length) {
      return null;
    }

    return questions[currentQuestionIndex.value];
  }

  int get totalQuestions => questions.length;

  int get currentQuestionNumber => currentQuestionIndex.value + 1;

  double get progress {
    if (questions.isEmpty) {
      return 0.0;
    }

    return currentQuestionNumber / totalQuestions;
  }

  bool get hasSelectedAnswer => selectedOptionIndex.value != null;

  bool get canCheckAnswer =>
      hasSelectedAnswer && !isAnswerChecked.value && !isQuizFinished.value;

  bool get isLastQuestion => currentQuestionIndex.value == totalQuestions - 1;

  @override
  void onInit() {
    super.onInit();

    loadQuestions();
  }

  void loadQuestions() {
    questions.assignAll(QuizData.defaultQuestions);

    currentQuestionIndex.value = 0;
    selectedOptionIndex.value = null;

    isAnswerChecked.value = false;
    isAnswerCorrect.value = false;

    score.value = 0;
    isQuizFinished.value = false;
  }

  void selectOption(int index) {
    if (isAnswerChecked.value || isQuizFinished.value) {
      return;
    }

    final question = currentQuestion;

    if (question == null) {
      return;
    }

    if (index < 0 || index >= question.options.length) {
      return;
    }

    selectedOptionIndex.value = index;
  }

  void checkAnswer() {
    if (!canCheckAnswer) {
      return;
    }

    final question = currentQuestion;

    if (question == null) {
      return;
    }

    final selectedIndex = selectedOptionIndex.value;

    if (selectedIndex == null) {
      return;
    }

    final isCorrect = selectedIndex == question.correctOptionIndex;

    isAnswerCorrect.value = isCorrect;
    isAnswerChecked.value = true;

    if (isCorrect) {
      score.value++;
    }
  }

  void nextQuestion() {
    if (!isAnswerChecked.value || isQuizFinished.value) {
      return;
    }

    if (isLastQuestion) {
      isQuizFinished.value = true;
      return;
    }

    currentQuestionIndex.value++;

    resetAnswer();
  }

  void resetAnswer() {
    selectedOptionIndex.value = null;

    isAnswerChecked.value = false;
    isAnswerCorrect.value = false;
  }

  void restartQuiz() {
    loadQuestions();
  }
}
