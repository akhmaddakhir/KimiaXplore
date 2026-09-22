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

  late final List<FlashcardModel> flashcards;

  int currentIndex = 0;
  bool isFlipped = false;

  @override
  void initState() {
    super.initState();

    final topic = Get.arguments;

    if (topic is TopicModel) {
      flashcards = FlashcardData.getFlashcardsByTopic(topic.id);
    } else {
      flashcards = FlashcardData.getFlashcardsByTopic('atomic_structure');
    }
  }

  void _flipCard() {
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        onTap: _flipCard,
                        currentIndex: currentIndex + 1,
                        totalCards: flashcards.length,
                      ),
                    ),
            ),
            if (flashcards.isNotEmpty)
              FlashcardBottomBar(onNotMemorized: () {}, onMemorized: () {}),
          ],
        ),
      ),
    );
  }
}
