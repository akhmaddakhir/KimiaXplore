import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../home/models/topic_model.dart';
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

  void onActivitySelected(TopicActivityType activity) {
    final currentTopic = topic.value;

    if (currentTopic == null) return;

    switch (activity) {
      case TopicActivityType.materi:
        Get.toNamed(AppRoutes.material, arguments: currentTopic);
        break;

      case TopicActivityType.kuis:
        Get.toNamed(AppRoutes.quiz, arguments: currentTopic);
        break;

      default:
        break;
    }
  }
}
