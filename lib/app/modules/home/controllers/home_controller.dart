import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/learning_progress_service.dart';
import '../../material/data/material_lesson_data.dart';
import '../data/home_topics.dart';
import '../models/topic_model.dart';

class HomeController extends GetxController {
  final LearningProgressService _progressService = LearningProgressService();

  final studyProgress = 0.obs;
  final topics = <TopicModel>[].obs;
  final recommendedTopic = Rxn<TopicModel>();
  final isLoadingProgress = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    isLoadingProgress.value = true;

    try {
      final updatedTopics = <TopicModel>[];

      for (final topic in HomeTopics.items) {
        final completedIds = await _progressService.getCompletedActivityIds(
          topicId: topic.id,
          activityType: 'material',
        );

        final lessons = MaterialLessonData.getLessonsByTopic(topic.id);

        final completedCount = lessons
            .where((lesson) => completedIds.contains(lesson.id))
            .length;

        updatedTopics.add(
          topic.copyWith(
            totalLessons: lessons.length,
            completedLessons: completedCount,
          ),
        );
      }

      topics.assignAll(updatedTopics);

      _updateStudyProgress();
      await _loadRecommendedTopic();
    } finally {
      isLoadingProgress.value = false;
    }
  }

  void _updateStudyProgress() {
    var completed = 0;

    for (final topic in topics) {
      completed += topic.completedLessons;
    }

    studyProgress.value = completed;
  }

  Future<void> _loadRecommendedTopic() async {
    final lastActivity = await _progressService.getLastActivity();

    if (lastActivity == null) {
      recommendedTopic.value = topics.isNotEmpty ? topics.first : null;
      return;
    }

    final topicId = lastActivity['topic_id'] as String?;

    if (topicId == null) {
      recommendedTopic.value = topics.isNotEmpty ? topics.first : null;
      return;
    }

    TopicModel? selectedTopic;

    for (final topic in topics) {
      if (topic.id == topicId) {
        selectedTopic = topic;
        break;
      }
    }

    recommendedTopic.value =
        selectedTopic ?? (topics.isNotEmpty ? topics.first : null);
  }

  Future<void> onTopicSelected(TopicModel topic) async {
    await Get.toNamed(AppRoutes.topic, arguments: topic);

    await loadHomeData();
  }

  Future<void> onRecommendedTopicPressed() async {
    final topic = recommendedTopic.value;

    if (topic == null) {
      return;
    }

    await onTopicSelected(topic);
  }
}
