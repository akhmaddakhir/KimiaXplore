import 'package:get/get.dart';

import '../../home/models/topic_model.dart';

class TopicController extends GetxController {
  final topic = Rxn<TopicModel>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is TopicModel) {
      topic.value = Get.arguments as TopicModel;
    }
  }
}
