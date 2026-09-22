import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../data/lab_simulations.dart';
import '../models/simulation_model.dart';

class LabController extends GetxController {
  final studyProgress = 0.obs;
  final simulations = <SimulationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSimulations();
  }

  void loadSimulations() {
    simulations.assignAll(LabSimulations.items);
  }

  void onSimulationSelected(SimulationModel simulation) {
    Get.toNamed(AppRoutes.simulation, arguments: simulation);
  }
}
