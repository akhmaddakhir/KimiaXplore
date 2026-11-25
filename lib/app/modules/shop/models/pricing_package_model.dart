import 'package:get/get.dart';

class PricingPackageModel {
  final String id;
  final String title;
  final String duration;
  final String? description;
  final String price;
  final String? originalPrice;
  final String perMonthPrice;
  final String? badge;
  final bool isPopular;
  final List<String> features;
  final String? imageAsset;

  const PricingPackageModel({
    required this.id,
    required this.title,
    required this.duration,
    this.description,
    required this.price,
    this.originalPrice,
    required this.perMonthPrice,
    this.badge,
    this.isPopular = false,
    this.features = const [],
    this.imageAsset,
  });

  String get localizedDuration {
    final key = 'shop_duration_$id';
    final translated = key.tr;
    return translated != key ? translated : duration;
  }

  String? get localizedBadge {
    if (badge == null) return null;
    final key = 'shop_badge_$id';
    final translated = key.tr;
    return translated != key ? translated : badge;
  }

  factory PricingPackageModel.fromJson(Map<String, dynamic> json) {
    final rawFeatures = json['features'];
    final List<String> featuresList = (rawFeatures is List)
        ? rawFeatures.map((e) => e.toString()).toList()
        : <String>[];

    return PricingPackageModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      duration: json['duration']?.toString() ?? '1 Bulan',
      description: json['description']?.toString(),
      price: json['price']?.toString() ?? 'Rp0',
      originalPrice: json['original_price']?.toString(),
      perMonthPrice: json['per_month_price']?.toString() ??
          json['price']?.toString() ??
          '',
      badge: json['badge']?.toString(),
      isPopular: json['is_popular'] as bool? ?? false,
      features: featuresList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'description': description,
      'price': price,
      'original_price': originalPrice,
      'per_month_price': perMonthPrice,
      'badge': badge,
      'is_popular': isPopular,
      'features': features,
    };
  }
}
