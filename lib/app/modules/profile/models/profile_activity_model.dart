import 'package:get/get.dart';

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
      return 'profile_status_score'.trParams({'score': '$score'});
    }

    if (isCompleted) {
      return 'profile_status_completed'.tr;
    }

    if (total > 0) {
      return '$progress/$total';
    }

    return 'profile_status_opened'.tr;
  }

  String get timeText {
    final date = lastOpenedAt;

    if (date == null) {
      return '';
    }

    final difference = DateTime.now().difference(date);

    if (difference.inMinutes < 1) {
      return 'time_just_now'.tr;
    }

    if (difference.inMinutes < 60) {
      return 'time_minutes_ago'.trParams({'m': '${difference.inMinutes}'});
    }

    if (difference.inHours < 24) {
      return 'time_hours_ago'.trParams({'h': '${difference.inHours}'});
    }

    if (difference.inDays == 1) {
      return 'time_yesterday'.tr;
    }

    if (difference.inDays < 7) {
      return 'time_days_ago'.trParams({'d': '${difference.inDays}'});
    }

    return '${date.day}/${date.month}/${date.year}';
  }
}
