import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_typography.dart';
import '../models/flashcard_model.dart';

class FlashcardCard extends StatefulWidget {
  const FlashcardCard({
    super.key,
    required this.flashcard,
    required this.isFlipped,
    required this.onTap,
    required this.currentIndex,
    required this.totalCards,
  });

  final FlashcardModel flashcard;
  final bool isFlipped;
  final VoidCallback onTap;
  final int currentIndex;
  final int totalCards;

  @override
  State<FlashcardCard> createState() => _FlashcardCardState();
}

class _FlashcardCardState extends State<FlashcardCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
      value: widget.isFlipped ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(covariant FlashcardCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.flashcard.id != widget.flashcard.id) {
      _animationController.value = widget.isFlipped ? 1.0 : 0.0;
      return;
    }

    if (oldWidget.isFlipped != widget.isFlipped) {
      if (widget.isFlipped) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: AspectRatio(
          aspectRatio: 1.15,
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                final value = Curves.easeInOut.transform(
                  _animationController.value,
                );

                final angle = value * math.pi;
                final showBack = value >= 0.5;

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateY(showBack ? math.pi : 0.0),
                    child: _buildCard(showBack: showBack),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required bool showBack}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.blue700.withValues(alpha: 0.06),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  showBack ? 'Jawaban' : 'Pertanyaan',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textMedium,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
              ],
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      showBack
                          ? widget.flashcard.answer
                          : widget.flashcard.question,
                      textAlign: TextAlign.left,
                      style: AppTypography.heading2.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w700,
                        height: 1.45,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                showBack ? 'Lihat pertanyaan' : 'Lihat jawaban',
                textAlign: TextAlign.center,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textHint,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
