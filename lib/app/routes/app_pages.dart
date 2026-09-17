import 'package:get/get.dart';
import 'package:kimiaxplore/app/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:kimiaxplore/app/modules/onboarding/views/onboarding_view.dart';

import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
  ];
}