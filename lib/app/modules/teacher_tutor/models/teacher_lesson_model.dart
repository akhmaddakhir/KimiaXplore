import 'package:flutter/material.dart';

class TeacherVideoChapter {
  final String timestamp;
  final String title;
  final int seconds;

  const TeacherVideoChapter({
    required this.timestamp,
    required this.title,
    required this.seconds,
  });
}

class TeacherMiniQuiz {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const TeacherMiniQuiz({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class TeacherLessonModel {
  final String id;
  final String title;
  final String teacherName;
  final String teacherRole;
  final String teacherAvatar;
  final String category;
  final String duration;
  final int durationSeconds;
  final bool isPracticeVideo;
  final String? difficultyLabel;
  final List<String> summaryPoints;
  final String formulaHighlight;
  final List<TeacherVideoChapter> chapters;
  final TeacherMiniQuiz miniQuiz;

  const TeacherLessonModel({
    required this.id,
    required this.title,
    required this.teacherName,
    required this.teacherRole,
    required this.teacherAvatar,
    required this.category,
    required this.duration,
    required this.durationSeconds,
    this.isPracticeVideo = false,
    this.difficultyLabel,
    required this.summaryPoints,
    required this.formulaHighlight,
    required this.chapters,
    required this.miniQuiz,
  });
}

class TeacherChapterModule {
  final String id;
  final String babLabel;
  final String title;
  final String teacherName;
  final IconData icon;
  final List<TeacherLessonModel> lessons;

  const TeacherChapterModule({
    required this.id,
    required this.babLabel,
    required this.title,
    required this.teacherName,
    required this.icon,
    required this.lessons,
  });

  List<TeacherLessonModel> get conceptVideos =>
      lessons.where((e) => !e.isPracticeVideo).toList();

  List<TeacherLessonModel> get practiceVideos =>
      lessons.where((e) => e.isPracticeVideo).toList();
}

class TeacherLiveClass {
  final String id;
  final String title;
  final String scheduleLabel;
  final String teacherName;
  final String teacherAvatar;
  final String durationLabel;

  const TeacherLiveClass({
    required this.id,
    required this.title,
    required this.scheduleLabel,
    required this.teacherName,
    required this.teacherAvatar,
    required this.durationLabel,
  });
}
