import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../widgets/app_step_header.dart';
import '../../home/models/topic_model.dart';
import '../controllers/flashcard_controller.dart';
import '../data/flashcard_data.dart';
import '../models/flashcard_model.dart';
import '../widgets/flashcard_bottom_bar.dart';
import '../widgets/flashcard_card.dart';

class FlashcardView extends StatefulWidget {
  const FlashcardView({super.key});

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView> {
  final FlashcardController controller = Get.find<FlashcardController>();

  @override
  void initState() {
    super.initState();

    final topic = Get.arguments;

    final List<FlashcardModel> flashcards;

    if (topic is TopicModel) {
      flashcards = FlashcardData.getFlashcardsByTopic(topic.id);
    } else {
      flashcards = FlashcardData.getFlashcardsByTopic('atomic_structure');
    }

    controller.initializeFlashcards(flashcards);
  }

  void _handleCardCompleted() {
    if (controller.isCompleted.value) {
      Get.back();
    }
  }

  void _markNotMemorized() {
    controller.markNotMemorized();
    _handleCardCompleted();
  }

  void _markMemorized() {
    controller.markMemorized();
    _handleCardCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Obx(() {
          final flashcards = controller.flashcards;
          final currentIndex = controller.currentIndex.value;
          final isFlipped = controller.isFlipped.value;

          return Column(
            children: [
              AppStepHeader.steps(
                currentStep: flashcards.isEmpty ? 0 : currentIndex + 1,
                totalSteps: flashcards.length,
                backIcon: Icons.close_rounded,
                progressColor: AppColors.blue500,
                trackColor: AppColors.border,
                onBackPressed: () => Get.back(),
              ),
              Expanded(
                child: flashcards.isEmpty
                    ? const Center(
                        child: Text('Belum ada flashcard untuk topik ini.'),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xl,
                        ),
                        child: FlashcardCard(
                          key: ValueKey(flashcards[currentIndex].id),
                          flashcard: flashcards[currentIndex],
                          isFlipped: isFlipped,
                          onTap: controller.flipCard,
                          currentIndex: currentIndex + 1,
                          totalCards: flashcards.length,
                        ),
                      ),
              ),
              if (flashcards.isNotEmpty)
                FlashcardBottomBar(
                  isFlipped: isFlipped,
                  onNotMemorized: _markNotMemorized,
                  onMemorized: _markMemorized,
                ),
            ],
          );
        }),
      ),
    );
  }
}
