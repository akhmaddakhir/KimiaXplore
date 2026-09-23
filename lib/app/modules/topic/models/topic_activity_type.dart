import 'package:get/get.dart';

enum TopicActivityType {
  materi,
  flashcard,
  kuis,
  simulasi;

  String get title {
    switch (this) {
      case TopicActivityType.materi:
        return 'topic_act_material_title'.tr;
      case TopicActivityType.flashcard:
        return 'topic_act_flashcard_title'.tr;
      case TopicActivityType.kuis:
        return 'topic_act_quiz_title'.tr;
      case TopicActivityType.simulasi:
        return 'topic_act_simulation_title'.tr;
    }
  }

  String get subtitle {
    switch (this) {
      case TopicActivityType.materi:
        return 'topic_act_material_sub'.tr;
      case TopicActivityType.flashcard:
        return 'topic_act_flashcard_sub'.tr;
      case TopicActivityType.kuis:
        return 'topic_act_quiz_sub'.tr;
      case TopicActivityType.simulasi:
        return 'topic_act_simulation_sub'.tr;
    }
  }
}
