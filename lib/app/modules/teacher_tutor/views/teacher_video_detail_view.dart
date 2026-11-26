import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_detail_header.dart';
import '../controllers/teacher_tutor_controller.dart';
import '../models/teacher_lesson_model.dart';

class TeacherVideoDetailView extends StatefulWidget {
  final TeacherLessonModel lesson;

  const TeacherVideoDetailView({super.key, required this.lesson});

  @override
  State<TeacherVideoDetailView> createState() => _TeacherVideoDetailViewState();
}

class _TeacherVideoDetailViewState extends State<TeacherVideoDetailView> {
  final TeacherTutorController _controller = Get.find<TeacherTutorController>();

  bool _isPlaying = false;
  double _currentSeconds = 0;
  double _speed = 1.0;
  int _activeTab = 0; // 0 = Chapter, 1 = Rangkuman, 2 = Cek Paham
  int? _selectedQuizOption;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _togglePlay() {
    setState(() => _isPlaying = !_isPlaying);
    _timer?.cancel();
    if (_isPlaying) {
      _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
        if (!mounted) return;
        setState(() {
          _currentSeconds += 0.5 * _speed;
          if (_currentSeconds >= widget.lesson.durationSeconds) {
            _currentSeconds = widget.lesson.durationSeconds.toDouble();
            _isPlaying = false;
            _timer?.cancel();
            _controller.markAsWatched(widget.lesson.id);
          }
        });
      });
    }
  }

  void _jumpToSeconds(int seconds) {
    setState(() {
      _currentSeconds = seconds.toDouble().clamp(
        0,
        widget.lesson.durationSeconds.toDouble(),
      );
      if (!_isPlaying) {
        _togglePlay();
      }
    });
  }

  void _cycleSpeed() {
    setState(() {
      if (_speed == 1.0) {
        _speed = 1.25;
      } else if (_speed == 1.25) {
        _speed = 1.5;
      } else {
        _speed = 1.0;
      }
    });
  }

  String _formatTime(double totalSeconds) {
    final sec = totalSeconds.floor();
    final m = (sec ~/ 60).toString().padLeft(2, '0');
    final s = (sec % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDetailHeader(
              title: lesson.isPracticeVideo ? 'Pembahasan Soal' : 'Video Konsep',
              actions: [
                Obx(() {
                  final watched = _controller.isWatched(lesson.id);
                  return GestureDetector(
                    onTap: () => _controller.markAsWatched(lesson.id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: watched ? AppColors.green50 : AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(
                          color: watched
                              ? AppColors.green500
                              : AppColors.border,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            watched
                                ? Icons.check_circle_rounded
                                : Icons.check_circle_outline_rounded,
                            size: 16,
                            color: watched
                                ? AppColors.green700
                                : AppColors.textMedium,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            watched ? 'Selesai' : 'Tandai',
                            style: AppTypography.caption.copyWith(
                              color: watched
                                  ? AppColors.green700
                                  : AppColors.textMedium,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
            // Player 16:9 bersih
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF18222D),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              lesson.teacherAvatar,
                              width: 56,
                              height: 56,
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: _togglePlay,
                              child: Container(
                                width: 52,
                                height: 52,
                                decoration: const BoxDecoration(
                                  color: AppColors.blue500,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 12,
                        right: 12,
                        bottom: 8,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 3,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6,
                                ),
                                overlayShape: SliderComponentShape.noOverlay,
                              ),
                              child: Slider(
                                value: _currentSeconds,
                                max: lesson.durationSeconds.toDouble(),
                                activeColor: AppColors.blue500,
                                inactiveColor: Colors.white.withValues(
                                  alpha: 0.25,
                                ),
                                onChanged: (val) =>
                                    setState(() => _currentSeconds = val),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  '${_formatTime(_currentSeconds)} / ${lesson.duration}',
                                  style: const TextStyle(
                                    fontFamily: AppTypography.fontFamily,
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: _cycleSpeed,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.16,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${_speed}x',
                                      style: const TextStyle(
                                        fontFamily: AppTypography.fontFamily,
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: AppTypography.heading2.copyWith(
                      color: AppColors.textDark,
                      fontSize: 18,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      SvgPicture.asset(
                        lesson.teacherAvatar,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${lesson.teacherName} • ${lesson.teacherRole}',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textMedium,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              color: AppColors.surface,
              child: Row(
                children: [
                  _DetailTab(
                    label: 'Chapter',
                    selected: _activeTab == 0,
                    onTap: () => setState(() => _activeTab = 0),
                  ),
                  _DetailTab(
                    label: 'Rangkuman',
                    selected: _activeTab == 1,
                    onTap: () => setState(() => _activeTab = 1),
                  ),
                  _DetailTab(
                    label: 'Cek Paham',
                    selected: _activeTab == 2,
                    onTap: () => setState(() => _activeTab = 2),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: _buildTabContent(lesson),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(TeacherLessonModel lesson) {
    if (_activeTab == 0) {
      return Column(
        children: [
          for (int i = 0; i < lesson.chapters.length; i++) ...[
            Builder(
              builder: (context) {
                final ch = lesson.chapters[i];
                final nextSeconds = i + 1 < lesson.chapters.length
                    ? lesson.chapters[i + 1].seconds
                    : lesson.durationSeconds + 1;
                final isActive =
                    _currentSeconds >= ch.seconds &&
                    _currentSeconds < nextSeconds;

                return GestureDetector(
                  onTap: () => _jumpToSeconds(ch.seconds),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.blue50 : AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isActive ? AppColors.blue500 : AppColors.border,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.blue500
                                : AppColors.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            ch.timestamp,
                            style: AppTypography.caption.copyWith(
                              color: isActive
                                  ? Colors.white
                                  : AppColors.textDark,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            ch.title,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.play_arrow_rounded,
                          color: isActive
                              ? AppColors.blue500
                              : AppColors.textMedium,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ],
      );
    }

    if (_activeTab == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.blue50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.blue100, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RUMUS KUNCI',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.blue700,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  lesson.formulaHighlight,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          for (final point in lesson.summaryPoints) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.blue500,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    point,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textDark,
                      fontSize: 14,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      );
    }

    final quiz = lesson.miniQuiz;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          quiz.question,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textDark,
            fontWeight: FontWeight.w800,
            fontSize: 15,
            height: 1.35,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (int i = 0; i < quiz.options.length; i++) ...[
          Builder(
            builder: (context) {
              final isSelected = _selectedQuizOption == i;
              final isCorrect = i == quiz.correctIndex;
              final showResult = _selectedQuizOption != null;

              Color borderColor = AppColors.border;
              Color bgColor = AppColors.surface;
              if (showResult && isCorrect) {
                borderColor = AppColors.green500;
                bgColor = AppColors.green50;
              } else if (showResult && isSelected && !isCorrect) {
                borderColor = AppColors.red500;
                bgColor = AppColors.red50;
              }

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedQuizOption = i);
                  if (isCorrect) {
                    _controller.markAsWatched(lesson.id);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: borderColor, width: 1.5),
                  ),
                  child: Text(
                    quiz.options[i],
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        if (_selectedQuizOption != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: _selectedQuizOption == quiz.correctIndex
                  ? AppColors.green50
                  : AppColors.yellow50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _selectedQuizOption == quiz.correctIndex
                    ? AppColors.green500
                    : AppColors.orange,
                width: 1.5,
              ),
            ),
            child: Text(
              quiz.explanation,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textDark,
                fontSize: 13.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _DetailTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DetailTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? AppColors.blue500 : AppColors.border,
                width: 2,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: selected ? AppColors.blue500 : AppColors.textMedium,
              fontWeight: FontWeight.w800,
              fontSize: 13.5,
            ),
          ),
        ),
      ),
    );
  }
}
