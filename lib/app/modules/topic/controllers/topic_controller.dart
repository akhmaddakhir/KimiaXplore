import 'package:get/get.dart';

import '../../../models/activity_navigation.dart';
import '../../../routes/app_routes.dart';
import '../../../services/learning_progress_service.dart';
import '../../home/models/topic_model.dart';
import '../../material/data/material_lesson_data.dart';
import '../../material/models/material_lesson_model.dart';
import '../../material/views/material_lesson_list_view.dart';
import '../models/topic_activity_type.dart';

class TopicController extends GetxController {
  final LearningProgressService _progressService = LearningProgressService();

  final topic = Rxn<TopicModel>();
  final completedLessons = 0.obs;
  final totalLessons = 0.obs;
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

    loadProgress();
  }

  Future<void> loadProgress() async {
    final currentTopic = topic.value;

    if (currentTopic == null) {
      return;
    }

    isLoadingProgress.value = true;

    try {
      final completedIds = await _progressService.getCompletedActivityIds(
        topicId: currentTopic.id,
        activityType: 'material',
      );

      final lessons = MaterialLessonData.getLessonsByTopic(currentTopic.id);

      totalLessons.value = lessons.length;

      completedLessons.value = lessons
          .where((lesson) => completedIds.contains(lesson.id))
          .length;
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
        break;

      case TopicActivityType.flashcard:
        await Get.toNamed(AppRoutes.flashcard, arguments: navigation);
        break;

      default:
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
}
