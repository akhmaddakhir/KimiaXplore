import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/app_language_service.dart';
import '../../../services/auth_service.dart';
import '../../profile/views/profile_account_view.dart';

class SettingsController extends GetxController {
  final AuthService _authService = AuthService();

  final AppLanguageService _languageService = Get.find<AppLanguageService>();

  final isDarkMode = false.obs;
  final isLoggingOut = false.obs;

  RxString get selectedLanguage {
    return _languageService.selectedLanguage;
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
  }

  Future<void> selectLanguage(String language) async {
    await _languageService.setLanguage(language);
  }

  void openAccount() {
    Get.to(() => const ProfileAccountView());
  }

  void openPurchaseHistory() {
    Get.snackbar(
      'purchase_history_title'.tr,
      'purchase_history_unavailable'.tr,
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
        title: Text('logout_title'.tr),
        content: Text('logout_description'.tr),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: Text('settings_logout'.tr),
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
        'logout_failed_title'.tr,
        'logout_failed_description'.tr,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoggingOut.value = false;
    }
  }
}
