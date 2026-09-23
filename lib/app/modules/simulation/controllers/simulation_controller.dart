import 'package:get/get.dart';

import '../../lab/models/simulation_model.dart';
import '../models/matter_state.dart';

class SimulationController extends GetxController {
  static const double minTemperature = -20;
  static const double maxTemperature = 120;
  static const double initialTemperature = 20;

  final simulation = Rxn<SimulationModel>();
  final temperature = initialTemperature.obs;

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;

    if (arguments is SimulationModel) {
      simulation.value = arguments;
    }
  }

  String get title {
    return simulation.value?.localizedTitle ?? 'simulation_title'.tr;
  }

  bool get isStatesOfMatter {
    return simulation.value?.id == 'states_of_matter';
  }

  MatterState get matterState {
    if (temperature.value <= 0) {
      return MatterState.solid;
    }

    if (temperature.value >= 100) {
      return MatterState.gas;
    }

    return MatterState.liquid;
  }

  void updateTemperature(double value) {
    temperature.value = value.clamp(minTemperature, maxTemperature).toDouble();
  }

  void resetTemperature() {
    temperature.value = initialTemperature;
  }
}
