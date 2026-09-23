import 'package:get/get.dart';

class OnboardingQuestion {
  final String id;
  final String title;
  final List<OnboardingOption> options;
  final bool isRequired;

  const OnboardingQuestion({
    required this.id,
    required this.title,
    required this.options,
    this.isRequired = true,
  });

  String get localizedTitle {
    final key = 'onboarding_q_$id';
    final translated = key.tr;
    return translated != key ? translated : title;
  }
}

class OnboardingOption {
  final String id;
  final String title;

  const OnboardingOption({required this.id, required this.title});

  String get localizedTitle {
    final key = 'onboarding_opt_$id';
    final translated = key.tr;
    return translated != key ? translated : title;
  }
}
