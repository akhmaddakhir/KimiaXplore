import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/gemini_service.dart';
import '../models/ai_chat_message.dart';

class AiTutorController extends GetxController {
  final GeminiService _geminiService = GeminiService();

  final messages = <AiChatMessage>[].obs;

  final isChatOpen = false.obs;
  final isSending = false.obs;

  Future<void> sendMessage(String message) async {
    final text = message.trim();

    if (text.isEmpty || isSending.value) {
      return;
    }

    messages.add(AiChatMessage(text: text, isUser: true));

    isChatOpen.value = true;
    isSending.value = true;

    try {
      final reply = await _geminiService.generateReply(
        List<AiChatMessage>.from(messages),
      );

      messages.add(AiChatMessage(text: reply, isUser: false));
    } on GeminiException catch (error) {
      messages.add(
        AiChatMessage(
          text: 'Kimi belum bisa menjawab sekarang.\n\n${error.message}',
          isUser: false,
        ),
      );
    } catch (error) {
      messages.add(
        AiChatMessage(
          text: 'Kimi mengalami kesalahan yang tidak terduga.\n\n$error',
          isUser: false,
        ),
      );
    } finally {
      isSending.value = false;
    }
  }

  void openNewChat() {
    if (isSending.value) {
      return;
    }

    messages.clear();
    isChatOpen.value = false;
  }

  void openAttachment() {
    Get.snackbar(
      'Foto soal',
      'Fitur analisis foto soal akan ditambahkan setelah chat teks selesai.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  void openHistory() {
    Get.snackbar(
      'Riwayat Chat',
      'Riwayat percakapan akan ditambahkan nanti.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }
}
