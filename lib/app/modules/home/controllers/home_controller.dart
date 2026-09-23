import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../routes/app_routes.dart';
import '../../../services/learning_progress_service.dart';
import '../../material/data/material_lesson_data.dart';
import '../data/home_topics.dart';
import '../models/topic_model.dart';

class HomeController extends GetxController {
  final SupabaseClient _supabase = Supabase.instance.client;
  final LearningProgressService _progressService = LearningProgressService();

  final studyProgress = 0.obs;
  final topics = <TopicModel>[].obs;
  final recommendedTopic = Rxn<TopicModel>();
  final hasUserProgress = false.obs;
  final isLoadingProgress = false.obs;
  final userName = 'Xplorer'.obs;

  @override
  void onInit() {
    super.onInit();
    loadUser();
    loadHomeData();
  }

  void loadUser() {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      userName.value = 'Xplorer';
      return;
    }

    final metadata = user.userMetadata ?? {};
    final fullName = metadata['full_name']?.toString().trim();
    final name = metadata['name']?.toString().trim();

    final preferredName = fullName?.isNotEmpty == true
        ? fullName
        : name?.isNotEmpty == true
        ? name
        : null;

    if (preferredName != null) {
      userName.value = preferredName;
    } else if (user.email != null && user.email!.contains('@')) {
      userName.value = user.email!.split('@').first;
    } else {
      userName.value = 'Xplorer';
    }
  }

  Future<void> loadHomeData() async {
    isLoadingProgress.value = true;

    try {
      loadUser();

      final updatedTopics = <TopicModel>[];

      // 1. Fetch user progress records from database
      final userProgress = await _progressService.getUserProgress();

      // 2. Calculate progress for each topic
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

      // 3. Check database: Did this user ID ever try any topic?
      final hasRecords = userProgress.isNotEmpty;
      hasUserProgress.value = hasRecords;

      if (!hasRecords) {
        // User has NEVER tried any topic -> show pure recommendation
        recommendedTopic.value = topics.isNotEmpty ? topics.first : null;
      } else {
        // User HAS tried a topic -> resume the most recently opened topic
        TopicModel? lastTopic;
        for (final record in userProgress) {
          final recordTopicId = record['topic_id']?.toString();
          final match = topics.firstWhereOrNull((t) => t.id == recordTopicId);
          if (match != null) {
            lastTopic = match;
            break;
          }
        }

        recommendedTopic.value =
            lastTopic ?? (topics.isNotEmpty ? topics.first : null);
      }
    } catch (e) {
      debugPrint('Error loading home data: $e');
      hasUserProgress.value = false;
      if (topics.isEmpty) {
        topics.assignAll(HomeTopics.items);
      }
      recommendedTopic.value = topics.isNotEmpty ? topics.first : null;
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
