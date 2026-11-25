import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../services/content_service.dart';
import '../../profile/controllers/profile_controller.dart';
import '../models/premium_benefit_model.dart';
import '../models/pricing_package_model.dart';

class ShopController extends GetxController {
  final ContentService _contentService = ContentService();

  final currentStep = 0.obs;
  final selectedPackageId = 'yearly'.obs;
  final isLoading = false.obs;

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

  final packages = <PricingPackageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPackages();
  }

  Future<void> loadPackages() async {
    isLoading.value = true;
    try {
      final fetched = await _contentService.getPackages();
      if (fetched.isNotEmpty) {
        packages.assignAll(fetched);

        // Jika package id yang terpilih sebelumnya tidak ada di paket baru, pilih paket populer/pertama
        if (!packages.any((p) => p.id == selectedPackageId.value)) {
          final popular = packages.firstWhereOrNull((p) => p.isPopular);
          selectedPackageId.value = popular?.id ?? packages.first.id;
        }
      }
    } catch (_) {
      // Pertahankan fallback jika error
    } finally {
      isLoading.value = false;
    }
  }

  PricingPackageModel? get selectedPackage {
    return packages.firstWhereOrNull(
          (package) => package.id == selectedPackageId.value,
        ) ??
        (packages.isNotEmpty ? packages.first : null);
  }

  void selectPackage(String packageId) {
    selectedPackageId.value = packageId;
  }

  void goToPackages() {
    currentStep.value = 1;
  }

  void continueToCheckout() {
    currentStep.value = 2;
  }

  Future<void> subscribeCurrentPackage() async {
    final pkg = selectedPackage;
    if (pkg == null) {
      return;
    }
    await subscribePackage(pkg);
  }

  Future<void> subscribePackage(PricingPackageModel pkg) async {
    selectedPackageId.value = pkg.id;
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;

    if (user == null) {
      Get.snackbar(
        'Perlu Masuk',
        'Silakan masuk atau daftar terlebih dahulu untuk berlangganan.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    isLoading.value = true;

    try {
      final name = user.userMetadata?['full_name']?.toString() ??
          user.userMetadata?['name']?.toString() ??
          (user.email?.contains('@') == true
              ? user.email!.split('@').first
              : 'Xplorer');

      await client.from('profiles').upsert({
        'id': user.id,
        'email': user.email,
        'name': name,
        'status': 'premium',
        'subscription_tier': pkg.title,
        'updated_at': DateTime.now().toIso8601String(),
      });

      Get.snackbar(
        'Berlangganan Berhasil! 🎉',
        'Selamat! Anda telah resmi mengaktifkan paket ${pkg.title}.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );

      if (Get.isRegistered<ProfileController>()) {
        Get.find<ProfileController>().loadUserProfileFromDb();
      }

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Gagal Berlangganan',
        'Terjadi kendala saat memperbarui status langganan: $e',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
