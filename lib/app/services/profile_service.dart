import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> ensureProfile({
    required String userId,
    required String email,
    String? name,
    Map<String, String>? onboardingAnswers,
  }) async {
    final existingProfile = await _client
        .from('profiles')
        .select('id, name')
        .eq('id', userId)
        .maybeSingle();

    final user = _client.auth.currentUser;
    final metadata = user?.userMetadata ?? {};
    final fullName = metadata['full_name']?.toString().trim();
    final metaName = metadata['name']?.toString().trim();

    final resolvedName = (name != null && name.trim().isNotEmpty)
        ? name.trim()
        : (fullName != null && fullName.isNotEmpty
            ? fullName
            : (metaName != null && metaName.isNotEmpty
                ? metaName
                : (email.contains('@') ? email.split('@').first : 'Xplorer')));

    final profileData = <String, dynamic>{
      'email': email,
      'name': resolvedName,
    };

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

    if (existingProfile['name'] == null ||
        (onboardingAnswers != null && onboardingAnswers.isNotEmpty)) {
      await _client.from('profiles').update(profileData).eq('id', userId);
    }
  }
}
