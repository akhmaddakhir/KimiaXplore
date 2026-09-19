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
}

class OnboardingOption {
  final String id;
  final String title;

  const OnboardingOption({required this.id, required this.title});
}
