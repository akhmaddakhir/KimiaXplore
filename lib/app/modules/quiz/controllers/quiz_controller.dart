import 'package:get/get.dart';

import '../../../models/activity_navigation.dart';
import '../../../routes/app_routes.dart';
import '../../home/models/topic_model.dart';
import '../data/quiz_data.dart';
import '../models/quiz_question_model.dart';

class QuizController extends GetxController {
  final topic = Rxn<TopicModel>();

  final questions = <QuizQuestionModel>[].obs;

  final currentQuestionIndex = 0.obs;

  final selectedOptionIndex = RxnInt();

  final isAnswerChecked = false.obs;
  final isAnswerCorrect = false.obs;

  final score = 0.obs;

  final isQuizFinished = false.obs;

  final selectedAnswers = <int, int>{}.obs;

  ActivityEntryPoint entryPoint = ActivityEntryPoint.activity;

  bool get isRecommended => entryPoint == ActivityEntryPoint.recommendation;

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

  int? getSelectedAnswer(int questionIndex) {
    return selectedAnswers[questionIndex];
  }

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;

    if (arguments is ActivityNavigation) {
      topic.value = arguments.topic;
      entryPoint = arguments.entryPoint;
    } else if (arguments is TopicModel) {
      topic.value = arguments;
    }

    loadQuestions();
  }

  void loadQuestions() {
    final currentTopic = topic.value;

    if (currentTopic != null) {
      questions.assignAll(QuizData.getQuestionsByTopic(currentTopic.id));
    } else {
      questions.clear();
    }

    currentQuestionIndex.value = 0;
    selectedOptionIndex.value = null;

    selectedAnswers.clear();

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

    selectedAnswers[currentQuestionIndex.value] = selectedIndex;

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

  void finishQuiz() {
    final currentTopic = topic.value;

    if (isRecommended && currentTopic != null) {
      Get.offNamed(
        AppRoutes.flashcard,
        arguments: ActivityNavigation(
          topic: currentTopic,
          entryPoint: ActivityEntryPoint.recommendation,
        ),
      );
      return;
    }

    Get.back();
  }
}
