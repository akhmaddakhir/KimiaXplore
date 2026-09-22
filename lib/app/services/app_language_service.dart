import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageService extends GetxService {
  static const String _storageKey = 'app_language';

  final selectedLanguage = 'ID'.obs;

  Future<AppLanguageService> init() async {
    final preferences = await SharedPreferences.getInstance();

    final savedLanguage = preferences.getString(_storageKey);

    if (savedLanguage == 'EN') {
      selectedLanguage.value = 'EN';
    } else {
      selectedLanguage.value = 'ID';
    }

    return this;
  }

  Locale get locale {
    if (selectedLanguage.value == 'EN') {
      return const Locale('en', 'US');
    }

    return const Locale('id', 'ID');
  }

  bool get isEnglish {
    return selectedLanguage.value == 'EN';
  }

  bool get isIndonesian {
    return selectedLanguage.value == 'ID';
  }

  Future<void> setLanguage(String language) async {
    final normalizedLanguage = language.toUpperCase();

    if (normalizedLanguage != 'ID' && normalizedLanguage != 'EN') {
      return;
    }

    if (selectedLanguage.value == normalizedLanguage) {
      return;
    }

    selectedLanguage.value = normalizedLanguage;

    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(_storageKey, normalizedLanguage);

    await Get.updateLocale(locale);
  }
}
