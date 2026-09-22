import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/app_language_service.dart';
import '../../../services/gemini_service.dart';
import '../models/ai_chat_message.dart';

class AiTutorController extends GetxController {
  final GeminiService _geminiService = GeminiService();

  final AppLanguageService _languageService = Get.find<AppLanguageService>();

  final messages = <AiChatMessage>[].obs;

  final isChatOpen = false.obs;
  final isSending = false.obs;

  final chatLanguage = RxnString();

  String get activeChatLanguage {
    return chatLanguage.value ?? _languageService.selectedLanguage.value;
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

    messages.add(AiChatMessage(text: text, isUser: true));

    isChatOpen.value = true;
    isSending.value = true;

    try {
      final reply = await _geminiService.generateReply(
        List<AiChatMessage>.from(messages),
        language: language,
      );

      messages.add(AiChatMessage(text: reply, isUser: false));
    } on GeminiException catch (error) {
      final prefix = language == 'EN'
          ? 'Kimi cannot answer right now.'
          : 'Kimi belum bisa menjawab sekarang.';

      messages.add(
        AiChatMessage(text: '$prefix\n\n${error.message}', isUser: false),
      );
    } catch (error) {
      final message = language == 'EN'
          ? 'Kimi encountered an unexpected error.'
          : 'Kimi mengalami kesalahan yang tidak terduga.';

      messages.add(AiChatMessage(text: '$message\n\n$error', isUser: false));
    } finally {
      isSending.value = false;
    }
  }

  void openNewChat() {
    if (isSending.value) {
      return;
    }

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
    Get.snackbar(
      'ai_history_title'.tr,
      'ai_history_unavailable'.tr,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }
}
