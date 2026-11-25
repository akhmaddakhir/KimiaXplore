import 'package:get/get.dart';

class SimulationModel {
  final String id;
  final String title;
  final String description;
  final String? imageAsset;
  final bool isAvailable;
  final String? category;
  final String? level;

  const SimulationModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageAsset,
    this.isAvailable = true,
    this.category,
    this.level,
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

  factory SimulationModel.fromJson(Map<String, dynamic> json) {
    return SimulationModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      imageAsset: json['image_asset']?.toString(),
      isAvailable: json['is_available'] as bool? ?? true,
      category: json['category']?.toString(),
      level: json['level']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_asset': imageAsset,
      'is_available': isAvailable,
      'category': category,
      'level': level,
    };
  }
}
