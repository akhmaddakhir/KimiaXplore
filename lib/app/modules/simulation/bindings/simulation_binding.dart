import 'package:get/get.dart';

import '../controllers/simulation_controller.dart';

class SimulationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SimulationController>(
      () => SimulationController(),
    );
  }
}
