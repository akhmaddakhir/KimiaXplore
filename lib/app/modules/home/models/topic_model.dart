class TopicModel {
  final String id;
  final String title;
  final String description;
  final String level;
  final int totalLessons;
  final int completedLessons;
  final String? imageAsset;

  const TopicModel({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.totalLessons,
    this.completedLessons = 0,
    this.imageAsset,
  }) : assert(totalLessons > 0, 'Total pelajaran harus lebih dari 0'),
       assert(
         completedLessons >= 0 && completedLessons <= totalLessons,
         'Jumlah pelajaran selesai tidak valid',
       );

  String get subtitle {
    if (completedLessons > 0) {
      return '$level • $completedLessons/$totalLessons pelajaran';
    }

    return '$level • $totalLessons pelajaran';
  }

  double get progress => completedLessons / totalLessons;

  bool get isCompleted => completedLessons == totalLessons;

  TopicModel copyWith({
    String? id,
    String? title,
    String? description,
    String? level,
    int? totalLessons,
    int? completedLessons,
    String? imageAsset,
    bool clearImageAsset = false,
  }) {
    return TopicModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      level: level ?? this.level,
      totalLessons: totalLessons ?? this.totalLessons,
      completedLessons: completedLessons ?? this.completedLessons,
      imageAsset: clearImageAsset ? null : (imageAsset ?? this.imageAsset),
    );
  }
}
