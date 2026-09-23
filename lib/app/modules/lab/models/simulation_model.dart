import 'package:get/get.dart';

class SimulationModel {
  final String id;
  final String title;
  final String description;
  final String? imageAsset;

  const SimulationModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageAsset,
  });

  String get localizedTitle {
    final key = 'simulation_${id}_title';
    final translated = key.tr;
    return translated != key ? translated : title;
  }

  String get localizedDescription {
    final key = 'simulation_${id}_desc';
    final translated = key.tr;
    return translated != key ? translated : description;
  }
}
