import 'package:get/get.dart';
import 'package:kimiaxplore/app/modules/auth/bindings/auth_binding.dart';
import 'package:kimiaxplore/app/modules/auth/views/login_view.dart';
import 'package:kimiaxplore/app/modules/auth/views/register_view.dart';
import 'package:kimiaxplore/app/modules/flashcard/bindings/flashcard_binding.dart';
import 'package:kimiaxplore/app/modules/flashcard/views/flashcard_view.dart';
import 'package:kimiaxplore/app/modules/main/bindings/main_binding.dart';
import 'package:kimiaxplore/app/modules/main/views/main_view.dart';
import 'package:kimiaxplore/app/modules/material/bindings/material_binding.dart';
import 'package:kimiaxplore/app/modules/material/views/material_view.dart';
import 'package:kimiaxplore/app/modules/quiz/bindings/quiz_binding.dart';
import 'package:kimiaxplore/app/modules/quiz/views/quiz_view.dart';
import 'package:kimiaxplore/app/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:kimiaxplore/app/modules/onboarding/views/onboarding_view.dart';
import 'package:kimiaxplore/app/modules/topic/bindings/topic_binding.dart';
import 'package:kimiaxplore/app/modules/topic/views/topic_view.dart';
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
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.topic,
      page: () => const TopicView(),
      binding: TopicBinding(),
    ),
    GetPage(
      name: AppRoutes.material,
      page: () => const MaterialView(),
      binding: MaterialBinding(),
    ),
    GetPage(
      name: AppRoutes.quiz,
      page: () => const QuizView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: AppRoutes.flashcard,
      page: () => const FlashcardView(),
      binding: FlashcardBinding(),
    ),
  ];
}
