import '../models/topic_model.dart';

abstract final class HomeTopics {
  static const List<TopicModel> items = [
    TopicModel(
      id: 'struktur_atom',
      title: 'Struktur Atom',
      level: 'Dasar',
      totalLessons: 3,
      imageAsset: null,
    ),
    TopicModel(
      id: 'sistem_periodik',
      title: 'Sistem Periodik',
      level: 'Dasar',
      totalLessons: 1,
      imageAsset: null,
    ),
    TopicModel(
      id: 'ikatan_kimia',
      title: 'Ikatan Kimia',
      level: 'Dasar',
      totalLessons: 1,
      imageAsset: null,
    ),
  ];
}
