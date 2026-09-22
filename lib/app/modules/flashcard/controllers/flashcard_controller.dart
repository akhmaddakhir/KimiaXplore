import 'package:get/get.dart';

import '../../../models/activity_navigation.dart';
import '../../../services/learning_progress_service.dart';
import '../../home/models/topic_model.dart';
import '../models/flashcard_model.dart';

class FlashcardController extends GetxController {
  final LearningProgressService _progressService = LearningProgressService();

  final flashcards = <FlashcardModel>[].obs;

  final currentIndex = 0.obs;
  final isFlipped = false.obs;
  final isCompleted = false.obs;
  final isSavingProgress = false.obs;

  final memorizationStatuses = <String, bool>{}.obs;

  final List<FlashcardModel> _originalFlashcards = [];

  TopicModel? _topic;

  String? get activityId {
    final topic = _topic;

    if (topic == null) {
      return null;
    }

    return '${topic.id}_flashcard';
  }

  FlashcardModel? get currentCard {
    if (flashcards.isEmpty || currentIndex.value >= flashcards.length) {
      return null;
    }

    return flashcards[currentIndex.value];
  }

  int get totalCards => flashcards.length;

  int get originalTotalCards => _originalFlashcards.length;

  int get memorizedCount {
    return _originalFlashcards.where((card) {
      return memorizationStatuses[card.id] == true;
    }).length;
  }

  int get notMemorizedCount {
    return _originalFlashcards.where((card) {
      return memorizationStatuses[card.id] == false;
    }).length;
  }

  int get answeredCount {
    return flashcards.where((card) {
      return memorizationStatuses.containsKey(card.id);
    }).length;
  }

  int get remainingCount {
    final remaining = totalCards - answeredCount;

    if (remaining < 0) {
      return 0;
    }

    return remaining;
  }

  double get progress {
    if (totalCards == 0) {
      return 0;
    }

    return (answeredCount / totalCards).clamp(0.0, 1.0);
  }

  bool get allCardsMemorized {
    if (_originalFlashcards.isEmpty) {
      return false;
    }

    return memorizedCount == _originalFlashcards.length;
  }

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;

    if (arguments is ActivityNavigation) {
      _topic = arguments.topic;
    } else if (arguments is TopicModel) {
      _topic = arguments;
    }
  }

  void initializeFlashcards(List<FlashcardModel> cards) {
    _originalFlashcards
      ..clear()
      ..addAll(cards);

    memorizationStatuses.clear();

    _startSession(cards);

    _markFlashcardOpened();
  }

  void _startSession(List<FlashcardModel> cards) {
    currentIndex.value = 0;
    isFlipped.value = false;
    isCompleted.value = false;

    flashcards.assignAll(cards);
  }

  Future<void> _markFlashcardOpened() async {
    final topic = _topic;
    final currentActivityId = activityId;

    if (topic == null || currentActivityId == null) {
      return;
    }

    try {
      await _progressService.markActivityOpened(
        topicId: topic.id,
        activityType: 'flashcard',
        activityId: currentActivityId,
      );
    } catch (_) {}
  }

  Future<void> _saveProgress() async {
    final topic = _topic;
    final currentActivityId = activityId;

    if (topic == null ||
        currentActivityId == null ||
        _originalFlashcards.isEmpty) {
      return;
    }

    if (isSavingProgress.value) {
      return;
    }

    isSavingProgress.value = true;

    try {
      await _progressService.saveActivityProgress(
        topicId: topic.id,
        activityType: 'flashcard',
        activityId: currentActivityId,
        progress: memorizedCount,
        total: originalTotalCards,
        isCompleted: allCardsMemorized,
      );
    } finally {
      isSavingProgress.value = false;
    }
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

    _saveProgress();

    _nextCard();
  }

  void _nextCard() {
    if (currentIndex.value >= flashcards.length - 1) {
      isCompleted.value = true;
      isFlipped.value = false;

      _saveProgress();

      return;
    }

    currentIndex.value++;
    isFlipped.value = false;
  }

  void restartFlashcards() {
    memorizationStatuses.clear();

    _startSession(List<FlashcardModel>.from(_originalFlashcards));

    _saveProgress();
    _markFlashcardOpened();
  }

  void retryNotMemorized() {
    if (!isCompleted.value) {
      return;
    }

    final cards = _originalFlashcards.where((card) {
      return memorizationStatuses[card.id] != true;
    }).toList();

    if (cards.isEmpty) {
      return;
    }

    _startSession(cards);

    _markFlashcardOpened();
  }
}
