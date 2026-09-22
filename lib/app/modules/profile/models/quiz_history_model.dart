class QuizHistoryModel {
  final String id;
  final String topicId;
  final String title;
  final int totalQuestions;
  final int correctAnswers;
  final DateTime date;

  const QuizHistoryModel({
    required this.id,
    required this.topicId,
    required this.title,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.date,
  });

  double get accuracy {
    if (totalQuestions <= 0) return 0.0;
    return (correctAnswers / totalQuestions) * 100;
  }

  /// Jika betul lebih banyak (>= 50%) maka benar/positif
  bool get isMajorityCorrect => accuracy >= 50.0;

  String get accuracyText => '${accuracy.toStringAsFixed(1)}%';
}
