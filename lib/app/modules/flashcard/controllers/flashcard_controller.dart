import 'package:get/get.dart';

import '../models/flashcard_model.dart';

class FlashcardController extends GetxController {
  final flashcards = <FlashcardModel>[].obs;

  final currentIndex = 0.obs;
  final isFlipped = false.obs;
  final isCompleted = false.obs;

  final memorizationStatuses = <String, bool>{}.obs;

  final List<FlashcardModel> _originalFlashcards = [];

  FlashcardModel? get currentCard {
    if (flashcards.isEmpty || currentIndex.value >= flashcards.length) {
      return null;
    }

    return flashcards[currentIndex.value];
  }

  int get totalCards => flashcards.length;

  int get memorizedCount {
    return memorizationStatuses.values
        .where((isMemorized) => isMemorized)
        .length;
  }

  int get notMemorizedCount {
    return memorizationStatuses.values
        .where((isMemorized) => !isMemorized)
        .length;
  }

  int get answeredCount => memorizationStatuses.length;

  int get remainingCount => totalCards - answeredCount;

  double get progress {
    if (totalCards == 0) {
      return 0;
    }

    return answeredCount / totalCards;
  }

  void initializeFlashcards(List<FlashcardModel> cards) {
    _originalFlashcards
      ..clear()
      ..addAll(cards);

    _startSession(cards);
  }

  void _startSession(List<FlashcardModel> cards) {
    currentIndex.value = 0;
    isFlipped.value = false;
    isCompleted.value = false;

    memorizationStatuses.clear();
    flashcards.assignAll(cards);
  }

  void flipCard() {
    if (flashcards.isEmpty || isCompleted.value) {
      return;
    }

    isFlipped.value = !isFlipped.value;
  }

  void markMemorized() {
    _markCard(true);
  }

  void markNotMemorized() {
    _markCard(false);
  }

  void _markCard(bool isMemorized) {
    if (flashcards.isEmpty || !isFlipped.value || isCompleted.value) {
      return;
    }

    final card = currentCard;

    if (card == null) {
      return;
    }

    memorizationStatuses[card.id] = isMemorized;

    _nextCard();
  }

  void _nextCard() {
    if (currentIndex.value >= flashcards.length - 1) {
      isCompleted.value = true;
      isFlipped.value = false;
      return;
    }

    currentIndex.value++;
    isFlipped.value = false;
  }

  void restartFlashcards() {
    _startSession(List<FlashcardModel>.from(_originalFlashcards));
  }

  void retryNotMemorized() {
    if (!isCompleted.value) {
      return;
    }

    final cards = flashcards.where((card) {
      return memorizationStatuses[card.id] == false;
    }).toList();

    if (cards.isEmpty) {
      return;
    }

    _startSession(cards);
  }
}
