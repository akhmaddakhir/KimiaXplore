import 'package:get/get.dart';

import '../models/premium_benefit_model.dart';
import '../models/pricing_package_model.dart';

class ShopController extends GetxController {
  final currentStep = 0.obs;

  final selectedPackageId = 'yearly'.obs;

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

  final List<PricingPackageModel> packages = const [
    PricingPackageModel(
      id: 'monthly',
      title: '1 Bulan',
      duration: '1 bulan',
      price: 'Rp19.000',
      perMonthPrice: 'Rp19.000/bulan',
    ),
    PricingPackageModel(
      id: 'quarterly',
      title: '3 Bulan',
      duration: '3 bulan',
      price: 'Rp49.000',
      perMonthPrice: 'Rp16.333/bulan',
    ),
    PricingPackageModel(
      id: 'yearly',
      title: '1 Tahun',
      duration: '12 bulan',
      price: 'Rp149.000',
      perMonthPrice: 'Rp12.417/bulan',
      badge: 'Paling Hemat',
      isPopular: true,
    ),
  ];

  PricingPackageModel get selectedPackage {
    return packages.firstWhere(
      (package) => package.id == selectedPackageId.value,
    );
  }

  void selectPackage(String packageId) {
    selectedPackageId.value = packageId;
  }

  void goToPackages() {
    currentStep.value = 1;
  }

  void goBack() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void continueToCheckout() {
    currentStep.value = 2;
  }
}
