import 'package:get/get.dart';

import '../../../models/activity_navigation.dart';
import '../../../routes/app_routes.dart';
import '../../../services/content_service.dart';
import '../../../services/learning_progress_service.dart';
import '../../home/models/topic_model.dart';
import '../models/material_lesson_model.dart';
import '../models/material_model.dart';

class MaterialController extends GetxController {
  final LearningProgressService _progressService = LearningProgressService();
  final ContentService _contentService = ContentService();

  final topic = Rxn<TopicModel>();
  final material = Rxn<MaterialModel>();
  final selectedLesson = Rxn<MaterialLessonModel>();

  final currentLessonIndex = 0.obs;
  final isSavingProgress = false.obs;

  final lessons = <MaterialLessonModel>[].obs;

  ActivityEntryPoint entryPoint = ActivityEntryPoint.activity;

  int get totalLessons => lessons.length;

  bool get isRecommended => entryPoint == ActivityEntryPoint.recommendation;

  bool get hasNextLesson => currentLessonIndex.value < totalLessons - 1;

  bool get isLastLesson =>
      totalLessons > 0 && currentLessonIndex.value == totalLessons - 1;

  bool get canContinueLesson => isRecommended && hasNextLesson;

  String get bottomButtonLabel {
    if (canContinueLesson) {
      return 'material_next_lesson'.tr;
    }

    if (isRecommended) {
      return 'material_continue_to_quiz'.tr;
    }

    return 'material_complete'.tr;
  }

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;

    if (arguments is ActivityNavigation) {
      entryPoint = arguments.entryPoint;
      _initializeTopic(arguments.topic);
      return;
    }

    if (arguments is MaterialLessonSelection) {
      _initializeLesson(arguments);
      return;
    }

    if (arguments is TopicModel) {
      _initializeTopic(arguments);
    }
  }

  Future<void> _initializeLesson(MaterialLessonSelection selection) async {
    final allTopics = await _contentService.getTopics();
    final matchedTopic = allTopics.firstWhereOrNull(
      (item) => item.id == selection.topicId,
    );

    topic.value = matchedTopic ??
        TopicModel(
          id: selection.topicId,
          title: selection.lesson.title,
          description: selection.lesson.description,
          level: 'Dasar',
          totalLessons: 1,
        );

    final fetchedLessons =
        await _contentService.getLessonsByTopic(selection.topicId);
    lessons.assignAll(fetchedLessons);

    final lessonIndex = lessons.indexWhere(
      (lesson) => lesson.id == selection.lesson.id,
    );

    await _selectLesson(lessonIndex != -1 ? lessonIndex : 0);
  }

  Future<void> _initializeTopic(TopicModel selectedTopic) async {
    topic.value = selectedTopic;

    final fetchedLessons =
        await _contentService.getLessonsByTopic(selectedTopic.id);
    lessons.assignAll(fetchedLessons);

    if (lessons.isEmpty) {
      material.value = await _contentService.getMaterial(selectedTopic.id);
      return;
    }

    await _selectLesson(0);
  }

  Future<void> _selectLesson(int index) async {
    final currentTopic = topic.value;

    if (currentTopic == null) {
      return;
    }

    if (index < 0 || index >= lessons.length) {
      return;
    }

    final topicMaterial = await _contentService.getMaterial(currentTopic.id);

    if (topicMaterial == null) {
      return;
    }

    final lesson = lessons[index];

    final selectedSections = <MaterialSection>[];

    for (final sectionIndex in lesson.sectionIndexes) {
      if (sectionIndex >= 0 && sectionIndex < topicMaterial.sections.length) {
        selectedSections.add(topicMaterial.sections[sectionIndex]);
      }
    }

    if (selectedSections.isEmpty && topicMaterial.sections.isNotEmpty) {
      selectedSections.addAll(topicMaterial.sections);
    }

    if (selectedSections.isEmpty) {
      return;
    }

    currentLessonIndex.value = index;

    selectedLesson.value = lesson;

    material.value = MaterialModel(
      topicId: currentTopic.id,
      sections: selectedSections,
    );

    _markCurrentLessonOpened();
  }

  Future<void> _markCurrentLessonOpened() async {
    final currentTopic = topic.value;
    final currentLesson = selectedLesson.value;

    if (currentTopic == null || currentLesson == null) {
      return;
    }

    try {
      await _progressService.markActivityOpened(
        topicId: currentTopic.id,
        activityType: 'material',
        activityId: currentLesson.id,
      );
    } catch (_) {}
  }

  Future<void> _completeCurrentLesson() async {
    final currentTopic = topic.value;
    final currentLesson = selectedLesson.value;

    if (currentTopic == null || currentLesson == null) {
      return;
    }

    await _progressService.completeActivity(
      topicId: currentTopic.id,
      activityType: 'material',
      activityId: currentLesson.id,
      progress: 1,
      total: 1,
    );
  }

  Future<void> nextLesson() async {
    if (!canContinueLesson) {
      return;
    }

    await _selectLesson(currentLessonIndex.value + 1);
  }

  Future<void> finishMaterial() async {
    if (isSavingProgress.value) {
      return;
    }

    final currentTopic = topic.value;

    if (currentTopic == null) {
      Get.back();
      return;
    }

    isSavingProgress.value = true;

    try {
      await _completeCurrentLesson();

      if (!isRecommended) {
        Get.back();
        return;
      }

      if (hasNextLesson) {
        await nextLesson();
        return;
      }

      Get.offNamed(
        AppRoutes.quiz,
        arguments: ActivityNavigation(
          topic: currentTopic,
          entryPoint: ActivityEntryPoint.recommendation,
        ),
      );
    } finally {
      isSavingProgress.value = false;
    }
  }
}
