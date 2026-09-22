import '../modules/home/models/topic_model.dart';

enum ActivityEntryPoint { recommendation, activity }

class ActivityNavigation {
  final TopicModel topic;
  final ActivityEntryPoint entryPoint;

  const ActivityNavigation({required this.topic, required this.entryPoint});

  bool get isRecommended => entryPoint == ActivityEntryPoint.recommendation;

  bool get isDirectActivity => entryPoint == ActivityEntryPoint.activity;

  ActivityNavigation copyWith({
    TopicModel? topic,
    ActivityEntryPoint? entryPoint,
  }) {
    return ActivityNavigation(
      topic: topic ?? this.topic,
      entryPoint: entryPoint ?? this.entryPoint,
    );
  }
}
