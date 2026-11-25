import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/content_service.dart';
import '../data/lab_simulations.dart';
import '../models/simulation_model.dart';

class LabController extends GetxController {
  final ContentService _contentService = ContentService();

  final studyProgress = 0.obs;
  final simulations = <SimulationModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSimulations();
  }

  Future<void> loadSimulations() async {
    isLoading.value = true;
    try {
      final fetched = await _contentService.getSimulations();
      simulations.assignAll(fetched);
    } catch (_) {
      simulations.assignAll(LabSimulations.items);
    } finally {
      isLoading.value = false;
    }
  }

  void onSimulationSelected(SimulationModel simulation) {
    if (!simulation.isAvailable) {
      Get.snackbar(
        simulation.localizedTitle,
        'Simulasi ini sedang dalam pemeliharaan atau pengembangan.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    Get.toNamed(AppRoutes.simulation, arguments: simulation);
  }
}
