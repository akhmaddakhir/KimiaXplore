import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modules/ai_tutor/models/ai_chat_session.dart';

class AiChatHistoryService {
  static const String _storageKey = 'kimiaxplore_ai_chat_sessions';

  Future<List<AiChatSession>> getSessions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rawJson = prefs.getString(_storageKey);

      if (rawJson == null || rawJson.trim().isEmpty) {
        return [];
      }

      final decoded = jsonDecode(rawJson) as List<dynamic>;
      final sessions = decoded
          .map((item) => AiChatSession.fromJson(item as Map<String, dynamic>))
          .toList();

      // Sort newest first
      sessions.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return sessions;
    } catch (e) {
      debugPrint('Error getting AI chat history: $e');
      return [];
    }
  }

  Future<void> saveSession(AiChatSession session) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessions = await getSessions();

      final existingIndex = sessions.indexWhere((s) => s.id == session.id);
      if (existingIndex >= 0) {
        sessions[existingIndex] = session;
      } else {
        sessions.insert(0, session);
      }

      sessions.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      final encoded = jsonEncode(sessions.map((s) => s.toJson()).toList());
      await prefs.setString(_storageKey, encoded);
    } catch (e) {
      debugPrint('Error saving AI chat session: $e');
    }
  }

  Future<void> deleteSession(String sessionId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessions = await getSessions();

      sessions.removeWhere((s) => s.id == sessionId);

      final encoded = jsonEncode(sessions.map((s) => s.toJson()).toList());
      await prefs.setString(_storageKey, encoded);
    } catch (e) {
      debugPrint('Error deleting AI chat session: $e');
    }
  }

  Future<void> clearAllSessions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
    } catch (e) {
      debugPrint('Error clearing AI chat sessions: $e');
    }
  }
}

