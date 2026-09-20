import '../models/onboarding_question.dart';

abstract final class OnboardingQuestions {
  static const List<OnboardingQuestion> items = [
    OnboardingQuestion(
      id: 'discovery_source',
      title: 'Darimana tau KimiaXplore?',
      isRequired: false,
      options: [
        OnboardingOption(id: 'instagram', title: 'Instagram'),
        OnboardingOption(id: 'tiktok', title: 'Tiktok'),
        OnboardingOption(
          id: 'friends_family',
          title: 'Teman atau orang terdekat',
        ),
        OnboardingOption(id: 'google_search', title: 'Google search'),
        OnboardingOption(id: 'website_blog', title: 'Website/blog'),
        OnboardingOption(id: 'other', title: 'Lainnya'),
      ],
    ),

    OnboardingQuestion(
      id: 'chemistry_level',
      title: 'Sejauh mana kamu kenal kimia?',
      options: [
        OnboardingOption(id: 'beginner', title: 'Baru kenalan'),
        OnboardingOption(id: 'intermediate', title: 'Udah tau dikit'),
        OnboardingOption(id: 'advanced', title: 'Lumayan paham'),
        OnboardingOption(id: 'expert', title: 'Kimia? Makanan sehari-hari 😎'),
      ],
    ),

    OnboardingQuestion(
      id: 'learning_goal',
      title: 'Mau ngapain di KimiaXplore?',
      options: [
        OnboardingOption(id: 'learn_basics', title: 'Belajar dari nol'),
        OnboardingOption(id: 'improve', title: 'Biar makin paham'),
        OnboardingOption(id: 'exam', title: 'Persiapan ulangan'),
        OnboardingOption(id: 'practice', title: 'Latihan soal'),
        OnboardingOption(id: 'simulation', title: 'Belajar lewat simulasi'),
        OnboardingOption(id: 'explore', title: 'Iseng xplore aja'),
        OnboardingOption(
          id: 'survive',
          title: 'Biar nggak pusing sama kimia 😭',
        ),
      ],
    ),

    OnboardingQuestion(
      id: 'learning_preference',
      title: 'Kamu paling suka belajar gimana?',
      options: [
        OnboardingOption(id: 'reading', title: 'Baca materi'),
        OnboardingOption(id: 'simulation', title: 'Cobain simulasi'),
        OnboardingOption(
          id: 'challenge',
          title: 'Belajar sambil ngerjain soal',
        ),
        OnboardingOption(id: 'flashcard', title: 'Hafalan pakai kartu'),
        OnboardingOption(id: 'mixed', title: 'Apa aja, yang penting paham 😎'),
      ],
    ),
  ];
}
