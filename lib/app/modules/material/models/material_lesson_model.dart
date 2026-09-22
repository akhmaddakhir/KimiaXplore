class MaterialLessonModel {
  final String id;
  final String topicId;
  final String title;
  final String description;
  final List<int> sectionIndexes;

  const MaterialLessonModel({
    required this.id,
    required this.topicId,
    required this.title,
    required this.description,
    required this.sectionIndexes,
  });
}

class MaterialLessonSelection {
  final String topicId;
  final MaterialLessonModel lesson;

  const MaterialLessonSelection({required this.topicId, required this.lesson});
}
