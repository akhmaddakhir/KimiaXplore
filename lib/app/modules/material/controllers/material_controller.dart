import 'package:get/get.dart';

import '../../home/data/home_topics.dart';
import '../../home/models/topic_model.dart';
import '../data/material_data.dart';
import '../data/material_lesson_data.dart';
import '../models/material_lesson_model.dart';
import '../models/material_model.dart';

class MaterialController extends GetxController {
  final topic = Rxn<TopicModel>();
  final material = Rxn<MaterialModel>();
  final selectedLesson = Rxn<MaterialLessonModel>();

  final currentLessonIndex = 0.obs;

  final lessons = <MaterialLessonModel>[].obs;

  int get totalLessons => lessons.length;

  bool get hasNextLesson => currentLessonIndex.value < totalLessons - 1;

  bool get isLastLesson =>
      totalLessons > 0 && currentLessonIndex.value == totalLessons - 1;

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;

    if (arguments is MaterialLessonSelection) {
      _initializeLesson(arguments);
      return;
    }

    if (arguments is TopicModel) {
      _initializeTopic(arguments);
    }
  }

  void _initializeLesson(MaterialLessonSelection selection) {
    if (selection.topicId != selection.lesson.topicId) {
      return;
    }

    TopicModel? selectedTopic;

    for (final item in HomeTopics.items) {
      if (item.id == selection.topicId) {
        selectedTopic = item;
        break;
      }
    }

    if (selectedTopic == null) {
      return;
    }

    topic.value = selectedTopic;

    lessons.assignAll(MaterialLessonData.getLessonsByTopic(selectedTopic.id));

    final lessonIndex = lessons.indexWhere(
      (lesson) => lesson.id == selection.lesson.id,
    );

    if (lessonIndex == -1) {
      return;
    }

    _selectLesson(lessonIndex);
  }

  void _initializeTopic(TopicModel selectedTopic) {
    topic.value = selectedTopic;

    lessons.assignAll(MaterialLessonData.getLessonsByTopic(selectedTopic.id));

    if (lessons.isEmpty) {
      material.value = MaterialData.findByTopicId(selectedTopic.id);
      return;
    }

    _selectLesson(0);
  }

  void _selectLesson(int index) {
    final currentTopic = topic.value;

    if (currentTopic == null) return;

    if (index < 0 || index >= lessons.length) {
      return;
    }

    final topicMaterial = MaterialData.findByTopicId(currentTopic.id);

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

    if (selectedSections.isEmpty) {
      return;
    }

    currentLessonIndex.value = index;

    selectedLesson.value = lesson;

    material.value = MaterialModel(
      topicId: currentTopic.id,
      sections: selectedSections,
    );
  }

  void nextLesson() {
    if (!hasNextLesson) {
      return;
    }

    _selectLesson(currentLessonIndex.value + 1);
  }

  void finishMaterial() {
    Get.back();
  }
}
