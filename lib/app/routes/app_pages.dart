import 'package:get/get.dart';
import 'package:kimiaxplore/app/modules/auth/bindings/auth_binding.dart';
import 'package:kimiaxplore/app/modules/auth/views/login_view.dart';
import 'package:kimiaxplore/app/modules/auth/views/register_view.dart';
import 'package:kimiaxplore/app/modules/home/bindings/home_binding.dart';
import 'package:kimiaxplore/app/modules/home/views/home_view.dart';
import 'package:kimiaxplore/app/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:kimiaxplore/app/modules/onboarding/views/onboarding_view.dart';
import 'package:kimiaxplore/app/modules/welcome/bindings/welcome_binding.dart';
import 'package:kimiaxplore/app/modules/welcome/views/welcome_view.dart';

import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding('register'),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding('login'),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
