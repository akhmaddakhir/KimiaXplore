import '../models/material_lesson_model.dart';
import 'material_data.dart';

abstract final class MaterialLessonData {
  static const Map<String, List<MaterialLessonModel>> lessonsByTopic = {
    'atomic_structure': [
      MaterialLessonModel(
        id: 'atomic_structure_l1',
        topicId: 'atomic_structure',
        title: 'Mengenal Atom',
        description: 'Kenali atom, partikel penyusunnya, dan struktur atom.',
        sectionIndexes: [0, 1, 2],
      ),
      MaterialLessonModel(
        id: 'atomic_structure_l2',
        topicId: 'atomic_structure',
        title: 'Nomor Atom, Massa, dan Ion',
        description: 'Pelajari nomor atom, nomor massa, dan pembentukan ion.',
        sectionIndexes: [3, 4],
      ),
      MaterialLessonModel(
        id: 'atomic_structure_l3',
        topicId: 'atomic_structure',
        title: 'Isotop dan Kesimpulan',
        description: 'Pahami isotop dan rangkum konsep dasar struktur atom.',
        sectionIndexes: [5, 6],
      ),
    ],
  };

  static List<MaterialLessonModel> getLessonsByTopic(String topicId) {
    final material = MaterialData.findByTopicId(topicId);

    if (material == null || material.sections.isEmpty) {
      return [];
    }

    final registeredLessons = lessonsByTopic[topicId];

    if (registeredLessons != null && registeredLessons.isNotEmpty) {
      return registeredLessons;
    }

    return [
      MaterialLessonModel(
        id: '${topicId}_l1',
        topicId: topicId,
        title: 'Materi',
        description: 'Pelajari materi topik ini.',
        sectionIndexes: List.generate(
          material.sections.length,
          (index) => index,
        ),
      ),
    ];
  }
}
