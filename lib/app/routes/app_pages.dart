import 'package:get/get.dart';
import 'package:kimiaxplore/app/modules/achievement/bindings/achievement_binding.dart';
import 'package:kimiaxplore/app/modules/achievement/views/achievement_view.dart';
import 'package:kimiaxplore/app/modules/ai_tutor/views/ai_chat_history_view.dart';
import 'package:kimiaxplore/app/modules/auth/bindings/auth_binding.dart';
import 'package:kimiaxplore/app/modules/auth/views/login_view.dart';
import 'package:kimiaxplore/app/modules/auth/views/register_view.dart';
import 'package:kimiaxplore/app/modules/flashcard/bindings/flashcard_binding.dart';
import 'package:kimiaxplore/app/modules/flashcard/views/flashcard_view.dart';
import 'package:kimiaxplore/app/modules/main/bindings/main_binding.dart';
import 'package:kimiaxplore/app/modules/main/views/main_view.dart';
import 'package:kimiaxplore/app/modules/material/bindings/material_binding.dart';
import 'package:kimiaxplore/app/modules/material/views/material_view.dart';
import 'package:kimiaxplore/app/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:kimiaxplore/app/modules/onboarding/views/onboarding_view.dart';
import 'package:kimiaxplore/app/modules/profile/bindings/profile_binding.dart';
import 'package:kimiaxplore/app/modules/profile/views/profile_view.dart';
import 'package:kimiaxplore/app/modules/quiz/bindings/quiz_binding.dart';
import 'package:kimiaxplore/app/modules/quiz/views/quiz_view.dart';
import 'package:kimiaxplore/app/modules/settings/bindings/settings_binding.dart';
import 'package:kimiaxplore/app/modules/settings/views/settings_view.dart';
import 'package:kimiaxplore/app/modules/teacher_tutor/bindings/teacher_tutor_binding.dart';
import 'package:kimiaxplore/app/modules/teacher_tutor/views/teacher_tutor_view.dart';
import 'package:kimiaxplore/app/modules/simulation/bindings/simulation_binding.dart';
import 'package:kimiaxplore/app/modules/simulation/views/simulation_view.dart';
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
    GetPage(
      name: AppRoutes.simulation,
      page: () => const SimulationView(),
      binding: SimulationBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.achievement,
      page: () => const AchievementView(),
      binding: AchievementBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.aiChatHistory,
      page: () => const AiChatHistoryView(),
    ),
    GetPage(
      name: AppRoutes.teacherTutor,
      page: () => const TeacherTutorView(),
      binding: TeacherTutorBinding(),
    ),
  ];
}
