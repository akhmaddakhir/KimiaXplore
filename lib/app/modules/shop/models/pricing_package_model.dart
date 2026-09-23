import 'package:get/get.dart';

class PricingPackageModel {
  final String id;
  final String title;
  final String duration;
  final String price;
  final String? originalPrice;
  final String perMonthPrice;
  final String? badge;
  final bool isPopular;

  const PricingPackageModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.price,
    this.originalPrice,
    required this.perMonthPrice,
    this.badge,
    this.isPopular = false,
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
}
