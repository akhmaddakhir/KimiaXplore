import 'package:get/get.dart';

import '../models/premium_benefit_model.dart';

class ShopController extends GetxController {
  final List<PremiumBenefitModel> benefits = const [
    PremiumBenefitModel(
      id: 'ai_tutor_access',
      title: 'AI Tutor lebih lengkap',
      freeIncluded: false,
      premiumIncluded: true,
    ),
    PremiumBenefitModel(
      id: 'ai_tutor_usage',
      title: 'Usage lebih banyak',
      freeIncluded: false,
      premiumIncluded: true,
    ),
    PremiumBenefitModel(
      id: 'ad_free_learning',
      title: 'Belajar tanpa iklan',
      freeIncluded: false,
      premiumIncluded: true,
    ),
    PremiumBenefitModel(
      id: 'upcoming_features',
      title: 'Akses fitur baru lebih awal',
      freeIncluded: false,
      premiumIncluded: true,
    ),
  ];

  void goToPackages() {
    // Step 2 nanti.
  }
}
