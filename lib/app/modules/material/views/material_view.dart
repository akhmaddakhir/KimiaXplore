import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_detail_header.dart';
import '../controllers/material_controller.dart';

class MaterialView extends GetView<MaterialController> {
  const MaterialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppDetailHeader(title: 'Materi'),

            Expanded(
              child: Obx(() {
                final topic = controller.topic.value;
                final material = controller.material.value;
                final selectedLesson = controller.selectedLesson.value;

                if (topic == null) {
                  return Center(
                    child: Text(
                      'Topik tidak ditemukan',
                      style: AppTypography.body.copyWith(
                        color: AppColors.textDark,
                      ),
                    ),
                  );
                }

                if (material == null) {
                  return Center(
                    child: Text(
                      'Materi belum tersedia',
                      style: AppTypography.body.copyWith(
                        color: AppColors.textDark,
                      ),
                    ),
                  );
                }

                return Stack(
                  children: [
                    Positioned.fill(
                      child: SingleChildScrollView(
                        key: ValueKey(selectedLesson?.id ?? topic.id),
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.xl,
                          AppSpacing.md,
                          AppSpacing.xl,
                          120,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                                vertical: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.green50,
                                borderRadius: BorderRadius.circular(
                                  AppRadius.pill,
                                ),
                                border: Border.all(
                                  color: AppColors.green100,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                'Kimia ${topic.level}',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.darkTeal,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),

                            const SizedBox(height: AppSpacing.md),

                            Text(
                              selectedLesson?.title ?? topic.title,
                              style: AppTypography.heading1.copyWith(
                                color: AppColors.textDark,
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                height: 1.25,
                              ),
                            ),

                            const SizedBox(height: AppSpacing.sm),

                            Text(
                              selectedLesson?.description ?? topic.description,
                              style: AppTypography.body.copyWith(
                                color: AppColors.textMedium,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                              ),
                            ),

                            if (controller.totalLessons > 1) ...[
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                'Pelajaran ${controller.currentLessonIndex.value + 1} dari ${controller.totalLessons}',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textMedium,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],

                            const SizedBox(height: AppSpacing.xxl),

                            ...material.sections.map(
                              (section) => _MaterialSection(
                                title: section.title,
                                paragraphs: section.paragraphs,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: double.infinity,
                        color: AppColors.background,
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.xl,
                          AppSpacing.md,
                          AppSpacing.xl,
                          AppSpacing.lg,
                        ),
                        child: AppButton.primary(
                          label: controller.hasNextLesson
                              ? 'Pelajaran Selanjutnya'
                              : 'Selesai',
                          onPressed: controller.hasNextLesson
                              ? controller.nextLesson
                              : controller.finishMaterial,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _MaterialSection extends StatelessWidget {
  final String title;
  final List<String> paragraphs;

  const _MaterialSection({required this.title, required this.paragraphs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.heading2.copyWith(
              color: AppColors.textDark,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          ...paragraphs.map(
            (paragraph) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Text(
                paragraph,
                style: AppTypography.body.copyWith(
                  color: AppColors.textDark,
                  fontSize: 16,
                  height: 1.7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
