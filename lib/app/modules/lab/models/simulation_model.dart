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
}
