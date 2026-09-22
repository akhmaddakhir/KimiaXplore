import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/activity_navigation.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../widgets/app_step_header.dart';
import '../../home/models/topic_model.dart';
import '../controllers/flashcard_controller.dart';
import '../data/flashcard_data.dart';
import '../models/flashcard_model.dart';
import '../widgets/flashcard_bottom_bar.dart';
import '../widgets/flashcard_card.dart';
import 'flashcard_result_view.dart';

class FlashcardView extends StatefulWidget {
  const FlashcardView({super.key});

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView> {
  final FlashcardController controller = Get.find<FlashcardController>();

  ActivityNavigation? _navigation;

  @override
  void initState() {
    super.initState();

    final arguments = Get.arguments;

    TopicModel? topic;

    if (arguments is ActivityNavigation) {
      _navigation = arguments;
      topic = arguments.topic;
    } else if (arguments is TopicModel) {
      topic = arguments;
    }

    final List<FlashcardModel> flashcards;

    if (topic != null) {
      flashcards = FlashcardData.getFlashcardsByTopic(topic.id);
    } else {
      flashcards = [];
    }

    controller.initializeFlashcards(flashcards);
  }

  void _retryNotMemorized() {
    controller.retryNotMemorized();
  }

  void _finishFlashcards() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isCompleted.value) {
        return FlashcardResultView(
          onRetry: _retryNotMemorized,
          onFinish: _finishFlashcards,
        );
      }

      final flashcards = controller.flashcards;
      final currentIndex = controller.currentIndex.value;
      final isFlipped = controller.isFlipped.value;

      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
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
                  onNotMemorized: controller.markNotMemorized,
                  onMemorized: controller.markMemorized,
                ),
            ],
          ),
        ),
      );
    });
  }
}
