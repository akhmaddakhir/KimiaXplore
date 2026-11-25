import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../routes/app_routes.dart';
import '../../../services/content_service.dart';
import '../../../services/learning_progress_service.dart';
import '../models/topic_model.dart';

enum StreakStatus { off, frozen, active }

class HomeController extends GetxController {
  final SupabaseClient _supabase = Supabase.instance.client;
  final LearningProgressService _progressService = LearningProgressService();
  final ContentService _contentService = ContentService();

  final studyProgress = 0.obs;
  final streakCount = 0.obs;
  final streakStatus = StreakStatus.off.obs;
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

      // 1. Fetch topics from Supabase (or fallback)
      final allTopics = await _contentService.getTopics();

      // 2. Fetch user progress records from database
      final userProgress = await _progressService.getUserProgress();

      // 3. Calculate progress for each topic
      for (final topic in allTopics) {
        final completedIds = await _progressService.getCompletedActivityIds(
          topicId: topic.id,
          activityType: 'material',
        );

        final lessons = await _contentService.getLessonsByTopic(topic.id);

        final completedCount = lessons
            .where((lesson) => completedIds.contains(lesson.id))
            .length;

        final totalCount = lessons.isNotEmpty ? lessons.length : 1;

        updatedTopics.add(
          topic.copyWith(
            totalLessons: totalCount,
            completedLessons:
                completedCount <= totalCount ? completedCount : totalCount,
          ),
        );
      }

      topics.assignAll(updatedTopics);
      _updateStudyProgress();

      // 4. Check database: Did this user ID ever try any topic?
      final hasRecords = userProgress.isNotEmpty;
      hasUserProgress.value = hasRecords;
      _updateStreakFromProgress(userProgress);

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
      recommendedTopic.value = topics.isNotEmpty ? topics.first : null;
    } finally {
      isLoadingProgress.value = false;
    }
  }

  void _updateStreakFromProgress(List<Map<String, dynamic>> progressRecords) {
    if (progressRecords.isEmpty) {
      streakCount.value = 0;
      streakStatus.value = StreakStatus.off;
      return;
    }

    final activeDays = <DateTime>{};
    for (final record in progressRecords) {
      final rawDate =
          record['last_opened_at']?.toString() ??
          record['updated_at']?.toString() ??
          record['created_at']?.toString();
      if (rawDate == null) continue;
      final parsed = DateTime.tryParse(rawDate)?.toLocal();
      if (parsed != null) {
        activeDays.add(DateTime(parsed.year, parsed.month, parsed.day));
      }
    }

    if (activeDays.isEmpty) {
      streakCount.value = 0;
      streakStatus.value = StreakStatus.off;
      return;
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (activeDays.contains(today)) {
      int count = 0;
      var cursor = today;
      while (activeDays.contains(cursor)) {
        count++;
        cursor = cursor.subtract(const Duration(days: 1));
      }
      streakCount.value = count;
      streakStatus.value = StreakStatus.active;
    } else if (activeDays.contains(yesterday)) {
      int count = 0;
      var cursor = yesterday;
      while (activeDays.contains(cursor)) {
        count++;
        cursor = cursor.subtract(const Duration(days: 1));
      }
      streakCount.value = count;
      streakStatus.value = StreakStatus.frozen;
    } else {
      streakCount.value = 0;
      streakStatus.value = StreakStatus.off;
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
