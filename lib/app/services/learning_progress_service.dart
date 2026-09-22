import 'package:supabase_flutter/supabase_flutter.dart';

class LearningProgressService {
  final SupabaseClient _client = Supabase.instance.client;

  String? get currentUserId => _client.auth.currentUser?.id;

  Future<void> markActivityOpened({
    required String topicId,
    required String activityType,
    required String activityId,
  }) async {
    final userId = currentUserId;

    if (userId == null) {
      return;
    }

    final existingProgress = await _client
        .from('learning_progress')
        .select('id')
        .eq('user_id', userId)
        .eq('activity_type', activityType)
        .eq('activity_id', activityId)
        .maybeSingle();

    final now = DateTime.now().toIso8601String();

    if (existingProgress == null) {
      await _client.from('learning_progress').insert({
        'user_id': userId,
        'topic_id': topicId,
        'activity_type': activityType,
        'activity_id': activityId,
        'last_opened_at': now,
        'updated_at': now,
      });

      return;
    }

    await _client
        .from('learning_progress')
        .update({'last_opened_at': now, 'updated_at': now})
        .eq('user_id', userId)
        .eq('activity_type', activityType)
        .eq('activity_id', activityId);
  }

  Future<void> saveActivityProgress({
    required String topicId,
    required String activityType,
    required String activityId,
    required int progress,
    required int total,
    bool isCompleted = false,
    int? score,
  }) async {
    final userId = currentUserId;

    if (userId == null) {
      return;
    }

    final existingProgress = await _client
        .from('learning_progress')
        .select('id')
        .eq('user_id', userId)
        .eq('activity_type', activityType)
        .eq('activity_id', activityId)
        .maybeSingle();

    final now = DateTime.now().toIso8601String();

    final data = <String, dynamic>{
      'topic_id': topicId,
      'progress': progress,
      'total': total,
      'is_completed': isCompleted,
      'last_opened_at': now,
      'updated_at': now,
      'completed_at': isCompleted ? now : null,
    };

    if (score != null) {
      data['score'] = score;
    }

    if (existingProgress == null) {
      await _client.from('learning_progress').insert({
        'user_id': userId,
        'activity_type': activityType,
        'activity_id': activityId,
        ...data,
      });

      return;
    }

    await _client
        .from('learning_progress')
        .update(data)
        .eq('user_id', userId)
        .eq('activity_type', activityType)
        .eq('activity_id', activityId);
  }

  Future<void> completeActivity({
    required String topicId,
    required String activityType,
    required String activityId,
    int? score,
    int? progress,
    int? total,
  }) async {
    final userId = currentUserId;

    if (userId == null) {
      return;
    }

    final existingProgress = await _client
        .from('learning_progress')
        .select('id')
        .eq('user_id', userId)
        .eq('activity_type', activityType)
        .eq('activity_id', activityId)
        .maybeSingle();

    final now = DateTime.now().toIso8601String();

    final data = <String, dynamic>{
      'topic_id': topicId,
      'is_completed': true,
      'last_opened_at': now,
      'completed_at': now,
      'updated_at': now,
    };

    if (score != null) {
      data['score'] = score;
    }

    if (progress != null) {
      data['progress'] = progress;
    }

    if (total != null) {
      data['total'] = total;
    }

    if (existingProgress == null) {
      await _client.from('learning_progress').insert({
        'user_id': userId,
        'activity_type': activityType,
        'activity_id': activityId,
        ...data,
      });

      return;
    }

    await _client
        .from('learning_progress')
        .update(data)
        .eq('user_id', userId)
        .eq('activity_type', activityType)
        .eq('activity_id', activityId);
  }

  Future<bool> isActivityCompleted({
    required String activityType,
    required String activityId,
  }) async {
    final userId = currentUserId;

    if (userId == null) {
      return false;
    }

    final data = await _client
        .from('learning_progress')
        .select('is_completed')
        .eq('user_id', userId)
        .eq('activity_type', activityType)
        .eq('activity_id', activityId)
        .maybeSingle();

    if (data == null) {
      return false;
    }

    return data['is_completed'] == true;
  }

  Future<Set<String>> getCompletedActivityIds({
    required String topicId,
    required String activityType,
  }) async {
    final userId = currentUserId;

    if (userId == null) {
      return {};
    }

    final data = await _client
        .from('learning_progress')
        .select('activity_id')
        .eq('user_id', userId)
        .eq('topic_id', topicId)
        .eq('activity_type', activityType)
        .eq('is_completed', true);

    return data.map<String>((item) => item['activity_id'] as String).toSet();
  }

  Future<List<Map<String, dynamic>>> getTopicProgress(String topicId) async {
    final userId = currentUserId;

    if (userId == null) {
      return [];
    }

    final data = await _client
        .from('learning_progress')
        .select()
        .eq('user_id', userId)
        .eq('topic_id', topicId)
        .order('updated_at', ascending: false);

    return List<Map<String, dynamic>>.from(data);
  }

  Future<List<Map<String, dynamic>>> getCompletedMaterials() async {
    final userId = currentUserId;

    if (userId == null) {
      return [];
    }

    final data = await _client
        .from('learning_progress')
        .select()
        .eq('user_id', userId)
        .eq('activity_type', 'material')
        .eq('is_completed', true)
        .order('completed_at', ascending: false);

    return List<Map<String, dynamic>>.from(data);
  }

  Future<Map<String, dynamic>?> getLastActivity() async {
    final userId = currentUserId;

    if (userId == null) {
      return null;
    }

    final data = await _client
        .from('learning_progress')
        .select()
        .eq('user_id', userId)
        .order('last_opened_at', ascending: false)
        .limit(1);

    if (data.isEmpty) {
      return null;
    }

    return Map<String, dynamic>.from(data.first);
  }
}
