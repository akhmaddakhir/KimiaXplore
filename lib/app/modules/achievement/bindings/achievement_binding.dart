import 'package:get/get.dart';

import '../controllers/achievement_controller.dart';

class AchievementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AchievementController>(() => AchievementController());
  }
}
