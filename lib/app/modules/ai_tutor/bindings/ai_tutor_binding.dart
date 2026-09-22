import 'package:get/get.dart';

import '../controllers/ai_tutor_controller.dart';

class AiTutorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiTutorController>(
      () => AiTutorController(),
    );
  }
}
