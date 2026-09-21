import 'package:get/get.dart';

import '../controllers/topic_controller.dart';

class TopicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopicController>(
      () => TopicController(),
    );
  }
}
