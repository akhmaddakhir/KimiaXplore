import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../controllers/teacher_tutor_controller.dart';
import '../models/teacher_lesson_model.dart';
import 'teacher_chapter_view.dart';
import 'teacher_video_detail_view.dart';

class TeacherTutorView extends GetView<TeacherTutorController> {
  const TeacherTutorView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<TeacherTutorController>()) {
      Get.put(TeacherTutorController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              // 1. Header Biru ala Ruangguru (Back + Search, Judul, Bank Soal, Ilustrasi)
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2858A8), AppColors.blue500],
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      AppSpacing.md,
                      AppSpacing.xl,
                      AppSpacing.xl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row Back button + Search pill
                        Row(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => Get.back<void>(),
                              child: Container(
                                width: 38,
                                height: 38,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: AppColors.textDark,
                                  size: 22,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.pill,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.search_rounded,
                                      color: AppColors.textMedium,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: TextField(
                                        onChanged: controller.updateSearch,
                                        style: AppTypography.bodySmall.copyWith(
                                          color: AppColors.textDark,
                                          fontSize: 13.5,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Cari materi belajar',
                                          hintStyle: AppTypography.bodySmall
                                              .copyWith(
                                                color: AppColors.textHint,
                                                fontSize: 13.5,
                                              ),
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        // Title + Bank Soal pill di kiri, Ilustrasi di kanan
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kimia',
                                    style: AppTypography.heading1.copyWith(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Guru Tutor • Kelas Video',
                                    style: AppTypography.bodySmall.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.88,
                                      ),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  GestureDetector(
                                    onTap: () {
                                      final firstMod =
                                          controller.modules.first;
                                      Get.to(
                                        () => TeacherChapterView(
                                          module: firstMod,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 9,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          AppRadius.pill,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: const BoxDecoration(
                                              color: AppColors.red50,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.lightbulb_outline_rounded,
                                              color: AppColors.red500,
                                              size: 15,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'banksoal',
                                            style: AppTypography.bodySmall
                                                .copyWith(
                                                  color: AppColors.textDark,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 14,
                                                ),
                                          ),
                                          const SizedBox(width: 6),
                                          const Icon(
                                            Icons.chevron_right_rounded,
                                            color: AppColors.textMedium,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            SvgPicture.asset(
                              'assets/images/app_mascot.svg',
                              width: 96,
                              height: 96,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Konten utama: Rekomendasi Materi + Daftar Bab
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: AppSpacing.xl, bottom: 110),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2. Rekomendasi Materi (Horizontal Video Cards)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xl,
                        ),
                        child: Text(
                          'Rekomendasi Materi',
                          style: AppTypography.heading2.copyWith(
                            color: AppColors.textDark,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      SizedBox(
                        height: 156,
                        child: Obx(() {
                          final recs = controller.recommendedLessons;
                          if (recs.isEmpty) {
                            return Center(
                              child: Text(
                                'Materi tidak ditemukan',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textMedium,
                                ),
                              ),
                            );
                          }
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.xl,
                            ),
                            itemCount: recs.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: AppSpacing.md),
                            itemBuilder: (context, index) {
                              final lesson = recs[index];
                              return _RecommendedVideoCard(
                                lesson: lesson,
                                onTap: () => Get.to(
                                  () => TeacherVideoDetailView(lesson: lesson),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // 3. Daftar Bab
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xl,
                        ),
                        child: Text(
                          'Daftar Bab',
                          style: AppTypography.heading2.copyWith(
                            color: AppColors.textDark,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xl,
                        ),
                        child: Obx(() {
                          final mods = controller.filteredModules;
                          return Column(
                            children: [
                              for (int i = 0; i < mods.length; i++) ...[
                                _ChapterProgressCard(
                                  module: mods[i],
                                  watchedCount: mods[i].lessons
                                      .where((l) => controller.isWatched(l.id))
                                      .length,
                                  isNew: i == 1,
                                  onTap: () => Get.to(
                                    () => TeacherChapterView(module: mods[i]),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                              ],
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 4. Floating Banner "Terakhir kamu pelajari" di bawah
          Obx(() {
            if (!controller.showLastWatchedBanner.value) {
              return const SizedBox.shrink();
            }
            final lastLesson = controller.lastWatchedLesson;
            final watched = controller.isWatched(lastLesson.id);
            final percent = watched ? 100 : 56;

            return Positioned(
              left: AppSpacing.md,
              right: AppSpacing.md,
              bottom: AppSpacing.md,
              child: SafeArea(
                top: false,
                child: GestureDetector(
                  onTap: () => Get.to(
                    () => TeacherVideoDetailView(lesson: lastLesson),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F53B5),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.16),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.play_circle_fill_rounded,
                            color: AppColors.blue500,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Terakhir kamu pelajari',
                                style: AppTypography.caption.copyWith(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                lastLesson.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.bodySmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13.5,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        AppRadius.pill,
                                      ),
                                      child: LinearProgressIndicator(
                                        value: percent / 100,
                                        minHeight: 6,
                                        backgroundColor: Colors.white
                                            .withValues(alpha: 0.25),
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                              AppColors.green500,
                                            ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '$percent%',
                                    style: AppTypography.caption.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 11.5,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: controller.dismissLastWatchedBanner,
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _RecommendedVideoCard extends StatelessWidget {
  final TeacherLessonModel lesson;
  final VoidCallback onTap;

  const _RecommendedVideoCard({required this.lesson, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail 16:9 dengan avatar guru & badge nama
            Container(
              height: 98,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.blue50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border, width: 1.5),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Center(
                    child: SvgPicture.asset(
                      lesson.teacherAvatar,
                      width: 68,
                      height: 68,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.textDark.withValues(alpha: 0.78),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        lesson.duration,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 6,
                    bottom: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.textDark.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        lesson.teacherName.split(',').first,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              lesson.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChapterProgressCard extends StatelessWidget {
  final TeacherChapterModule module;
  final int watchedCount;
  final bool isNew;
  final VoidCallback onTap;

  const _ChapterProgressCard({
    required this.module,
    required this.watchedCount,
    this.isNew = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final total = module.lessons.length;
    final progress = total > 0 ? watchedCount / total : 0.0;
    final percent = (progress * 100).round();

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border, width: 1.5),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.blue50,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(module.icon, color: AppColors.blue500, size: 28),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        module.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppRadius.pill,
                              ),
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 7,
                                backgroundColor: AppColors.border.withValues(
                                  alpha: 0.55,
                                ),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.blue500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '$percent%',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textMedium,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Icon(
                  Icons.arrow_circle_down_rounded,
                  color: AppColors.blue500,
                  size: 24,
                ),
              ],
            ),
          ),
          if (isNew)
            Positioned(
              top: -6,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.red500,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'BARU',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    color: Colors.white,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
