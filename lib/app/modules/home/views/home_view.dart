import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_main_header.dart';
import '../../../widgets/app_stat_chip.dart';
import '../controllers/home_controller.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/topic_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppMainHeader(
              title: 'Home',
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
              actions: [
                Obx(
                  () => AppStatChip(
                    icon: const Icon(
                      Icons.event_available_rounded,
                      size: 18,
                      color: AppColors.blue500,
                    ),
                    value: '${controller.studyProgress.value}',
                    tooltip: 'Progres Belajar',
                    backgroundColor: AppColors.blue50,
                    borderColor: AppColors.blue100,
                    textColor: AppColors.blue500,
                    onTap: () {},
                  ),
                ),
              ],
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    const Text(
                      'Halo, xplorer!',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF758A83),
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Mau xplore apa hari ini?',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E352F),
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Obx(() {
                      if (controller.topics.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      final topic = controller.topics.first;

                      return RecommendationCard(
                        topic: topic,
                        onButtonPressed: () {
                          controller.onTopicSelected(topic);
                        },
                      );
                    }),

                    const SizedBox(height: 32),

                    const Text(
                      'Fondasi Kimia',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E352F),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            'Konsep utama untuk memulai perjalananmu.',
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF758A83),
                              height: 1.3,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        _ActionTextButton(
                          label: 'Lihat semua',
                          onTap: () {
                            // Navigasi ke halaman semua materi
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Obx(
                      () => ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.topics.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final topic = controller.topics[index];

                          return TopicCard(
                            topic: topic,
                            onTap: () {
                              controller.onTopicSelected(topic);
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),
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

class _ActionTextButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _ActionTextButton({required this.label, required this.onTap});

  @override
  State<_ActionTextButton> createState() => _ActionTextButtonState();
}

class _ActionTextButtonState extends State<_ActionTextButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
      },
      onTapUp: (_) async {
        await Future.delayed(const Duration(milliseconds: 100));

        if (mounted) {
          setState(() => _isPressed = false);
        }
      },
      onTapCancel: () {
        if (mounted) {
          setState(() => _isPressed = false);
        }
      },
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _isPressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: AnimatedOpacity(
          opacity: _isPressed ? 0.55 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0FA8A4),
                height: 1.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
