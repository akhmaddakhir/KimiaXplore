import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kimiaxplore/app/localization/app_translations.dart';
import 'package:kimiaxplore/app/modules/home/data/home_topics.dart';
import 'package:kimiaxplore/app/modules/lab/data/lab_simulations.dart';

void main() {
  setUp(() {
    Get.addTranslations(AppTranslations().keys);
  });

  group('Localization EN / ID', () {
    test('English mode translates key UI terms', () {
      Get.updateLocale(const Locale('en', 'US'));

      expect('nav_home'.tr, 'Home');
      expect('nav_lab'.tr, 'Lab');
      expect('nav_ai_tutor'.tr, 'AI Tutor');
      expect('nav_shop'.tr, 'Shop');
      expect('nav_profile'.tr, 'Profile');

      expect('settings_title'.tr, 'Settings');
      expect('settings_logout'.tr, 'Log out');

      expect('quiz_check'.tr, 'Check');
      expect('quiz_continue'.tr, 'Continue');
      expect('quiz_finish'.tr, 'Complete');

      expect('flashcard_memorized'.tr, 'Memorized');
      expect('flashcard_need_practice'.tr, 'Need Practice');
      expect('flashcard_completed_title'.tr, 'Flashcards Completed!');

      expect('lab_simulations'.tr, 'Chemistry Simulations');
      expect('shop_choose_plan'.tr, 'Choose Premium Plan');
      expect('welcome_start'.tr, 'Get Started');
      expect('auth_login'.tr, 'Log in');
      expect('auth_ready_start'.tr, 'Ready to Start?');
    });

    test(
      'Topic and Simulation models provide localized titles and descriptions',
      () {
        Get.updateLocale(const Locale('en', 'US'));

        final topic = HomeTopics.items.firstWhere(
          (t) => t.id == 'atomic_structure',
        );
        expect(topic.localizedTitle, 'Atomic Structure');
        expect(topic.localizedLevel, 'Basic');

        final simulation = LabSimulations.items.firstWhere(
          (s) => s.id == 'periodic_table',
        );
        expect(simulation.localizedTitle, 'Periodic Table');
        expect(
          simulation.localizedDescription,
          'Explore chemical elements and discover their properties.',
        );
      },
    );

    test('Indonesian mode preserves Indonesian text', () {
      Get.updateLocale(const Locale('id', 'ID'));

      expect('nav_home'.tr, 'Home');
      expect('quiz_check'.tr, 'Cek');
      expect('flashcard_memorized'.tr, 'Hafal');
      expect('welcome_start'.tr, 'Mulai');

      final topic = HomeTopics.items.firstWhere(
        (t) => t.id == 'atomic_structure',
      );
      expect(topic.localizedTitle, 'Struktur Atom');
      expect(topic.localizedLevel, 'Dasar');
    });
  });
}
