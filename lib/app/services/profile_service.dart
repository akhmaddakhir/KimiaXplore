import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> createProfile({
    required String userId,
    required String email,
    Map<String, String>? onboardingAnswers,
  }) async {
    await _client.from('profiles').insert({
      'id': userId,
      'email': email,
      'source': onboardingAnswers?['discovery_source'],
      'chemistry_level': onboardingAnswers?['chemistry_level'],
      'learning_goal': onboardingAnswers?['learning_goal'],
      'learning_style': onboardingAnswers?['learning_preference'],
    });
  }
}
