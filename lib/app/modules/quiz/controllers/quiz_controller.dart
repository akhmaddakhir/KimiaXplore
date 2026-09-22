import 'package:get/get.dart';

import '../data/quiz_data.dart';
import '../models/quiz_question_model.dart';

class QuizController extends GetxController {
  final questions = <QuizQuestionModel>[].obs;

  final currentQuestionIndex = 0.obs;

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

  @override
  void onInit() {
    super.onInit();

    loadQuestions();
  }

  void loadQuestions() {
    questions.assignAll(QuizData.defaultQuestions);

    currentQuestionIndex.value = 0;
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }
}
