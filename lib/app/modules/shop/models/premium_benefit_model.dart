import 'package:get/get.dart';

class PremiumBenefitModel {
  final String id;
  final String title;
  final bool freeIncluded;
  final bool premiumIncluded;

  const PremiumBenefitModel({
    required this.id,
    required this.title,
    this.freeIncluded = false,
    this.premiumIncluded = true,
  });

  String get localizedTitle {
    final key = 'shop_benefit_$id';
    final translated = key.tr;
    return translated != key ? translated : title;
  }
}
