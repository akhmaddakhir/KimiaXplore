import '../models/topic_model.dart';

abstract final class HomeTopics {
  static const List<TopicModel> items = [
    TopicModel(
      id: 'atomic_structure',
      title: 'Struktur Atom',
      description: 'Kenali partikel kecil yang jadi dasar segalanya.',
      level: 'Dasar',
      totalLessons: 3,
    ),
    TopicModel(
      id: 'periodic_table',
      title: 'Sistem Periodik',
      description: 'Bukan sekadar tabel, setiap unsur punya ceritanya.',
      level: 'Dasar',
      totalLessons: 1,
    ),
    TopicModel(
      id: 'chemical_bonding',
      title: 'Ikatan Kimia',
      description: 'Cari tahu kenapa atom bisa saling terikat.',
      level: 'Dasar',
      totalLessons: 1,
    ),
  ];
}
