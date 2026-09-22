import 'package:get/get.dart';

import '../../../models/activity_navigation.dart';
import '../../../routes/app_routes.dart';
import '../../home/models/topic_model.dart';
import '../../material/data/material_lesson_data.dart';
import '../../material/models/material_lesson_model.dart';
import '../../material/views/material_lesson_list_view.dart';
import '../models/topic_activity_type.dart';

class TopicController extends GetxController {
  final topic = Rxn<TopicModel>();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments is TopicModel) {
      topic.value = Get.arguments as TopicModel;
    }
  }

  void onRecommendedActivityPressed() {
    final currentTopic = topic.value;

    if (currentTopic == null) return;

    Get.toNamed(
      AppRoutes.material,
      arguments: ActivityNavigation(
        topic: currentTopic,
        entryPoint: ActivityEntryPoint.recommendation,
      ),
    );
  }

  void onActivitySelected(TopicActivityType activity) {
    final currentTopic = topic.value;

    if (currentTopic == null) return;

    final navigation = ActivityNavigation(
      topic: currentTopic,
      entryPoint: ActivityEntryPoint.activity,
    );

    switch (activity) {
      case TopicActivityType.materi:
        _openMaterial(currentTopic);
        break;

      case TopicActivityType.kuis:
        Get.toNamed(AppRoutes.quiz, arguments: navigation);
        break;

      case TopicActivityType.flashcard:
        Get.toNamed(AppRoutes.flashcard, arguments: navigation);
        break;

      default:
        break;
    }
  }

  void _openMaterial(TopicModel currentTopic) {
    final lessons = MaterialLessonData.getLessonsByTopic(currentTopic.id);

    if (lessons.length > 1) {
      Get.to(() => MaterialLessonListView(topic: currentTopic));
      return;
    }

    if (lessons.isEmpty) {
      Get.toNamed(
        AppRoutes.material,
        arguments: ActivityNavigation(
          topic: currentTopic,
          entryPoint: ActivityEntryPoint.activity,
        ),
      );
      return;
    }

    Get.toNamed(
      AppRoutes.material,
      arguments: MaterialLessonSelection(
        topicId: currentTopic.id,
        lesson: lessons.first,
      ),
    );
  }
}
