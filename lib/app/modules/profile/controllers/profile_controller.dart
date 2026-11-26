import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../services/content_service.dart';
import '../../../services/learning_progress_service.dart';
import '../../../theme/app_colors.dart';
import '../../home/models/topic_model.dart';
import '../models/profile_activity_model.dart';

enum UserTier { free, atom, catalyst, quantum }

class ProfileController extends GetxController {
  final SupabaseClient _supabase = Supabase.instance.client;
  final LearningProgressService _progressService = LearningProgressService();
  final ContentService _contentService = ContentService();

  final userName = 'Xplorer'.obs;
  final userEmail = ''.obs;
  final avatarUrl = RxnString();

  final selectedAvatarAsset = 'assets/images/profile_avatar_scientist.svg'.obs;
  final selectedAvatarBg = AppColors.avatarBackgrounds[1].obs;

  static const List<({String label, String asset})> avatarOptions = [
    (label: 'Profesor', asset: 'assets/images/profile_avatar_scientist.svg'),
    (label: 'Guru Kimia', asset: 'assets/images/profile_avatar_teacher.svg'),
    (label: 'Mas Mas', asset: 'assets/images/profile_avatar_man.svg'),
    (label: 'Mbak Mbak', asset: 'assets/images/profile_avatar_woman.svg'),
    (label: 'Suhu Kimia', asset: 'assets/images/profile_avatar_grandpa.svg'),
  ];

  void updateAvatarAppearance({
    required String assetPath,
    required Color backgroundColor,
  }) {
    selectedAvatarAsset.value = assetPath;
    selectedAvatarBg.value = backgroundColor;
  }

  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  final isSavingProfile = false.obs;
  final isLoadingProfile = false.obs;

  final userTier = UserTier.free.obs;

  final completedTopics = 0.obs;
  final totalBadges = 0.obs;

