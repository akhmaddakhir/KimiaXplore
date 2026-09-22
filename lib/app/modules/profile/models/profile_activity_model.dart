class ProfileActivityModel {
  final String id;
  final String topicId;
  final String topicTitle;
  final String activityType;
  final String activityTitle;
  final bool isCompleted;
  final int progress;
  final int total;
  final int? score;
  final DateTime? lastOpenedAt;

  const ProfileActivityModel({
    required this.id,
    required this.topicId,
    required this.topicTitle,
    required this.activityType,
    required this.activityTitle,
    required this.isCompleted,
    required this.progress,
    required this.total,
    required this.score,
    required this.lastOpenedAt,
  });

  String get statusText {
    if (activityType == 'quiz' && score != null && isCompleted) {
      return 'Skor $score%';
    }

    if (isCompleted) {
      return 'Selesai';
    }

    if (total > 0) {
      return '$progress/$total';
    }

    return 'Dibuka';
  }

  String get timeText {
    final date = lastOpenedAt;

    if (date == null) {
      return '';
    }

    final difference = DateTime.now().difference(date);

    if (difference.inMinutes < 1) {
      return 'Baru saja';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    }

    if (difference.inDays == 1) {
      return 'Kemarin';
    }

    if (difference.inDays < 7) {
      return '${difference.inDays} hari lalu';
    }

    return '${date.day}/${date.month}/${date.year}';
  }
}
