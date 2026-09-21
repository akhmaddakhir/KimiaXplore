import 'package:get/get.dart';

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
    // Mengarahkan ke halaman aktivitas yang dipilih
  }
}