  final activities = <ProfileActivityModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    loadUser();
    loadUserProfileFromDb();
    loadProfileProgress();
  }

  Future<void> loadUserProfileFromDb() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    try {
      final doc = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (doc != null) {
        final dbName = doc['name']?.toString().trim();
        if (dbName != null && dbName.isNotEmpty) {
          userName.value = dbName;
          usernameController.text = dbName;
        }

        final status = doc['status']?.toString();
        final tier = doc['subscription_tier']?.toString().toLowerCase() ?? '';

        if (status == 'premium' || tier.isNotEmpty) {
          if (tier.contains('quantum')) {
            userTier.value = UserTier.quantum;
          } else if (tier.contains('catalyst')) {
            userTier.value = UserTier.catalyst;
          } else {
            userTier.value = UserTier.atom;
          }
        } else {
          userTier.value = UserTier.free;
        }
      }
    } catch (e) {
      debugPrint('Error loading user profile from db: $e');
    }
  }

  void loadUser() {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      userName.value = 'Xplorer';
      userEmail.value = '';
      avatarUrl.value = null;

      usernameController.text = 'Xplorer';
      emailController.text = '';

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

    usernameController.text = userName.value;
    emailController.text = userEmail.value;

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

  Future<void> loadProfileProgress() async {
    if (isLoadingProfile.value) {
      return;
    }

    try {
      isLoadingProfile.value = true;

      final progress = await _progressService.getUserProgress();
      final topics = await _contentService.getTopics();

      await _calculateCompletedTopics(progress, topics);
      await _buildActivities(progress, topics);

      totalBadges.value = 0;
    } catch (_) {
      completedTopics.value = 0;
      activities.clear();
      totalBadges.value = 0;
    } finally {
      isLoadingProfile.value = false;
    }
  }

  Future<void> _calculateCompletedTopics(
    List<Map<String, dynamic>> progress,
    List<TopicModel> topics,
  ) async {
    var totalCompleted = 0;

    for (final topic in topics) {
      final topicProgress = progress.where((item) {
        return item['topic_id'] == topic.id;
      }).toList();

      final lessons = await _contentService.getLessonsByTopic(topic.id);

      final completedMaterialIds = topicProgress
          .where((item) {
            return item['activity_type'] == 'material' &&
                item['is_completed'] == true;
          })
          .map((item) {
            return item['activity_id']?.toString() ?? '';
          })
          .toSet();

      final allMaterialsCompleted =
          lessons.isNotEmpty &&
          lessons.every((lesson) {
            return completedMaterialIds.contains(lesson.id);
          });

      final quizCompleted = topicProgress.any((item) {
        return item['activity_type'] == 'quiz' &&
            item['is_completed'] == true;
      });

      final flashcardCompleted = topicProgress.any((item) {
        return item['activity_type'] == 'flashcard' &&
            item['is_completed'] == true;
      });

      if (allMaterialsCompleted && quizCompleted && flashcardCompleted) {
        totalCompleted++;
      }
    }

    completedTopics.value = totalCompleted;
  }

  Future<void> _buildActivities(
    List<Map<String, dynamic>> progress,
    List<TopicModel> topics,
  ) async {
    final result = <ProfileActivityModel>[];

    for (final item in progress.take(5)) {
      final topicId = item['topic_id']?.toString() ?? '';

      final topic = topics.firstWhereOrNull(
        (t) => t.id == topicId,
      );

      final topicTitle = topic?.title ?? topicId;
      final activityType = item['activity_type']?.toString() ?? '';
      final activityId = item['activity_id']?.toString() ?? '';

      result.add(
        ProfileActivityModel(
          id: item['id']?.toString() ?? activityId,
          topicId: topicId,
          topicTitle: topicTitle,
          activityType: activityType,
          activityTitle: _getActivityTitle(
            topicId: topicId,
            activityType: activityType,
            activityId: activityId,
          ),
          isCompleted: item['is_completed'] == true,
          progress: _toInt(item['progress']),
          total: _toInt(item['total']),
          score: item['score'] == null ? null : _toInt(item['score']),
          lastOpenedAt: DateTime.tryParse(
            item['last_opened_at']?.toString() ?? '',
          )?.toLocal(),
        ),
      );
    }

    activities.assignAll(result);
  }

  String _getActivityTitle({
    required String topicId,
    required String activityType,
    required String activityId,
  }) {
    switch (activityType) {
      case 'material':
        return 'Materi Pembelajaran';

      case 'quiz':
        return 'Kuis Pemahaman';

      case 'flashcard':
        return 'Flashcard Hafalan';

      case 'simulation':
        return 'Simulasi Laboratorium';

      default:
        return 'Aktivitas';
    }
  }

  int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  Future<void> updateUsername() async {
    if (isSavingProfile.value) {
      return;
    }

    final username = usernameController.text.trim();

    if (username.isEmpty) {
      Get.snackbar(
        'profile_username_empty_title'.tr,
        'profile_username_empty_desc'.tr,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );

      return;
    }

    if (username.length < 3) {
      Get.snackbar(
        'profile_username_short_title'.tr,
        'profile_username_short_desc'.tr,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );

      return;
    }

    if (username == userName.value) {
      Get.snackbar(
        'profile_no_changes_title'.tr,
        'profile_no_changes_desc'.tr,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );

      return;
    }

    try {
      isSavingProfile.value = true;

      final response = await _supabase.auth.updateUser(
        UserAttributes(data: {'full_name': username, 'name': username}),
      );

      if (response.user == null) {
        throw Exception();
      }

      await _supabase.from('profiles').upsert({
        'id': response.user!.id,
        'email': response.user!.email,
        'name': username,
        'updated_at': DateTime.now().toIso8601String(),
      });

      userName.value = username;
      usernameController.text = username;

      Get.snackbar(
        'profile_update_success_title'.tr,
        'profile_update_success_desc'.tr,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } catch (_) {
      Get.snackbar(
        'profile_update_failed_title'.tr,
        'profile_update_failed_desc'.tr,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isSavingProfile.value = false;
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

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();

    super.onClose();
  }
}
