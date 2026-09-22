import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_detail_header.dart';
import '../../home/models/topic_model.dart';
import '../../topic/widgets/topic_activity_card.dart';
import '../data/material_lesson_data.dart';
import '../models/material_lesson_model.dart';

class MaterialLessonListView extends StatelessWidget {
  const MaterialLessonListView({super.key, required this.topic});

  final TopicModel topic;

  void _openLesson(MaterialLessonModel lesson) {
    Get.toNamed(
      AppRoutes.material,
      arguments: MaterialLessonSelection(topicId: topic.id, lesson: lesson),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lessons = MaterialLessonData.getLessonsByTopic(topic.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDetailHeader(title: topic.title),
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
                      'Daftar Pelajaran',
                      style: AppTypography.heading1.copyWith(
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Pilih pelajaran yang ingin kamu pelajari.',
                      style: AppTypography.body.copyWith(
                        color: AppColors.textMedium,
                      ),
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

                        return TopicActivityCard(
                          title: lesson.title,
                          subtitle:
                              'Pelajaran ${index + 1} · ${lesson.description}',
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
