import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../theme/app_colors.dart';
import '../../home/data/home_topics.dart';
import '../../home/models/topic_model.dart';
import '../../quiz/controllers/quiz_controller.dart';
import '../../quiz/views/quiz_discussion_view.dart';
import '../models/quiz_history_model.dart';

enum UserTier { free, atom, catalyst, quantum }

class ProfileController extends GetxController {
  final SupabaseClient _supabase = Supabase.instance.client;

  final userName = 'Xplorer'.obs;
  final userEmail = ''.obs;
  final avatarUrl = RxnString();

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

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  void loadUser() {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      userName.value = 'Xplorer';
      userEmail.value = '';
      avatarUrl.value = null;
      return;
    }

    userEmail.value = user.email ?? '';

    final metadata = user.userMetadata ?? {};

    final fullName = metadata['full_name']?.toString().trim();

    final name = metadata['name']?.toString().trim();

    final preferredName = fullName?.isNotEmpty == true
        ? fullName
        : name?.isNotEmpty == true
        ? name
        : null;

    if (preferredName != null) {
      userName.value = preferredName;
    } else if (user.email != null && user.email!.contains('@')) {
      userName.value = user.email!.split('@').first;
    } else {
      userName.value = 'Xplorer';
    }

    final googleAvatar = metadata['avatar_url']?.toString().trim();

    final picture = metadata['picture']?.toString().trim();

    if (googleAvatar?.isNotEmpty == true) {
      avatarUrl.value = googleAvatar;
    } else if (picture?.isNotEmpty == true) {
      avatarUrl.value = picture;
    } else {
      avatarUrl.value = null;
    }
  }

  String get userInitial {
    final name = userName.value.trim();

    if (name.isEmpty) {
      return 'X';
    }

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

  void setTier(UserTier tier) {
    userTier.value = tier;
  }

  void openQuizDiscussion(QuizHistoryModel history) {
    final quizController = Get.isRegistered<QuizController>()
        ? Get.find<QuizController>()
        : Get.put(QuizController());

    final topic =
        HomeTopics.items.firstWhereOrNull(
          (topic) => topic.id == history.topicId,
        ) ??
        TopicModel(
          id: history.topicId,
          title: history.title,
          description: 'Evaluasi kuis',
          level: 'Dasar',
          totalLessons: 1,
        );

    quizController.topic.value = topic;
    quizController.loadQuestions();

    for (int i = 0; i < quizController.questions.length; i++) {
      final question = quizController.questions[i];

      if (i < history.correctAnswers) {
        quizController.selectedAnswers[i] = question.correctOptionIndex;
      } else {
        final wrongIndex =
            (question.correctOptionIndex + 1) % question.options.length;

        quizController.selectedAnswers[i] = wrongIndex;
      }
    }

    quizController.score.value = history.correctAnswers;

    quizController.isQuizFinished.value = true;

    Get.to<void>(() => const QuizDiscussionView());
  }
}
