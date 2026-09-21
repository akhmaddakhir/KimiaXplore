import 'package:get/get.dart';

import '../controllers/material_controller.dart';

class MaterialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaterialController>(
      () => MaterialController(),
    );
  }
}
