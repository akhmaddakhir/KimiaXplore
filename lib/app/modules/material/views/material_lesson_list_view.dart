import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/learning_progress_service.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_detail_header.dart';
import '../../home/models/topic_model.dart';
import '../../topic/widgets/topic_activity_card.dart';
import '../data/material_lesson_data.dart';
import '../models/material_lesson_model.dart';

class MaterialLessonListView extends StatefulWidget {
  const MaterialLessonListView({super.key, required this.topic});

  final TopicModel topic;

  @override
  State<MaterialLessonListView> createState() => _MaterialLessonListViewState();
}

class _MaterialLessonListViewState extends State<MaterialLessonListView> {
  final LearningProgressService _progressService = LearningProgressService();

  Set<String> _completedLessonIds = {};

  bool _isLoadingProgress = true;

  List<MaterialLessonModel> get lessons =>
      MaterialLessonData.getLessonsByTopic(widget.topic.id);

  int get completedLessons {
    return lessons
        .where((lesson) => _completedLessonIds.contains(lesson.id))
        .length;
  }

  double get progressValue {
    if (lessons.isEmpty) {
      return 0;
    }

    return completedLessons / lessons.length;
  }

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    if (mounted) {
      setState(() {
        _isLoadingProgress = true;
      });
    }

    try {
      final completedIds = await _progressService.getCompletedActivityIds(
        topicId: widget.topic.id,
        activityType: 'material',
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _completedLessonIds = completedIds;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingProgress = false;
        });
      }
    }
  }

  Future<void> _openLesson(MaterialLessonModel lesson) async {
    await Get.toNamed(
      AppRoutes.material,
      arguments: MaterialLessonSelection(
        topicId: widget.topic.id,
        lesson: lesson,
      ),
    );

    await _loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDetailHeader(title: widget.topic.localizedTitle),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.sm,
                  AppSpacing.xl,
                  AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'material_lesson_list'.tr,
                      style: AppTypography.heading1.copyWith(
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'material_choose_lesson'.tr,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _ProgressSection(
                      completed: completedLessons,
                      total: lessons.length,
                      value: progressValue,
                      isLoading: _isLoadingProgress,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lessons.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: AppSpacing.md),
                      itemBuilder: (context, index) {
                        final lesson = lessons[index];

                        final isCompleted = _completedLessonIds.contains(
                          lesson.id,
                        );

                        return TopicActivityCard(
                          title: lesson.title,
                          subtitle:
                              '${'material_lesson_prefix'.tr} ${index + 1} · ${lesson.description}',
                          trailing: isCompleted
                              ? Container(
                                  width: 34,
                                  height: 34,
                                  decoration: const BoxDecoration(
                                    color: AppColors.green100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check_rounded,
                                    color: AppColors.green700,
                                    size: 22,
                                  ),
                                )
                              : const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: AppColors.textMedium,
                                  size: 20,
                                ),
                          onTap: () {
                            _openLesson(lesson);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressSection extends StatelessWidget {
  const _ProgressSection({
    required this.completed,
    required this.total,
    required this.value,
    required this.isLoading,
  });

  final int completed;
  final int total;
  final double value;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.green50,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.green100, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'topic_learning_progress'.tr,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (!isLoading)
                Text(
                  '$completed/$total',
                  style: AppTypography.body.copyWith(
                    color: AppColors.green700,
                    fontWeight: FontWeight.w800,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            isLoading
                ? 'material_loading_progress'.tr
                : 'material_progress_completed'.trParams({
                    'completed': '$completed',
                    'total': '$total',
                  }),
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textMedium,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: isLoading ? 0 : value,
              minHeight: 10,
              backgroundColor: AppColors.surface,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.green500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
