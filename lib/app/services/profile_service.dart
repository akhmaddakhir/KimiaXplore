import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> ensureProfile({
    required String userId,
    required String email,
    Map<String, String>? onboardingAnswers,
  }) async {
    final existingProfile = await _client
        .from('profiles')
        .select('id')
        .eq('id', userId)
        .maybeSingle();

    final profileData = <String, dynamic>{'email': email};

    final discoverySource = onboardingAnswers?['discovery_source'];
    final chemistryLevel = onboardingAnswers?['chemistry_level'];
    final learningGoal = onboardingAnswers?['learning_goal'];
    final learningPreference = onboardingAnswers?['learning_preference'];

    if (discoverySource != null) {
      profileData['source'] = discoverySource;
    }

    if (chemistryLevel != null) {
      profileData['chemistry_level'] = chemistryLevel;
    }

    if (learningGoal != null) {
      profileData['learning_goal'] = learningGoal;
    }

    if (learningPreference != null) {
      profileData['learning_style'] = learningPreference;
    }

    if (existingProfile == null) {
      await _client.from('profiles').insert({'id': userId, ...profileData});

      return;
    }

    if (onboardingAnswers != null && onboardingAnswers.isNotEmpty) {
      await _client.from('profiles').update(profileData).eq('id', userId);
    }
  }
}
