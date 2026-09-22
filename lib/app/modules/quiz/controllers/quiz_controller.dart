import 'package:get/get.dart';

import '../../../models/activity_navigation.dart';
import '../../../routes/app_routes.dart';
import '../../../services/learning_progress_service.dart';
import '../../home/models/topic_model.dart';
import '../data/quiz_data.dart';
import '../models/quiz_question_model.dart';

class QuizController extends GetxController {
  final LearningProgressService _progressService = LearningProgressService();

  final topic = Rxn<TopicModel>();

  final questions = <QuizQuestionModel>[].obs;

  final currentQuestionIndex = 0.obs;

  final selectedOptionIndex = RxnInt();

  final isAnswerChecked = false.obs;
  final isAnswerCorrect = false.obs;

  final score = 0.obs;

  final isQuizFinished = false.obs;
  final isSavingProgress = false.obs;

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

  int get scorePercentage {
    if (totalQuestions == 0) {
      return 0;
    }

    return ((score.value / totalQuestions) * 100).round();
  }

  String? get quizActivityId {
    final currentTopic = topic.value;

    if (currentTopic == null) {
      return null;
    }

    return '${currentTopic.id}_quiz';
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
    _markQuizOpened();
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

  Future<void> _markQuizOpened() async {
    final currentTopic = topic.value;
    final activityId = quizActivityId;

    if (currentTopic == null || activityId == null) {
      return;
    }

    try {
      await _progressService.markActivityOpened(
        topicId: currentTopic.id,
        activityType: 'quiz',
        activityId: activityId,
      );
    } catch (_) {}
  }

  Future<void> _saveQuizCompletion() async {
    final currentTopic = topic.value;
    final activityId = quizActivityId;

    if (currentTopic == null || activityId == null || isSavingProgress.value) {
      return;
    }

    isSavingProgress.value = true;

    try {
      await _progressService.completeActivity(
        topicId: currentTopic.id,
        activityType: 'quiz',
        activityId: activityId,
        score: scorePercentage,
        progress: totalQuestions,
        total: totalQuestions,
      );
    } finally {
      isSavingProgress.value = false;
    }
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

  Future<void> nextQuestion() async {
    if (!isAnswerChecked.value || isQuizFinished.value) {
      return;
    }

    if (isLastQuestion) {
      await _saveQuizCompletion();

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
    _markQuizOpened();
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
