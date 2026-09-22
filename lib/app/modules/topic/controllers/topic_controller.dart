import 'package:get/get.dart';

import '../../../models/activity_navigation.dart';
import '../../../routes/app_routes.dart';
import '../../../services/learning_progress_service.dart';
import '../../home/models/topic_model.dart';
import '../../lab/data/lab_simulations.dart';
import '../../lab/models/simulation_model.dart';
import '../../material/data/material_lesson_data.dart';
import '../../material/models/material_lesson_model.dart';
import '../../material/views/material_lesson_list_view.dart';
import '../models/topic_activity_type.dart';

class TopicController extends GetxController {
  final LearningProgressService _progressService = LearningProgressService();

  final topic = Rxn<TopicModel>();

  final completedProgress = 0.obs;
  final totalProgress = 0.obs;

  final completedLessons = 0.obs;
  final totalLessons = 0.obs;

  final isQuizCompleted = false.obs;
  final isFlashcardCompleted = false.obs;

  final isLoadingProgress = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments is TopicModel) {
      topic.value = Get.arguments as TopicModel;
      _initializeProgress();
    }
  }

  void _initializeProgress() {
    final currentTopic = topic.value;

    if (currentTopic == null) {
      return;
    }

    final lessons = MaterialLessonData.getLessonsByTopic(currentTopic.id);

    totalLessons.value = lessons.length;
    totalProgress.value = lessons.length + 2;

    loadProgress();
  }

  Future<void> loadProgress() async {
    final currentTopic = topic.value;

    if (currentTopic == null) {
      return;
    }

    isLoadingProgress.value = true;

    try {
      final lessons = MaterialLessonData.getLessonsByTopic(currentTopic.id);

      final progressData = await _progressService.getTopicProgress(
        currentTopic.id,
      );

      final completedMaterialIds = progressData
          .where(
            (item) =>
                item['activity_type'] == 'material' &&
                item['is_completed'] == true,
          )
          .map((item) => item['activity_id'] as String)
          .toSet();

      completedLessons.value = lessons
          .where((lesson) => completedMaterialIds.contains(lesson.id))
          .length;

      totalLessons.value = lessons.length;

      isQuizCompleted.value = progressData.any(
        (item) =>
            item['activity_type'] == 'quiz' && item['is_completed'] == true,
      );

      isFlashcardCompleted.value = progressData.any(
        (item) =>
            item['activity_type'] == 'flashcard' &&
            item['is_completed'] == true,
      );

      totalProgress.value = lessons.length + 2;

      completedProgress.value =
          completedLessons.value +
          (isQuizCompleted.value ? 1 : 0) +
          (isFlashcardCompleted.value ? 1 : 0);
    } finally {
      isLoadingProgress.value = false;
    }
  }

  Future<void> onRecommendedActivityPressed() async {
    final currentTopic = topic.value;

    if (currentTopic == null) {
      return;
    }

    await Get.toNamed(
      AppRoutes.material,
      arguments: ActivityNavigation(
        topic: currentTopic,
        entryPoint: ActivityEntryPoint.recommendation,
      ),
    );

    await loadProgress();
  }

  Future<void> onActivitySelected(TopicActivityType activity) async {
    final currentTopic = topic.value;

    if (currentTopic == null) {
      return;
    }

    final navigation = ActivityNavigation(
      topic: currentTopic,
      entryPoint: ActivityEntryPoint.activity,
    );

    switch (activity) {
      case TopicActivityType.materi:
        await _openMaterial(currentTopic);
        await loadProgress();
        break;

      case TopicActivityType.kuis:
        await Get.toNamed(AppRoutes.quiz, arguments: navigation);

        await loadProgress();
        break;

      case TopicActivityType.flashcard:
        await Get.toNamed(AppRoutes.flashcard, arguments: navigation);

        await loadProgress();
        break;

      case TopicActivityType.simulasi:
        await _openSimulation(currentTopic);
        await loadProgress();
        break;
    }
  }

  Future<void> _openMaterial(TopicModel currentTopic) async {
    final lessons = MaterialLessonData.getLessonsByTopic(currentTopic.id);

    if (lessons.length > 1) {
      await Get.to(() => MaterialLessonListView(topic: currentTopic));

      return;
    }

    if (lessons.isEmpty) {
      await Get.toNamed(
        AppRoutes.material,
        arguments: ActivityNavigation(
          topic: currentTopic,
          entryPoint: ActivityEntryPoint.activity,
        ),
      );

      return;
    }

    await Get.toNamed(
      AppRoutes.material,
      arguments: MaterialLessonSelection(
        topicId: currentTopic.id,
        lesson: lessons.first,
      ),
    );
  }

  Future<void> _openSimulation(TopicModel currentTopic) async {
    final simulation = _getSimulationForTopic(currentTopic.id);

    if (simulation == null) {
      Get.snackbar(
        'Simulasi belum tersedia',
        'Simulasi untuk ${currentTopic.title} masih dalam pengembangan.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    await Get.toNamed(AppRoutes.simulation, arguments: simulation);
  }

  SimulationModel? _getSimulationForTopic(String topicId) {
    String? simulationId;

    switch (topicId) {
      case 'atomic_structure':
        simulationId = 'electron_configuration';
        break;

      case 'periodic_table':
        simulationId = 'periodic_table';
        break;

      case 'chemical_bonding':
        simulationId = null;
        break;
    }

    if (simulationId == null) {
      return null;
    }

    for (final simulation in LabSimulations.items) {
      if (simulation.id == simulationId) {
        return simulation;
      }
    }

    return null;
  }
}
