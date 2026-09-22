import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../profile/views/profile_account_view.dart';

class SettingsController extends GetxController {
  final AuthService _authService = AuthService();

  final isDarkMode = false.obs;
  final selectedLanguage = 'ID'.obs;
  final isLoggingOut = false.obs;

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
  }

  void selectLanguage(String language) {
    selectedLanguage.value = language;
  }

  void openAccount() {
    Get.to(() => const ProfileAccountView());
  }

  void openPurchaseHistory() {
    Get.snackbar(
      'Riwayat Pembelian',
      'Riwayat pembelian akan ditambahkan nanti.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  Future<void> confirmLogout() async {
    if (isLoggingOut.value) {
      return;
    }

    final shouldLogout = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Log out?'),
        content: const Text(
          'Kamu perlu masuk lagi untuk menggunakan akun KimiaXplore.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      await logout();
    }
  }

  Future<void> logout() async {
    if (isLoggingOut.value) {
      return;
    }

    try {
      isLoggingOut.value = true;

      await _authService.logout();

      Get.offAllNamed(AppRoutes.welcome);
    } catch (_) {
      Get.snackbar(
        'Logout gagal',
        'Terjadi kesalahan saat keluar dari akun.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoggingOut.value = false;
    }
  }
}
