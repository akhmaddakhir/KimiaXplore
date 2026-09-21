class MaterialSection {
  final String title;
  final List<String> paragraphs;

  const MaterialSection({required this.title, required this.paragraphs});
}

class MaterialModel {
  final String topicId;
  final List<MaterialSection> sections;

  const MaterialModel({required this.topicId, required this.sections});
}
