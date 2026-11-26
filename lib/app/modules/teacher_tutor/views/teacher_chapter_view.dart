import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_detail_header.dart';
import '../controllers/teacher_tutor_controller.dart';
import '../models/teacher_lesson_model.dart';
import 'teacher_video_detail_view.dart';

class TeacherChapterView extends StatefulWidget {
  final TeacherChapterModule module;

  const TeacherChapterView({super.key, required this.module});

  @override
  State<TeacherChapterView> createState() => _TeacherChapterViewState();
}

class _TeacherChapterViewState extends State<TeacherChapterView> {
  final TeacherTutorController _controller = Get.find<TeacherTutorController>();
  int _activeTab = 0; // 0 = Video Konsep, 1 = Pembahasan Soal

  @override
  Widget build(BuildContext context) {
    final conceptList = widget.module.conceptVideos;
    final practiceList = widget.module.practiceVideos;
    final items = _activeTab == 0 ? conceptList : practiceList;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppDetailHeader(
              title: widget.module.title,
              subtitle: '${widget.module.babLabel} • ${widget.module.teacherName}',
            ),
            // Segmented switcher sederhana: Video Konsep | Pembahasan Soal
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.sm,
              ),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border, width: 1.5),
                ),
                child: Row(
                  children: [
                    _SegmentButton(
                      label: 'Video Konsep (${conceptList.length})',
                      selected: _activeTab == 0,
                      onTap: () => setState(() => _activeTab = 0),
                    ),
                    _SegmentButton(
                      label: 'Pembahasan Soal (${practiceList.length})',
                      selected: _activeTab == 1,
                      onTap: () => setState(() => _activeTab = 1),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.xl),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final lesson = items[index];
                  return Obx(() {
                    final watched = _controller.isWatched(lesson.id);
                    return GestureDetector(
                      onTap: () => Get.to(
                        () => TeacherVideoDetailView(lesson: lesson),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.border,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: watched
                                    ? AppColors.green50
                                    : AppColors.blue50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                watched
                                    ? Icons.check_rounded
                                    : Icons.play_arrow_rounded,
                                color: watched
                                    ? AppColors.green700
                                    : AppColors.blue500,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (lesson.difficultyLabel != null) ...[
                                    Text(
                                      lesson.difficultyLabel!,
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.orange,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                  ],
                                  Text(
                                    '${index + 1}. ${lesson.title}',
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.textDark,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14.5,
                                      height: 1.25,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${lesson.duration} • ${lesson.teacherName}',
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.textMedium,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.textMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.blue500 : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.caption.copyWith(
              color: selected ? Colors.white : AppColors.textMedium,
              fontWeight: FontWeight.w800,
              fontSize: 12.5,
            ),
          ),
        ),
      ),
    );
  }
}
