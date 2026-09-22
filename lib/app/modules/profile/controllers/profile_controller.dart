import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../home/data/home_topics.dart';
import '../../home/models/topic_model.dart';
import '../../quiz/controllers/quiz_controller.dart';
import '../../quiz/views/quiz_discussion_view.dart';
import '../models/quiz_history_model.dart';

enum UserTier { free, atom, catalyst, quantum }

class ProfileController extends GetxController {
  final userName = "AkhmadDaqiqulMu'akhkh".obs;
  final userTier = UserTier.free.obs;
  final completedTopics = 9.obs;
  final totalBadges = 12.obs;

  final quizHistories = <QuizHistoryModel>[
    QuizHistoryModel(
      id: 'h1',
      topicId: 'atomic_structure',
      title: 'Struktur Atom',
      totalQuestions: 3,
      correctAnswers: 2,
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    QuizHistoryModel(
      id: 'h2',
      topicId: 'periodic_table',
      title: 'Sistem Periodik',
      totalQuestions: 3,
      correctAnswers: 3,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    QuizHistoryModel(
      id: 'h3',
      topicId: 'chemical_bonding',
      title: 'Ikatan Kimia',
      totalQuestions: 3,
      correctAnswers: 1,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ].obs;

  String get userInitial {
    final name = userName.value.trim();
    if (name.isEmpty) return 'X';
    return name[0].toUpperCase();
  }

  String get roleName {
    switch (userTier.value) {
      case UserTier.atom:
        return 'Atom Xplorer';
      case UserTier.catalyst:
        return 'Catalyst Xplorer';
      case UserTier.quantum:
        return 'Quantum Xplorer';
      case UserTier.free:
        return 'Xplorer';
    }
  }

  Color get roleTextColor {
    switch (userTier.value) {
      case UserTier.quantum:
        return AppColors.darkOrange;
      case UserTier.catalyst:
        return AppColors.blue700;
      case UserTier.atom:
        return AppColors.darkTeal;
      case UserTier.free:
        return AppColors.textMedium;
    }
  }

  void openSettings() {
    // Aksi tombol pengaturan
  }

  void setTier(UserTier tier) {
    userTier.value = tier;
  }

  void openQuizDiscussion(QuizHistoryModel history) {
    // Pastikan QuizController terdaftar
    final quizController = Get.isRegistered<QuizController>()
        ? Get.find<QuizController>()
        : Get.put(QuizController());

    // Ambil topik terkait dari HomeTopics jika ada
    final topic =
        HomeTopics.items.firstWhereOrNull((t) => t.id == history.topicId) ??
        TopicModel(
          id: history.topicId,
          title: history.title,
          description: 'Evaluasi kuis',
          level: 'Dasar',
          totalLessons: 1,
        );

    quizController.topic.value = topic;
    quizController.loadQuestions();

    // Set jawaban simulasi sesuai jumlah benar dari history
    for (int i = 0; i < quizController.questions.length; i++) {
      final q = quizController.questions[i];
      if (i < history.correctAnswers) {
        quizController.selectedAnswers[i] = q.correctOptionIndex;
      } else {
        final wrongIndex = (q.correctOptionIndex + 1) % q.options.length;
        quizController.selectedAnswers[i] = wrongIndex;
      }
    }
    quizController.score.value = history.correctAnswers;
    quizController.isQuizFinished.value = true;

    Get.to<void>(() => const QuizDiscussionView());
  }
}
