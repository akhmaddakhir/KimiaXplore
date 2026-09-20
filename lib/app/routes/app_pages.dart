import 'package:get/get.dart';
import 'package:kimiaxplore/app/modules/auth/bindings/auth_binding.dart';
import 'package:kimiaxplore/app/modules/auth/views/register_view.dart';
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
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
  ];
}
