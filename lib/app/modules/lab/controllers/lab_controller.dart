import 'package:get/get.dart';

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
    // Navigasi ke halaman simulasi spesifik
  }
}
