import 'package:get/get.dart';

import '../controllers/lab_controller.dart';

class LabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LabController>(
      () => LabController(),
    );
  }
}
