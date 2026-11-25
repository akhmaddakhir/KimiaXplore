import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/ai_chat_history_service.dart';
import '../../../services/app_language_service.dart';
import '../../../services/gemini_service.dart';
import '../models/ai_chat_message.dart';
import '../models/ai_chat_session.dart';

class AiTutorController extends GetxController {
  final GeminiService _geminiService = GeminiService();
  final AiChatHistoryService _historyService = AiChatHistoryService();
  final AppLanguageService _languageService = Get.find<AppLanguageService>();

  final messages = <AiChatMessage>[].obs;
  final sessions = <AiChatSession>[].obs;

  final currentSessionId = RxnString();
  final currentSessionTitle = RxnString();

  final isChatOpen = false.obs;
  final isSending = false.obs;
  final isLoadingHistory = false.obs;

  final chatLanguage = RxnString();

  String get activeChatLanguage {
    return chatLanguage.value ?? _languageService.selectedLanguage.value;
  }

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {
    isLoadingHistory.value = true;
    try {
      final list = await _historyService.getSessions();
      sessions.assignAll(list);
    } finally {
      isLoadingHistory.value = false;
    }
  }

  Future<void> sendMessage(String message) async {
    final text = message.trim();

    if (text.isEmpty || isSending.value) {
      return;
    }

    if (chatLanguage.value == null) {
      chatLanguage.value = _languageService.selectedLanguage.value;
    }

    final language = chatLanguage.value ?? 'ID';

    if (currentSessionId.value == null) {
      currentSessionId.value =
          'session_${DateTime.now().millisecondsSinceEpoch}';
      final clean = text.replaceAll('\n', ' ').trim();
      currentSessionTitle.value =
          clean.length > 35 ? '${clean.substring(0, 32)}...' : clean;
    }

    messages.add(AiChatMessage(text: text, isUser: true));
    isChatOpen.value = true;
    await _persistCurrentSession();

    isSending.value = true;

    try {
      final reply = await _geminiService.generateReply(
        List<AiChatMessage>.from(messages),
        language: language,
      );

      messages.add(AiChatMessage(text: reply, isUser: false));
      await _persistCurrentSession();
    } on GeminiException catch (error) {
      final prefix = language == 'EN'
          ? 'Kimi cannot answer right now.'
          : 'Kimi belum bisa menjawab sekarang.';

      messages.add(
        AiChatMessage(text: '$prefix\n\n${error.message}', isUser: false),
      );
      await _persistCurrentSession();
    } catch (error) {
      final msg = language == 'EN'
          ? 'Kimi encountered an unexpected error.'
          : 'Kimi mengalami kesalahan yang tidak terduga.';

      messages.add(AiChatMessage(text: '$msg\n\n$error', isUser: false));
      await _persistCurrentSession();
    } finally {
      isSending.value = false;
    }
  }

  Future<void> _persistCurrentSession() async {
    final sessionId = currentSessionId.value;
    if (sessionId == null || messages.isEmpty) return;

    final firstUserMsg = messages.firstWhereOrNull((m) => m.isUser);
    String title = currentSessionTitle.value ?? '';
    if (title.isEmpty && firstUserMsg != null) {
      final clean = firstUserMsg.text.replaceAll('\n', ' ').trim();
      title = clean.length > 35 ? '${clean.substring(0, 32)}...' : clean;
      currentSessionTitle.value = title;
    }

    final existingSession =
        sessions.firstWhereOrNull((s) => s.id == sessionId);
    final session = AiChatSession(
      id: sessionId,
      title: title.isEmpty ? 'Percakapan Kimia' : title,
      createdAt: existingSession?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
      messages: List<AiChatMessage>.from(messages),
    );

    await _historyService.saveSession(session);
    final updated = await _historyService.getSessions();
    sessions.assignAll(updated);
  }

  void loadSession(AiChatSession session) {
    currentSessionId.value = session.id;
    currentSessionTitle.value = session.title;
    messages.assignAll(session.messages);
    isChatOpen.value = true;
  }

  Future<void> deleteSession(String sessionId) async {
    await _historyService.deleteSession(sessionId);
    sessions.removeWhere((s) => s.id == sessionId);
    if (currentSessionId.value == sessionId) {
      openNewChat();
    }
  }

  Future<void> clearAllHistory() async {
    await _historyService.clearAllSessions();
    sessions.clear();
    openNewChat();
  }

  void openNewChat() {
    if (isSending.value) {
      return;
    }

    currentSessionId.value = null;
    currentSessionTitle.value = null;
    messages.clear();
    chatLanguage.value = null;
    isChatOpen.value = false;
  }

  void openAttachment() {
    Get.snackbar(
      'ai_photo_title'.tr,
      'ai_photo_unavailable'.tr,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  void openHistory() {
    loadHistory();
    Get.toNamed(AppRoutes.aiChatHistory);
  }
}
