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
}
